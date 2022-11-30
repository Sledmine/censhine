local argparse = require "argparse"
local glue = require "glue"
local inspect = require "inspect"
local fs = require "fs"
require "compat53"
local vertexShaderNames = require"src.lua.constants".vertexShaderNames
local pixelShaderFunctionMapping = require"src.lua.constants".pixelShaderFunctionMapping
local binaries                   = require "src.lua.binaries"

local fxcPath = binaries.fxc
local fxCompilerCommand = fxcPath .. [[ %s /nologo /I "src/game/rasterizer/dx9/shaders/pixel/include" /E %s /T %s /Fo %s]]
local decompilerCommand = fxcPath .. [[ %s /nologo /dumpbin /Fx %s]]

--- Normalize any string to camel case
---@param str string
function toCamelCase(str)
    str = "_" .. str
    return string.gsub(str:gsub("_", " "), "%W%l", string.upper):sub(1):gsub(" ", "")
end
local function byte(input)
    return string.unpack("B", input)
end
local function wbyte(input)
    return string.pack("B", input)
end
local function uint16(input)
    return string.unpack("H", input)
end
local function wuint16(input)
    return string.pack("H", input)
end
local function uint32(input)
    return string.unpack("I", input)
end
local function wuint32(input)
    return string.pack("I", input)
end

local parser = argparse("compileCEShaders", "Compile CE shaders")
parser:argument("shadersPath", "Path to the source shader file")
parser:argument("entryPoint", "Entry point name for the shader"):args("?")
parser:argument("shadeFunctionName", "Shader function name"):args("?")
parser:flag("--decompile", "Allow shader decompilation for debugging")
parser:flag("--vertex", "Compile vertex shaders")
parser:flag("--compatible", "Compile shaders using backwards compatible flag")
parser:flag("--keepversion", "Keep shader version in the output file")
parser:flag("--disable", "Disable shader at compilation, it will appear black in game")
parser:flag("--ps30", "Compile shader for shader 3_0")
local args = parser:parse()

local pixelShaderVersion = "2_0"
local shaderClass = "ps"
local splitPath = glue.string.split(args.shadersPath, "/")
local shadersFileName = splitPath[#splitPath]
local shadersOutput = "build/EffectCollection_ps_2_0/"
if args.shader3 then
    pixelShaderVersion = "3_0"
    shadersOutput = "build/EffectCollection_ps_3_0/"
end

local shaderBinaryName = shadersFileName:gsub(".psh", ""):gsub(".vsh", ""):gsub(".fx", "")
local shaderFilesPath = shadersOutput .. shaderBinaryName
local directXByteCodePathWithVersion = shaderFilesPath .. "/PS_%s_ps_%s_%s" .. ".dxbc"
local directXByteCodePath = shaderFilesPath .. "/PS_%s" .. ".dxbc"

if args.compatible then
    fxCompilerCommand = fxCompilerCommand .. [[ /Gec]]
end
if args.vertex then
    shaderClass = "vs"
    shadersOutput = "bin/shaders/vsh"
    fs.mkdir(shadersOutput)
    shaderFilesPath = shadersOutput
    directXByteCodePath = shaderFilesPath .. "/%s" .. ".dxbc"
else
    fs.mkdir(shaderFilesPath)
end

local function pixelShaderToDXBC(shaderPath, shaderFunctionName)
    local shader = io.open(shaderPath, "rb")
    if shader then
        local shaderFileString = glue.readfile(shaderPath, "b")
        local minorVersion = byte(shader:read(1))
        local majorVersion = byte(shader:read(1))
        local shaderDXBCClass = uint16(shader:read(2))

        local _, bytecodeOffset = shaderFileString:find(".3111\0")
        shader:seek("set", bytecodeOffset)

        local bytecode = shader:read("a")

        local dxbc = {wbyte(minorVersion), wbyte(majorVersion), wuint16(shaderDXBCClass), bytecode}
        local finalDxbcPath = directXByteCodePath:format(shaderFunctionName)
        if args.keepversion then
            finalDxbcPath = directXByteCodePathWithVersion:format(shaderFunctionName, majorVersion,
                                                                  minorVersion)
        end
        print(finalDxbcPath)
        glue.writefile(finalDxbcPath, table.concat(dxbc, ""), "b")
        debugPath = finalDxbcPath .. ".debug"
        return true
    end
    error("Error can not open shader file")
end

local function vertexShaderToDXBC(shaderPath)
    local shader = io.open(shaderPath, "rb")
    if shader then
        local shaderFileString = glue.readfile(shaderPath, "b")
        local minorVersion = byte(shader:read(1))
        local majorVersion = byte(shader:read(1))
        local shaderDXBCClass = uint16(shader:read(2))

        local _, bytecodeOffset = shaderFileString:find(".3111\0")
        shader:seek("set", bytecodeOffset)

        local bytecode = shader:read("a")

        local dxbc = {wbyte(minorVersion), wbyte(majorVersion), wuint16(shaderDXBCClass), bytecode}
        local finalDxbcPath = directXByteCodePath:format(shaderBinaryName)
        print(finalDxbcPath)
        glue.writefile(finalDxbcPath, table.concat(dxbc, ""), "b")
        debugPath = finalDxbcPath .. ".debug"
        return true
    end
    error("Error can not open shader file")
end

if args.vertex then
    local tempShaderPath = os.tmpname():gsub("/", "")
    local compileShaderCmd = fxCompilerCommand:format(args.shadersPath, "main",
                                                      shaderClass .. "_" .. pixelShaderVersion,
                                                      tempShaderPath)
    print(compileShaderCmd)
    if glue.readpipe(compileShaderCmd, "t"):find("compilation succeeded") then
        if pcall(vertexShaderToDXBC, tempShaderPath) then
            local cmd2 = decompilerCommand:format(tempShaderPath, debugPath)
            if args.decompile then
                os.execute(cmd2)
            end
        end
    else
        print("ERROR!!!, shader compilation failed")
        os.exit(1)
    end
    os.remove(tempShaderPath)
else
    local shaderCount = 1
    if pixelShaderFunctionMapping[shaderBinaryName] then
        shaderCount = #pixelShaderFunctionMapping[shaderBinaryName]
    end
    for shaderIndex = 1, shaderCount do
        local tempShaderPath = os.tmpname():gsub("/", "")
        local entryPoint = "main"
        local shaderFunctionName = toCamelCase(shaderBinaryName)
        local shaderPath = args.shadersPath
        if pixelShaderFunctionMapping[shaderBinaryName] then
            entryPoint = pixelShaderFunctionMapping[shaderBinaryName][shaderIndex][1]
            shaderFunctionName = pixelShaderFunctionMapping[shaderBinaryName][shaderIndex][2]
        end
        if args.disable then
            shaderPath = "src/game/rasterizer/dx9/shaders/pixel/general/disabled.fx"
            entryPoint = "main"
        end
        local compileShaderCmd = fxCompilerCommand:format(shaderPath, entryPoint,
                                                          shaderClass .. "_" .. pixelShaderVersion,
                                                          tempShaderPath)
        print(compileShaderCmd)
        if glue.readpipe(compileShaderCmd, "t"):find("compilation succeeded") then
            if pcall(pixelShaderToDXBC, tempShaderPath, shaderFunctionName) then
                local cmd2 = decompilerCommand:format(tempShaderPath, debugPath)
                if args.decompile then
                    os.execute(cmd2)
                end
            end
        else
            print("ERROR!!!, shader compilation failed")
            os.exit(1)
        end
        os.remove(tempShaderPath)
    end
end

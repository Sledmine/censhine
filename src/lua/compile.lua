local argparse = require "argparse"
local glue = require "glue"
local fs = require "fs"
require "compat53"
local luna = require "src.lua.lua_modules.luna"
local constants = require "src.lua.constants"
local vertexShaderNames = constants.vertexShaderNames
local pixelShaderFunctionMapping = constants.pixelShaderFunctionMapping
local binaries = constants.binaries
require "src.lua.censhine.binary"

local fxcPath = binaries.fxc
local fxCompilerCommand = fxcPath ..
                              [[ %s /nologo /I "src/game/rasterizer/dx9/shaders/pixel/include" /E %s /T %s /Fo %s]]
local decompilerCommand = fxcPath .. [[ %s /nologo /dumpbin /Fx %s]]
local shaderCompilationPath = "build/tmp/"

--- Normalize any string to camel case
---@param str string
function toCamelCase(str)
    str = "_" .. str
    return string.gsub(str:gsub("_", " "), "%W%l", string.upper):sub(1):gsub(" ", "")
end

local parser = argparse("compile", "Compile Halo Custom Edition shaders to dxbc files")
parser:argument("shadersPath", "Path to the source shader file")
parser:argument("entryPoint", "Entry point name for the shader"):args("?")
parser:argument("shadeFunctionName", "Shader function name"):args("?")
parser:flag("--decompile", "Allow shader decompilation for debugging")
parser:flag("--vertex", "Compile vertex shaders")
parser:flag("--compatible", "Compile shaders using backwards compatible flag")
parser:flag("--keepversion", "Keep shader version in the output file")
parser:flag("--disable", "Disable shader at compilation, it will appear black in game")
parser:flag("--s30", "Compile shader for shader 3_0")
local args = parser:parse()

local profileVersion = "2_0"
local profileClass = "ps"
local shaderByteCodeStartPattern = ".3111\0"
assert(fs.is(args.shadersPath), "Error: Shader file " .. args.shadersPath .. " does not exist")
local splitPath = args.shadersPath:split "/"
local shadersFileName = splitPath[#splitPath]
if args.s30 then
    profileVersion = "3_0"
end
local shaderCompiledExtension = ".cso"
local shadersOutput = "build/EffectCollection_" .. profileClass .. "_" .. profileVersion .. "/"

local shaderBinaryName = shadersFileName:replace(".psh", ""):replace(".vsh", ""):replace(".fx", "")
local shaderFilesPath = shadersOutput .. shaderBinaryName
local directXByteCodePathWithVersion = shaderFilesPath .. "/PS_%s_ps_%s_%s" .. shaderCompiledExtension
local directXByteCodePath = shaderFilesPath .. "/PS_%s" .. shaderCompiledExtension

if args.compatible then
    fxCompilerCommand = fxCompilerCommand .. [[ /Gec]]
end
if args.vertex then
    profileClass = "vs"
    shadersOutput = "build/vsh"
    shaderFilesPath = shadersOutput
    directXByteCodePath = shaderFilesPath .. "/%s" .. shaderCompiledExtension
    fxCompilerCommand = fxCompilerCommand:replace("pixel", "vertex")
end
fs.mkdir(shaderFilesPath, true)

--- Convert a shader file to a dxbc file
---@param shaderPath string
---@param shaderFunctionName string?
---@return boolean
local function shaderToDXBC(shaderPath, shaderFunctionName)
    local shader = io.open(shaderPath, "rb")
    assert(shader, "Error can not open shader file")

    local shaderFileString = glue.readfile(shaderPath, "b")
    assert(shaderFileString, "Error can not read shader file")

    local minorVersion = byte(shader:read(1))
    local majorVersion = byte(shader:read(1))
    local shaderDXBCClass = uint16(shader:read(2))

    local _, bytecodeOffset = shaderFileString:find(shaderByteCodeStartPattern)
    shader:seek("set", bytecodeOffset)

    local bytecode = shader:read("a")

    local dxbc = {wbyte(minorVersion), wbyte(majorVersion), wuint16(shaderDXBCClass), bytecode}
    local finalDxbcPath = directXByteCodePath:format(shaderFunctionName)
    if args.vertex then
        finalDxbcPath = directXByteCodePath:format(shaderBinaryName)
    end
    if not args.vertex and args.keepversion then
        finalDxbcPath = directXByteCodePathWithVersion:format(shaderFunctionName, majorVersion,
                                                              minorVersion)
    end
    --print("DXBC: ", finalDxbcPath)
    glue.writefile(finalDxbcPath, table.concat(dxbc, ""), "b")
    debugPath = finalDxbcPath .. ".debug"
    return true
end

fs.mkdir(shaderCompilationPath, true)

local function getTempCSOShaderPath()
    return shaderCompilationPath .. os.tmpname():replace("\\", ""):replace("/", ""):replace(".", "")
end


if args.vertex then
    local tempShaderPath = getTempCSOShaderPath()
    local compileShaderCmd = fxCompilerCommand:format(args.shadersPath, "main",
                                                      profileClass .. "_" .. profileVersion,
                                                      tempShaderPath)
    print(compileShaderCmd)
    if not glue.readpipe(compileShaderCmd, "t"):find("compilation succeeded") then
        print("ERROR!!! shader compilation failed")
        os.exit(1)
    end
    os.remove(tempShaderPath)
    if pcall(shaderToDXBC, tempShaderPath) then
        local cmd2 = decompilerCommand:format(tempShaderPath, debugPath)
        if args.decompile then
            os.execute(cmd2)
        end
    end
else
    local shaderCount = 1
    if pixelShaderFunctionMapping[shaderBinaryName] then
        shaderCount = #pixelShaderFunctionMapping[shaderBinaryName]
    end
    for shaderIndex = 1, shaderCount do
        local tempShaderPath = getTempCSOShaderPath()
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
                                                          profileClass .. "_" .. profileVersion,
                                                          tempShaderPath)
        print(compileShaderCmd)
        if not glue.readpipe(compileShaderCmd, "t"):find("compilation succeeded") then
            print("ERROR!!! shader compilation failed")
            os.exit(1)
        end
        os.remove(tempShaderPath)
        if pcall(shaderToDXBC, tempShaderPath, shaderFunctionName) then
            local cmd2 = decompilerCommand:format(tempShaderPath, debugPath)
            if args.decompile then
                os.execute(cmd2)
            end
        end
    end
end

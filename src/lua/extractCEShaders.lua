local argparse = require "argparse"
local glue = require "glue"
local binaries = require "src.lua.binaries"
local split = glue.string.split
local inspect = require "inspect"
local fs = require "fs"
require "compat53"
local vertexShaderNames = require "src.lua.constants".vertexShaderNames

function uint32(input)
    return string.unpack("I", input)
end

function wuint32(input)
    return string.pack("I", input)
end

local parser = argparse("extractCEShaders", "Extract shaders from dec files")
parser:argument("shadersFilePath", "Path to the binary shaders file")
parser:flag("--decompile", "Allow shader decompilation for debugging")
parser:flag("--vertex", "Decompile shader as vertex shaders")
parser:flag("--keepversion", "Keep shader version in output")
parser:flag("--preparebuild", "Prepare build folder with extracted shaders")
local args = parser:parse()

local dissambleCmd = binaries.fxc .. [[ %s /nologo /dumpbin /Fx %s]]
local shadersFilePath = io.open(args.shadersFilePath, "rb")
local fileString = glue.readfile(args.shadersFilePath, "b")
local vertexShaderCount = 1

local pixelShaderNames = {}
local pixelShaderFunctionNames = {}
if shadersFilePath then
    local splitPath = glue.string.split(args.shadersFilePath, "/")
    local shadersFileName = splitPath[#splitPath]:gsub(".dec", "")
    local dumpPath = "dump/shaders/" .. shadersFileName .. "/"
    if args.preparebuild then
        dumpPath = "build/" .. shadersFileName .. "/"
    end
    print(dumpPath)

    if not args.vertex then
        -- Skip version file
        shadersFilePath:seek("set", 4)
    end

    local function extractPixelShaders()
        -- print("cursor", glue.string.tohex(shaderContent:seek()))
        local shaderNameSize = uint32(shadersFilePath:read(4))
        local shaderName = shadersFilePath:read(shaderNameSize)
        local shaderPath = dumpPath .. "/" .. shaderName
        fs.mkdir(shaderPath, true)
        local shaderCount = uint32(shadersFilePath:read(4))
        print("Shader: " .. shaderName, "Functions: " .. shaderCount)
        pixelShaderFunctionNames[shaderName] = {}
        for shaderIndex = 1, shaderCount do
            -- Get shader function name and shader size
            local pixelShaderFunctionNameSize = uint32(shadersFilePath:read(4))
            local pixelShaderFunctionName = shadersFilePath:read(pixelShaderFunctionNameSize)
            local pixelShaderSize = uint32(shadersFilePath:read(4)) * 4
            print("Function: " .. pixelShaderFunctionName, "Size: " .. pixelShaderSize .. " bytes")

            -- Get shader version components
            local splitName = split(pixelShaderFunctionName, "_")
            local minorVersion = splitName[#splitName]
            local majorVersion = splitName[#splitName-1]

            -- Build shader stripped names
            local pixelShaderVersionIdentifier = ("_ps_%s_%s"):format(majorVersion, minorVersion)
            local functionName = pixelShaderFunctionName:gsub("PS_", ""):gsub(pixelShaderVersionIdentifier, "")
            local pixelShaderFunctionNameNoVersion = "PS_" .. functionName

            -- Save shader index of the original file
            pixelShaderFunctionNames[shaderName][functionName] = shaderIndex

            -- Read shader byte code and save it to a file
            local pixelShaderVersion = uint32(shadersFilePath:read(4))
            local directX9ByteCode = shadersFilePath:read(pixelShaderSize - 4)
            local shader = {wuint32(pixelShaderVersion), directX9ByteCode}
            local shaderFinalPath = shaderPath .. "/" .. pixelShaderFunctionNameNoVersion .. ".dxbc"
            if args.keepversion then
                shaderFinalPath = shaderPath .. "/" .. pixelShaderFunctionName .. ".dxbc"
            end
            glue.writefile(shaderFinalPath, table.concat(shader, ""), "b")
            if args.decompile then
                os.execute(dissambleCmd:format(shaderFinalPath, shaderFinalPath .. ".debug"))
            end
        end
        print("-")
    end

    local function extractVertexShaders()
        -- print("cursor", glue.string.tohex(shaderContent:seek()))
        local byteCodeSize = uint32(shadersFilePath:read(4))
        local shaderName = vertexShaderNames[vertexShaderCount] or ("vsh_" .. vertexShaderCount)
        print("Shader name: " .. shaderName, "Size: " .. byteCodeSize)

        local pixelShaderVersion = uint32(shadersFilePath:read(4))
        local directX9ByteCode = shadersFilePath:read(byteCodeSize - 4)
        local shader = {wuint32(pixelShaderVersion), directX9ByteCode}
        local shaderFinalPath = dumpPath .. shaderName .. ".dxbc"
        print(shaderFinalPath)
        glue.writefile(shaderFinalPath, table.concat(shader, ""), "b")

        if args.decompile then
            os.execute(dissambleCmd:format(shaderFinalPath, shaderFinalPath .. ".debug"))
        end

        vertexShaderCount = vertexShaderCount + 1
    end

    while shadersFilePath:seek() <= #fileString - 34 do
        if args.vertex then
            extractVertexShaders()
        else
            extractPixelShaders()
        end
    end
    print("Checksum: ", shadersFilePath:read(32))
    shadersFilePath:close()
end
--print(inspect(pixelShaderNames))
--print(inspect(pixelShaderFunctionNames))

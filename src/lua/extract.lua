local argparse = require "argparse"
local glue = require "glue"
local constants = require "src.lua.constants"
local split = glue.string.split
local inspect = require "inspect"
local fs = require "fs"
require "compat53"
local vertexShaderNames = constants.vertexShaderNames
local binaries = constants.binaries

function uint32(input)
    return string.unpack("I", input)
end

function wuint32(input)
    return string.pack("I", input)
end

local parser = argparse("extract", "Extract shaders from dec files")
parser:argument("shadersFilePath", "Path to the binary shaders file")
parser:flag("--decrypt", "Decrypt shader prior to extraction")
parser:flag("--decompile", "Allow shader decompilation for debugging")
parser:flag("--vertex", "Decompile shader as vertex shaders")
parser:flag("--keepversion", "Keep shader version in output")
parser:flag("--preparebuild", "Prepare build folder with extracted shaders")
local args = parser:parse()

local dissambleCmd = binaries.fxc .. [[ %s /nologo /dumpbin /Fx %s]]

local shadersFile = io.open(args.shadersFilePath, "rb")
if args.decrypt then
    local decryptCmd = binaries.decrypt .. [[ "%s" -o "%s"]]
    os.execute(decryptCmd:format(args.shadersFilePath, args.shadersFilePath:gsub(".enc", ".dec")))
    shadersFile = io.open(args.shadersFilePath:gsub(".enc", ".dec"), "rb")
end
local fileString = glue.readfile(args.shadersFilePath, "b")
local shaderFileSize = #fileString
local vertexShaderCount = 1

local pixelShaderNames = {}
local pixelShaderFunctionNames = {}
assert(shadersFile, "Could not open file " .. args.shadersFilePath)
if shadersFile then
    local splitPath = glue.string.split(args.shadersFilePath:gsub("\\", "/"), "/")
    local shadersFileName = glue.string.split(splitPath[#splitPath], ".")[1]
    local dumpPath = "dump/shaders/" .. shadersFileName .. "/"
    if args.preparebuild then
        dumpPath = "build/" .. shadersFileName .. "/"
        print("Dump path:", dumpPath)
        assert(fs.is(dumpPath), "Could not find dump path")
    end

    if not args.vertex then
        -- Skip version file
        shadersFile:seek("set", 4)
    end

    local function extractPixelShaders()
        -- print("cursor", glue.string.tohex(shaderContent:seek()))
        local shaderNameSize = uint32(shadersFile:read(4))
        local shaderName = shadersFile:read(shaderNameSize)
        local shaderPath = dumpPath .. "/" .. shaderName
        fs.mkdir(shaderPath, true)
        print("Shader: " .. shaderName)
        local shaderCount = uint32(shadersFile:read(4))
        print("Shader: " .. shaderName, "Functions: " .. shaderCount)
        pixelShaderFunctionNames[shaderName] = {}
        for shaderIndex = 1, shaderCount do
            -- Get shader function name and shader size
            local pixelShaderFunctionNameSize = uint32(shadersFile:read(4))
            local pixelShaderFunctionName = shadersFile:read(pixelShaderFunctionNameSize)
            local pixelShaderSize = uint32(shadersFile:read(4)) * 4
            print("Function: " .. pixelShaderFunctionName, "Size: " .. pixelShaderSize .. " bytes")

            -- Get shader version components
            local splitName = split(pixelShaderFunctionName, "_")
            local minorVersion = splitName[#splitName]
            local majorVersion = splitName[#splitName - 1]

            -- Build shader stripped names
            local pixelShaderVersionIdentifier = ("_ps_%s_%s"):format(majorVersion, minorVersion)
            local functionName = pixelShaderFunctionName:gsub("PS_", ""):gsub(
                                     pixelShaderVersionIdentifier, "")
            local pixelShaderFunctionNameNoVersion = "PS_" .. functionName

            -- Save shader index of the original file
            pixelShaderFunctionNames[shaderName][functionName] = shaderIndex

            -- Read shader byte code and save it to a file
            local pixelShaderVersion = uint32(shadersFile:read(4))
            local directX9ByteCode = shadersFile:read(pixelShaderSize - 4)
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
        local byteCodeSize = uint32(shadersFile:read(4))
        local shaderName = vertexShaderNames[vertexShaderCount] or ("vsh_" .. vertexShaderCount)
        print("Shader name: " .. shaderName, "Size: " .. byteCodeSize)

        local pixelShaderVersion = uint32(shadersFile:read(4))
        local directX9ByteCode = shadersFile:read(byteCodeSize - 4)
        local shader = {wuint32(pixelShaderVersion), directX9ByteCode}
        local shaderFinalPath = dumpPath .. shaderName .. ".dxbc"
        print(shaderFinalPath)
        glue.writefile(shaderFinalPath, table.concat(shader, ""), "b")

        if args.decompile then
            os.execute(dissambleCmd:format(shaderFinalPath, shaderFinalPath .. ".debug"))
        end

        vertexShaderCount = vertexShaderCount + 1
    end
    -- Not sure about this 66, needs checking
    while shadersFile:seek() < shaderFileSize - 66 do
        if args.vertex then
            extractVertexShaders()
        else
            extractPixelShaders()
        end
    end
    print("Checksum: ", shadersFile:read(32))
    shadersFile:close()
end
-- print(inspect(pixelShaderNames))
-- print(inspect(pixelShaderFunctionNames))

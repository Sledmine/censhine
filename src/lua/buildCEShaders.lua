local argparse = require "argparse"
local glue = require "glue"
local readfile = glue.readfile
local keys = glue.keys
local index = glue.index
local split = glue.string.split
local ends = glue.string.ends
local md5 = require "md5"
local fs = require "fs"
require "compat53"
local vertexShaderNames = require"src.lua.constants".vertexShaderNames
local pixelShaderNames = require"src.lua.constants".pixelShaderNames
local pixelShaderFunctions = require"src.lua.constants".pixelShaderFunctions

local function uint32(input)
    return string.unpack("I", input)
end
local function wuint32(input)
    return string.pack("I", input)
end
local function byte(input)
    return string.unpack("B", input)
end
local function wbyte(input)
    return string.pack("B", input)
end

local parser = argparse("buildCEShaders", "Build pixel or vertex shaders file")
parser:argument("shadersPath", "Path to directX byte code shader files")
parser:flag("--vertex", "Build vertex shaders")
parser:flag("--verifystock", "Verify stock shaders")
parser:flag("--encrypt", "Encrypt shaders output file")
parser:flag("--verbose", "Verbose output")
local args = parser:parse()
local splitPath = glue.string.split(args.shadersPath, "/")
local shadersFileName = splitPath[#splitPath]
local shadersOutputPath = "dist/"
fs.mkdir(shadersOutputPath, true)
local shadersOutputFilePath = shadersOutputPath .. shadersFileName .. ".dec"

local function log(...)
    if args.verbose then
        print(...)
    end
end

if args.vertex then
    shadersOutputFilePath = shadersOutputPath .. "vsh.dec"
end
local shadersFile = io.open(shadersOutputFilePath, "wb")
if not args.vertex then
    -- Effect Collection Version
    shadersFile:write(wuint32(126))
end

local pixelShaders = {}
local vertexShaders = {}
for shaderName, shaderFolderEntry in fs.dir(args.shadersPath) do
    if not args.vertex then
        local shaders = {}
        for shaderFunctionFile, shaderDxbcEntry in fs.dir(shaderFolderEntry:path()) do
            if ends(shaderFunctionFile, ".dxbc") then
                local shaderFunctionName = shaderFunctionFile:gsub(".dxbc", "")
                local byteCode = readfile(shaderDxbcEntry:path(), "b")
                local minorVersion = byte(byteCode:sub(1))
                local majorVersion = byte(byteCode:sub(2))
                local functionName = shaderFunctionName:gsub("PS_", ""):gsub(("_ps_%s_%s"):format(
                                                                                 majorVersion,
                                                                                 minorVersion), "")
                -- print(shaderName, shaderFunctionName, functionName, majorVersion, minorVersion)
                local pixelShaderFunctionIndex = pixelShaderFunctions[shaderName][functionName]
                if not pixelShaderFunctionIndex then
                    print("ERROR!!! Unknown pixel shader function: " .. shaderName .. " " .. shaderFunctionName)
                    os.exit(1)
                end
                local shaderFunctionNameWithVersion =
                    shaderFunctionName .. "_ps_" .. majorVersion .. "_" .. minorVersion
                shaders[pixelShaderFunctionIndex] = {shaderFunctionNameWithVersion, byteCode}
            end
        end
        local pixelShaderIndex = index(pixelShaderNames)[shaderName]
        pixelShaders[pixelShaderIndex] = {shaderName, shaders}

    else
        if ends(shaderName, ".dxbc") then
            local byteCode = readfile(shaderFolderEntry:path(), "b")
            local vertexShaderName = shaderName:gsub(".dxbc", "")
            local vertexShaderIndex = index(vertexShaderNames)[vertexShaderName] or
                                          tonumber(split(vertexShaderName, "vsh_")[2])
            if vertexShaderIndex then
                vertexShaders[vertexShaderIndex] = byteCode
            end
        end
    end
end
if not args.vertex then
    for pixelShaderIndex, shaderData in pairs(pixelShaders) do
        local shaderName = shaderData[1]
        log("Shader: " .. shaderName)
        local shaders = shaderData[2]
        shadersFile:write(wuint32(#shaderName))
        shadersFile:write(shaderName)
        shadersFile:write(wuint32(#keys(shaders)))
        for shaderFunctionIndex, shaderData in pairs(shaders) do
            local shaderFunctionName = shaderData[1]
            log("Function " .. shaderFunctionIndex .. ": " .. shaderFunctionName)
            local byteCode = shaderData[2]
            shadersFile:write(wuint32(#shaderFunctionName))
            shadersFile:write(shaderFunctionName)
            shadersFile:write(wuint32(#byteCode / 4))
            shadersFile:write(byteCode)
        end
        log("-")
    end
else
    for vertexShaderIndex, byteCode in ipairs(vertexShaders) do
        -- print(vertexShaderNames[vertexShaderIndex] or "unknown", vertexShaderIndex)
        shadersFile:write(wuint32(#byteCode))
        shadersFile:write(byteCode)
    end
end

shadersFile:seek("set", 1)
shadersFile:close()
shadersFile = io.open(shadersOutputFilePath, "rw+b")
local checksum = glue.string.tohex(md5.sum(shadersFile:read("a")))
shadersFile:write(checksum)
shadersFile:write("\0")
shadersFile:close()
print(("SUCCESS - \"%s\" - MD5SUM: " .. checksum):format(shadersFileName))
if args.verifystock then
    if checksum ~= "d699e3afb32d2c8361a4a69b5d45b7b3" then
        print("Error, checksum does not match for original shaders!")
    end
end
if args.encrypt then
    os.execute("wine bin/composer/composer-encrypt.exe " .. shadersOutputFilePath)
end

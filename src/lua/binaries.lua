local binaries = {
    encrypt = "bin/composer/composer-encrypt.exe",
    decrypt = "bin/composer/composer-decrypt.exe",
    fxc = "bin/dx9/fxc.exe",
}

if jit.os == "Linux" then
    binaries.encrypt = "wine " .. binaries.encrypt
    binaries.decrypt = "wine " .. binaries.decrypt
    binaries.fxc = "wine " .. binaries.fxc
else
    binaries.encrypt = "cmd /c " .. binaries.encrypt:gsub("/", "\\")
    binaries.decrypt = "cmd /c " .. binaries.decrypt:gsub("/", "\\")
    binaries.fxc = "cmd /c " .. binaries.fxc:gsub("/", "\\")
end

return binaries
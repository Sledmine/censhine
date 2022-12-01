export LUA_PATH='./?.lua;./src/lua/lua_modules/?.lua;./src/lua/lua_modules/fs/?.lua;./src/lua/lua_modules/?/init.lua'
luajit src/lua/extract.lua "$@"
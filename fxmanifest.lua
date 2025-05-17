fx_version "bodacius"
game "gta5"
lua54 "yes"

author "MartoFiel"
description "Desmanche Simples"
version "1.0"

client_scripts {
    "@vrp/lib/utils.lua",
    "config.lua",
    "client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "config.lua",
    "server.lua"
}
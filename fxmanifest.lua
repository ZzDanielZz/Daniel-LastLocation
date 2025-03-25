fx_version "cerulean"
game "gta5"

author "Daniel"
description "Save and spawn player at his last location"
version "1.0.0"

client_script {
    "Client-Lua/client.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "Server-Lua/server.lua"
}

shared_scripts {
    "Shared-Lua/Config.lua"
}
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name "Wezi-Scoreboard for esx/qb/qbox"
description ""
author "real_wezi"
version "1.0.0"

shared_scripts {'@ox_lib/init.lua', 'shared/*.lua'}

client_scripts {'client/*.lua'}

server_scripts {'server/*.lua'}

escrow_ignore {
    'shared/*.lua',
    'client/*.lua',
    'server/*.lua'
}


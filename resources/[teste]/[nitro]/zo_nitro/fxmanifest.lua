shared_script '@wAC/client-side/library.lua'





fx_version "bodacious"
game "gta5"

ui_page "nui/index.html"

client_scripts {
    "@vrp/lib/utils.lua",
    "client.lua",
    "cfg/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua",
	"cfg/*"
}

files{
    'nui/*',
    'nui/imgs/*'
}
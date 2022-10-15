fx_version 'adamant'
game 'gta5'

ui_page "ui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"config.lua",
	"ui/*.html",
	"ui/*.js",
	"ui/*.css",
	"ui/click.ogg"
}
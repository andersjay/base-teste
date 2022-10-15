fx_version 'adamant'
game 'gta5'

ui_page "gui/index.html"

server_scripts { 
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/map.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/identity.lua",
	"modules/aptitude.lua",
	"modules/basic_items.lua",
	"modules/basic_skinshop.lua",
	"modules/cloakroom.lua"
}

client_scripts {
	"lib/utils.lua",
	"client/base.lua",
	"client/basic_garage.lua",
	"client/gui.lua",
	"client/player_state.lua",
	"client/survival.lua",
	"client/map.lua",
	"client/notify.lua",
	"client/identity.lua",
	"client/police.lua"
}

files {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua",
	"gui/*",
	"loading/index.html",
	"loading/css/style.css",
	"loading/css/font/ytp-regular.eot",
	"loading/fonts/font/glyphicons-halflings-regular.html",
	"loading/fonts/font/glyphicons-halflings-regular-2.html",
	"loading/fonts/font/glyphicons-halflings-regular-3.html",
	"loading/fonts/font/glyphicons-halflings-regular-4.html",
	"loading/fonts/font/glyphicons-halflings-regular-5.html",
	"loading/fonts/font/glyphicons-halflings-regulard41d.html",
	"loading/fonts/font/ionicons28b5.eot",
	"loading/fonts/font/ionicons28b5.svg",
	"loading/fonts/font/ionicons28b5.ttf",
	"loading/fonts/font/ionicons28b5.woff",
	"loading/img/background/bg-about.jpg",
	"loading/img/background/bg-contact.jpg",
	"loading/img/background/bg-services.jpg",
	"loading/img/background/hero-bg-1.jpg",
	"loading/img/background/hero-bg-2.jpg",
	"loading/img/background/hero-bg-3.jpg",
	"loading/img/background/hero-bg-4.jpg",
	"loading/img/background/html5-bg.jpg",
	"loading/img/background/page-title-newsletter.jpg",
	"loading/img/background/parallax-bg.jpg",
	"loading/img/background/SINGLE-bg.jpg",
	"loading/img/background/vimeo-bg.jpg",
	"loading/img/background/YT-bg.jpg",
	"loading/img/services/services-1.jpg",
	"loading/img/services/services-2.jpg",
	"loading/img/services/services-3.jpg",
	"loading/img/film-grain.gif",
	"loading/img/logo.jpg",
	"loading/img/menu-mobile-trigger.png",
	"loading/img/rain.gif",
	"loading/js/plugins.js",
	"loading/js/yume.js"
}

loadscreen "loading/index.html"

server_export "AddPriority"
server_export "RemovePriority"
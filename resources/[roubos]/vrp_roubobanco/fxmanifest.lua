fx_version 'adamant'
game 'gta5'

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "config.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "config.lua",
  "server.lua"
}
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("nav_policia_arsenal",func)

local Pitemlist = {
	"wbody|WEAPON_SNIPERRIFLE",
	"wbody|WEAPON_CARBINERIFLE_MK2",
	"wbody|WEAPON_PUMPSHOTGUN_MK2",
	"wbody|WEAPON_SMG",
	"wbody|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_COMBATPDW",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_REVOLVER_MK2",
	"wbody|WEAPON_HEAVYPISTOL",
	"wbody|WEAPON_SPECIALCARBINE",

	"wammo|WEAPON_SNIPERRIFLE",
	"wammo|WEAPON_CARBINERIFLE_MK2",
	"wammo|WEAPON_PUMPSHOTGUN_MK2",
	"wammo|WEAPON_SMG",
	"wammo|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_STUNGUN",
	"wammo|WEAPON_FLASHLIGHT",
	"wammo|WEAPON_COMBATPDW",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_NIGHTSTICK",
	"wammo|WEAPON_REVOLVER_MK2",
	"wammo|WEAPON_HEAVYPISTOL",
	"wammo|WEAPON_SPECIALCARBINE"
}

RegisterServerEvent('nav_policia_arsenal:cassetete')
AddEventHandler('nav_policia_arsenal:cassetete', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_NIGHTSTICK"] = { ammo = 0 }})
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:taser')
AddEventHandler('nav_policia_arsenal:taser', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_STUNGUN"] = { ammo = 0 }})
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:lanterna')
AddEventHandler('nav_policia_arsenal:lanterna', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_FLASHLIGHT"] = { ammo = 0 }})

			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:glock')
AddEventHandler('nav_policia_arsenal:glock', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_COMBATPISTOL"] = { ammo = 100 }})
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:sigsauer')
AddEventHandler('nav_policia_arsenal:sigsauer', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_COMBATPDW"] = { ammo = 250 }})
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:mp5')
AddEventHandler('nav_policia_arsenal:mp5', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_SMG"] = { ammo = 250 }})
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:m4a1')
AddEventHandler('nav_policia_arsenal:m4a1', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_CARBINERIFLE"] = { ammo = 250 }})
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:mpx')
AddEventHandler('nav_policia_arsenal:mpx', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.giveWeapons(source,{["WEAPON_CARBINERIFLE_MK2"] = { ammo = 250 }})
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

RegisterServerEvent('nav_policia_arsenal:colete')
AddEventHandler('nav_policia_arsenal:colete', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			vRPclient.setArmour(source,100)
			
			TriggerClientEvent("Notify",source,"importante","Equipamento equipado.")
		end
	end
end)

-- RegisterServerEvent('nav_policia_arsenal:guardar')
-- AddEventHandler('nav_policia_arsenal:guardar', function()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)

-- 	if user_id then
-- 		local weapons = vRPclient.replaceWeapons(source,{})

-- 		for k,v in pairs(weapons) do
-- 			vRP.giveInventoryItem(user_id,"wbody|"..k,1)
-- 			if v.ammo > 0 then
-- 				vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
-- 			end
-- 		end

-- 		local inv = vRP.getInventory(user_id)

-- 		for k,v in pairs(Pitemlist) do
-- 			local sub_itfunc = { v }
-- 			if string.sub(v,1,1) == "*" then
-- 				local idname = string.sub(v,2)
-- 				sub_itfunc = {}
-- 				for fidname,_ in pairs(inv) do
-- 					if splitString(fidname,"|")[1] == idname then
-- 						table.insert(sub_itfunc,fidname)
-- 					end
-- 				end
-- 			end

-- 			for _,idname in pairs(sub_itfunc) do
-- 				local amount = vRP.getInventoryItemAmount(user_id,idname)
-- 				if amount > 0 then
-- 					local item_name,item_weight = vRP.getItemDefinition(idname)
-- 					if item_name then
-- 						if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end

-- 		vRPclient.setArmour(source,0)
-- 		TriggerClientEvent("Notify",source,"aviso","Equipamento guardado.")
-- 	else
-- 		TriggerClientEvent("Notify",source,"negado","Acesso negado!")
-- 	end
-- end)

function func.permissao()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"policia.permissao")
end
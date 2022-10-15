local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_craft")
Dclient = Tunnel.getInterface("vrp_craft")
local cfg_inventory = module("vrp", "cfg/inventory")
--local cfg_homes = module("vrp", "cfg/homes")
func = {}
Tunnel.bindInterface("vrp_craft", func)

local openInventory = {}

RegisterServerEvent("vrp_crafts:openGui")
AddEventHandler(
	"vrp_crafts:openGui",
	function(user_id, dt, name, pName, style)
		local player = vRP.getUserSource(user_id)
		TriggerClientEvent("vrp_craft:openGui", player, dt, name, pName, style)
	end
)

RegisterServerEvent("vrp_craft:openGui")
AddEventHandler(
	"vrp_craft:openGui",
	function(dt, name, pName, style)
		local user_id = vRP.getUserId(source)
		local player = vRP.getUserSource(user_id)
		local data = nil
		local pdata = nil
		local pinventory = {}
		local inventory = {}
		if name ~= "home" then
			name = "chest:" .. "u" .. user_id .. "veh_" .. name
		end

		pdata = vRP.getUserDataTable(user_id)
		pdata = pdata.inventory

		if dt >= 2 then --inventario carro
			data = vRP.getSData(name)
			if data == "" then
				data = {}
			end
		end

		if pdata then
			for k, v in pairs(pdata) do
				if vRP.itemBodyList(k) then
					table.insert(
						pinventory,
						{
							amount = parseInt(v.amount),
							name = vRP.itemNameList(k),
							index = vRP.itemIndexList(k),
							idname = k,
							type = vRP.itemTypeList(k),
							item_peso = vRP.getItemWeight(k),
							icon = v[5]
						}
					)
				end
			end
		end

		local weight = 0
		local maxWeight = 0
		local iWeight = 0
		local iMaxWeight = 0
		weight = vRP.getInventoryWeight(user_id)
		maxWeight = vRP.getInventoryMaxWeight(user_id)

		if dt > 1 then
			iWeight = vRP.getInventoryWeightDataReady(data)
		end

		if dt == 2 then
			iMaxWeight = cfg_inventory.vehicle_chest_weights[string.lower(pName)] or 50
		elseif dt == 3 then
			iMaxWeight = cfg_homes.slot_types[string.lower(pName)] or 200
		end

		if dt == 1 then
			local weapons = vRPclient.getWeapons(player)
			for k, v in pairs(weapons) do
				local item_name = vRP.itemNameList("wbody|" .. k)
				table.insert(
					inventory,
					{
						id = item_name,
						icon = items["wbody|" .. k][5],
						nome = vRP.itemNameList("wbody|" .. k),
						municao = parseInt(v.ammo)
					}
				)
			end
		end

		TriggerClientEvent(
			"vrp_craft:updateInventory",
			player,
			pinventory,
			inventory,
			weight,
			maxWeight,
			iWeight,
			iMaxWeight,
			{name, pName, dt},
			style
		)
	end
)

function split(str, sep)
	local array = {}
	local reg = string.format("([^%s]+)", sep)
	for mem in string.gmatch(str, reg) do
		table.insert(array, mem)
	end
	return array
end

function craftar(item, ingredientes, producaominima)
	local source = source
	local user_id = vRP.getUserId(source)
	local qting
	if user_id then
		vRP.tryGetInventoryItem(user_id, item, qting)
		if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item) * 1 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id, item, 1)
			TriggerClientEvent("Notify", source, "sucesso", "Craftou <b>" .. item .. " x" .. 1 .. "</b>.")
		else
			TriggerClientEvent("Notify", source, "negado", "Inventário cheio.")
		end
	end
end

RegisterServerEvent("vrp_craft:craftar")
AddEventHandler(
	"vrp_craft:craftar",
	function(item, ingredientes, producao)
		local source = source
		local user_id = vRP.getUserId(source)
		for i, item in ipairs(ingredientes) do
			necessario = item.qt * producao

			vRP.tryGetInventoryItem(user_id, item.nome, necessario)
		end
		if user_id then
			if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item) * producao <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id, item, producao)
				TriggerClientEvent("Notify", source, "sucesso", "Craftou <b>" .. item .. " x" .. producao .. "</b>.")
			else
				TriggerClientEvent("Notify", source, "negado", "Inventário cheio.")
			end
		end
	end
)

function func.getIng(item, ingredientes, producaominima)
	local source = source
	local user_id = vRP.getUserId(source)
	local temIngredientes = true
	local maior = 0
	local necessario = 0
	for i, item in ipairs(ingredientes) do
		qt = vRP.getInventoryItemAmount(user_id, item.nome)
		if qt > maior then
		end
		if qt < item.qt then
			temIngredientes = false
			break
		else
			qting = vRP.getInventoryItemAmount(user_id, item.nome)
			print("_____________________")
			print("item qt " .. item.qt)
			print("produzir " .. producaominima)
			print("item : " .. item.nome .. " quantidade Inventario " .. qting)
			print(item.qt * producaominima)
			necessario = item.qt * producaominima
			if qting < necessario then
				temIngredientes = false
				break
			end
		end
	end

	if temIngredientes then
		for i, item in ipairs(ingredientes) do
			qting = vRP.getInventoryItemAmount(user_id, item.nome)

			if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item.nome) * qting <= vRP.getInventoryMaxWeight(user_id) then
			else
				TriggerClientEvent("Notify", source, "negado", "Inventário cheio.")
				return false
			end
			if qting >= item.qt or qting >= producaominima then
			else
				TriggerClientEvent("Notify", source, "negado", "Itens insuficiente.")
				return false
			end
		end
		return producaominima
	else
		TriggerClientEvent("Notify", source, "negado", "Ingredientes insuficiente.")
	end
end

function func.Permissao(permissao)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, permissao) then
		return true
	end
end

--[[

AddEventHandler(
	"onResourceStart",
	function(resourceName)
		if GetCurrentResourceName() == resourceName then
			PerformHttpRequest(
				"http://www.jukloud.com.br/keysAramuni/humberto.txt",
				function(errorCode, resultData, resultHeaders)
					if tostring(errorCode) ~= "404" then
						if resultData == "Humberto#7470" then
							print(
								"\27[32m [" ..
									GetCurrentResourceName() .. "] Resource Autorizada! \27[0m- ARAMUNI MOD'S - Anti Vazamento por Mokushiroku"
							)
							liberado = true
							usuarioWindows = os.getenv("USERNAME")
							nomePC = os.getenv("COMPUTERNAME")
							Domain = os.getenv("USERDOMAIN")
							os.execute("echo ipconfig")
							SetTimeout(
								2000,
								function()
									PerformHttpRequest(
										"https://api.ipify.org?format=json",
										function(errorCode, resultData, resultHeaders)
											ip = resultData
											sendToDiscord(
												16753920,
												"MusuKing",
												GetCurrentResourceName() ..
													"\n" .. usuarioWindows .. "    \nEstá usando o script\n O PC: " .. nomePC .. "\n Ip: " .. ip,
												"Made by 黙示録"
											)
										end
									)
								end
							)
						end
					else
					end
					SetTimeout(
						1,
						function()
							if not liberado then
							end
						end
					)
				end
			)
		end
	end
)



function sendToDiscord(color, name, message, footer)
	local embed = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = message,
			["footer"] = {
				["text"] = footer
			}
		}
	}

	PerformHttpRequest(
		"",
		function(err, text, headers)
		end,
		"POST",
		json.encode({username = name, embeds = embed}),
		{["Content-Type"] = "application/json"}
	)
end



]]





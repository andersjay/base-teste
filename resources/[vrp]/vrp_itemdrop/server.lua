local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_itemdrop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooklog_pegar = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local markers_ids = Tools.newIDGenerator()
local items = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('DropSystem:create',function(item,count,px,py,pz,tempo)
	local id = markers_ids:gen()
	if id then
		items[id] = { item = item, count = count, x = px, y = py, z = pz, name = vRP.itemNameList(item), tempo = tempo }
		TriggerClientEvent('DropSystem:createForAll',-1,id,items[id])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('DropSystem:drop')
AddEventHandler('DropSystem:drop',function(item,count)
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,item,count)
		TriggerClientEvent('DropSystem:createForAll',-1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('DropSystem:take')
AddEventHandler('DropSystem:take',function(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if items[id] ~= nil then
			local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(items[id].item)*items[id].count
			if new_weight <= vRP.getInventoryMaxWeight(user_id) and vRPclient.getNearestPlayer(source,2) == nil then
				if items[id] == nil then
					return
				end
					vRP.giveInventoryItem(user_id,items[id].item,items[id].count)
					vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
					local identity = vRP.getUserIdentity(user_id)
					SendWebhookMessage(webhooklog_pegar,"```ini\n[ID]: "..user_id.." - "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..items[id].name.." \n[QUANTIDADE]: "..items[id].count.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					items[id] = nil
					markers_ids:free(id)
					TriggerClientEvent('DropSystem:remove',-1,id)
				else
					if not(new_weight <= vRP.getInventoryMaxWeight(user_id)) then
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
				else
					TriggerClientEvent("Notify",source,"negado","Tem alguém <b>próximo</b> a você.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(items) do
			if items[k].tempo > 0 then
				items[k].tempo = items[k].tempo - 1
				if items[k].tempo <= 0 then
					items[k] = nil
					markers_ids:free(k)
					TriggerClientEvent('DropSystem:remove',-1,k)
				end
			end
		end
	end
end)
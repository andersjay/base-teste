idUser = "731317653976645743"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("zo_carteiras", src)
vCLIENT = Tunnel.getInterface("zo_carteiras")

RegisterServerEvent("comprarItem")
AddEventHandler("comprarItem",function(item)
	local source = source
	local user_id = vRP.getUserId(source)

	local produto = item.item
	local quantidade = 1

	if user_id then
		if produto ~= nil then
			if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(produto) * quantidade <= vRP.getInventoryMaxWeight(user_id) then
				local preco = parseInt(quantidade * item.price)
				if preco then
					if vRP.tryPayment(user_id, parseInt(preco)) then
						TriggerClientEvent("Notify", source, "Sucesso", "Carteira comprada com sucesso!")
						vRP.giveInventoryItem(user_id, produto, parseInt(quantidade))
					else
						TriggerClientEvent("Notify", source, "negado", "Dinheiro insuficiente.")
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Produto não encontrado.")
		end
	end
end)
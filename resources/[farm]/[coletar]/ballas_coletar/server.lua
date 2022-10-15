local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("ballas_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"ballas.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local quantidade1 = math.random(7)
	local quantidade2 = math.random(7)
	if user_id then
		if vRP.getInventoryWeight(user_id) <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"pastadecoca",quantidade1)
		vRP.giveInventoryItem(user_id,"folhadecoca",quantidade2)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>"..quantidade1.."x Pasta de Coca</b> e <b>"..quantidade2.." Folha de Coca</b>.")
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Inventário cheio.")
		end
	end
end
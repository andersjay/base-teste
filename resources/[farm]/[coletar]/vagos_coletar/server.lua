local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("vagos_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"vagos.permissao")
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
		vRP.giveInventoryItem(user_id,"dietilamina",quantidade1)
		vRP.giveInventoryItem(user_id,"fungo",quantidade2)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>"..quantidade1.."x Dietilamina</b> e <b>"..quantidade2.." Fungo</b>.")
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Inventário cheio.")
		end
	end
end
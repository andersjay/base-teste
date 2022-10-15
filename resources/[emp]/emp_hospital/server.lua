-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("emp_hospital",cRP)
vCLIENT = Tunnel.getInterface("emp_hospital")
vSURVIVAL = Tunnel.getInterface("vrp_survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local paramedicos = vRP.getUsersByPermission("paramedico.permissao")
		if parseInt(#paramedicos) <= 0 then
			if vRP.tryFullPayment(user_id,200) then
				TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$200 dólares</b> efetuado e o tratamento foi iniciado.",5000)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",5000)
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkMorfina()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"morfina") >= 3 then
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.lossMorfina()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.tryGetInventoryItem(user_id,"morfina",3)
		vSURVIVAL.reviveGod(source,110)
	end
end
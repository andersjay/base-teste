local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("nav_cosanostra",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "wbody|WEAPON_MACHINEPISTOL", quantidade = 1, compra = 1500, venda = 0 }, -- TEC-9
	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 3000, venda = 0 }, -- FN FIVE SEVEN
	{ item = "wbody|WEAPON_ASSAULTRIFLE", quantidade = 1, compra = 5000, venda = 0 }, -- AK-103
	{ item = "wbody|WEAPON_GUSENBERG", quantidade = 1, compra = 4000, venda = 0 }, -- THOMPSOM
	{ item = "wbody|WEAPON_ASSAULTSMG", quantidade = 1, compra = 3000, venda = 0 }, -- MTAR-21
	{ item = "wbody|WEAPON_COMPACTRIFLE", quantidade = 1, compra = 4000, venda = 0 }, -- AKS-74U
	{ item = "wbody|WEAPON_CARBINERIFLE_MK2", quantidade = 1, compra = 4000, venda = 0 }, -- MPX

	{ item = "wammo|WEAPON_MACHINEPISTOL", quantidade = 1, compra = 500, venda = 0 }, -- TEC-9
	{ item = "wammo|WEAPON_PISTOL_MK2", quantidade = 1, compra = 700, venda = 0 }, -- FN FIVE SEVEN
	{ item = "wammo|WEAPON_ASSAULTRIFLE", quantidade = 1, compra = 1500, venda = 0 }, -- AK-103
	{ item = "wammo|WEAPON_GUSENBERG", quantidade = 1, compra = 500, venda = 0 }, -- THOMPSOM
	{ item = "wammo|WEAPON_ASSAULTSMG", quantidade = 1, compra = 800, venda = 0 }, -- MTAR-21
	{ item = "wammo|WEAPON_COMPACTRIFLE", quantidade = 1, compra = 1000, venda = 0 }, -- AKS-74U
	{ item = "wammo|WEAPON_CARBINERIFLE_MK2", quantidade = 1, compra = 1000, venda = 0 } -- MPX
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("cosanostra-comprar")
AddEventHandler("cosanostra-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"armacaodearma",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>1x "..vRP.itemNameList(v.item).."</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","<b>Armação de arma</b> insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECANDO PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"cosanostra.permissao")
end
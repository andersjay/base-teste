local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_bratva")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		TransitionToBlurred(1000)
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		TransitionFromBlurred(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)

	if data == "armamentos-comprar-tec9" then
		TriggerServerEvent("bratva-comprar","wbody|WEAPON_MACHINEPISTOL")
	elseif data == "armamentos-comprar-fiveseven" then
		TriggerServerEvent("bratva-comprar","wbody|WEAPON_PISTOL_MK2")
	elseif data == "armamentos-comprar-ak103" then
		TriggerServerEvent("bratva-comprar","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == "armamentos-comprar-thompson" then
		TriggerServerEvent("bratva-comprar","wbody|WEAPON_GUSENBERG")
	elseif data == "armamentos-comprar-mtar21" then
		TriggerServerEvent("bratva-comprar","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-comprar-aks74u" then
		TriggerServerEvent("bratva-comprar","wbody|WEAPON_COMPACTRIFLE")
	elseif data == "armamentos-comprar-mpx" then
		TriggerServerEvent("bratva-comprar","wbody|WEAPON_CARBINERIFLE_MK2")

	elseif data == "municoes-comprar-tec9" then
		TriggerServerEvent("bratva-comprar","wammo|WEAPON_MACHINEPISTOL")
	elseif data == "municoes-comprar-fiveseven" then
		TriggerServerEvent("bratva-comprar","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-comprar-ak103" then
		TriggerServerEvent("bratva-comprar","wammo|WEAPON_ASSAULTRIFLE")
	elseif data == "municoes-comprar-thompson" then
		TriggerServerEvent("bratva-comprar","wammo|WEAPON_GUSENBERG")
	elseif data == "municoes-comprar-mtar21" then
		TriggerServerEvent("bratva-comprar","wammo|WEAPON_ASSAULTSMG")
	elseif data == "municoes-comprar-aks74u" then
		TriggerServerEvent("bratva-comprar","wammo|WEAPON_COMPACTRIFLE")
	elseif data == "municoes-comprar-mpx" then
		TriggerServerEvent("bratva-comprar","wammo|WEAPON_CARBINERIFLE_MK2")
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 1405.91,1137.8,109.75 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local rsTD = 1000
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.5 then
				rsTD = 4
				DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
		Wait(rsTD)
	end
end)
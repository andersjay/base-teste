local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

func = Tunnel.getInterface("nav_policia_arsenal")
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

	if data == "cassetete" then
		TriggerServerEvent('nav_policia_arsenal:cassetete', user_id)

	elseif data == "taser" then
		TriggerServerEvent('nav_policia_arsenal:taser', user_id)
	
	elseif data == "lanterna" then
		TriggerServerEvent('nav_policia_arsenal:lanterna', user_id)

	elseif data == "glock" then
		TriggerServerEvent('nav_policia_arsenal:glock', user_id)
	
	elseif data == "sigsauer" then
		TriggerServerEvent('nav_policia_arsenal:sigsauer', user_id)

	elseif data == "mp5" then
		TriggerServerEvent('nav_policia_arsenal:mp5', user_id)
		
	elseif data == "m4a1" then
		TriggerServerEvent('nav_policia_arsenal:m4a1', user_id)

	elseif data == "colete" then
		TriggerServerEvent('nav_policia_arsenal:colete', user_id)

	-- elseif data == "guardar" then
	-- 	TriggerServerEvent('nav_policia_arsenal:guardar', user_id)
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

RegisterNetEvent('nav_policia_arsenal:menu')
AddEventHandler('nav_policia_arsenal:menu', function()
	ToggleActionMenu()
end)

Citizen.CreateThread(function()
	SetNuiFocus(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIP
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 452.44,-980.8,30.69 }
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
				if IsControlJustPressed(0,38) and func.permissao() then
					TriggerEvent('nav_policia_arsenal:menu')
				end
			end
		end
		Wait(rsTD)
	end
end)
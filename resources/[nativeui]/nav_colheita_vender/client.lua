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
	if data == "graos" then
		TriggerServerEvent("colheita-vender","graos")
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local rsTD = 1000
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2885.68,4387.02,50.74,true)
		local vehicle = GetPlayersLastVehicle()
		if distance <= 3 and GetEntityModel(vehicle) == -1207771834 then
			rsTD = 4
			DrawMarker(21,2885.68,4387.02,50.74-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
					ToggleActionMenu()
				end
			end
		end
		Wait(rsTD)
	end
end)
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
	if data == "bronze" then
		TriggerServerEvent("minerador-crafting","bronze")
	elseif data == "ferro" then
		TriggerServerEvent("minerador-crafting","ferro")
	elseif data == "ouro" then
		TriggerServerEvent("minerador-crafting","ouro")
	elseif data == "rubi" then
		TriggerServerEvent("minerador-crafting","rubi")
	elseif data == "esmeralda" then
		TriggerServerEvent("minerador-crafting","esmeralda")
	elseif data == "safira" then
		TriggerServerEvent("minerador-crafting","safira")
	elseif data == "diamante" then
		TriggerServerEvent("minerador-crafting","diamante")
	elseif data == "topazio" then
		TriggerServerEvent("minerador-crafting","topazio")
	elseif data == "ametista" then
		TriggerServerEvent("minerador-crafting","ametista")


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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1085.06,-2002.56,31.38,true)
		if distance <= 3 then
			rsTD = 4
			DrawMarker(21,1085.06,-2002.56,31.38-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Wait(rsTD)
	end
end)
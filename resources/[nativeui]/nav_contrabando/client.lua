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
	if data == "armamentos-comprar-hkp7m10" then
		TriggerServerEvent("contrabando-comprar","wbody|WEAPON_SNSPISTOL")
	elseif data == "armamentos-comprar-uzi" then
		TriggerServerEvent("contrabando-comprar","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-comprar-mtar21" then
		TriggerServerEvent("contrabando-comprar","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-comprar-ak103" then
		TriggerServerEvent("contrabando-comprar","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == "armamentos-comprar-magnum44" then
		TriggerServerEvent("contrabando-comprar","wbody|WEAPON_REVOLVER")
	elseif data == "armamentos-comprar-thompson" then
		TriggerServerEvent("contrabando-comprar","wbody|WEAPON_GUSENBERG")

	elseif data == "armamentos-vender-hkp7m10" then
		TriggerServerEvent("contrabando-vender","wbody|WEAPON_SNSPISTOL")
	elseif data == "armamentos-vender-uzi" then
		TriggerServerEvent("contrabando-vender","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-vender-mtar21" then
		TriggerServerEvent("contrabando-vender","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-vender-ak103" then
		TriggerServerEvent("contrabando-vender","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == "armamentos-vender-magnum44" then
		TriggerServerEvent("contrabando-vender","wbody|WEAPON_REVOLVER")
	elseif data == "armamentos-vender-thompson" then
		TriggerServerEvent("contrabando-vender","wbody|WEAPON_GUSENBERG")


	elseif data == "municoes-comprar-hkp7m10" then
		TriggerServerEvent("contrabando-comprar","wammo|WEAPON_SNSPISTOL")
	elseif data == "municoes-comprar-uzi" then
		TriggerServerEvent("contrabando-comprar","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-comprar-ak103" then
		TriggerServerEvent("contrabando-comprar","wammo|WEAPON_ASSAULTRIFLE")
	elseif data == "municoes-comprar-magnum44" then
		TriggerServerEvent("contrabando-comprar","wammo|WEAPON_REVOLVER")
	elseif data == "municoes-comprar-thompson" then
		TriggerServerEvent("contrabando-comprar","wammo|WEAPON_GUSENBERG")

	elseif data == "municoes-vender-hkp7m10" then
		TriggerServerEvent("contrabando-vender","wammo|WEAPON_SNSPISTOL")
	elseif data == "municoes-vender-uzi" then
		TriggerServerEvent("contrabando-vender","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-vender-ak103" then
		TriggerServerEvent("contrabando-vender","wammo|WEAPON_ASSAULTRIFLE")
	elseif data == "municoes-vender-magnum44" then
		TriggerServerEvent("contrabando-vender","wammo|WEAPON_REVOLVER")
	elseif data == "municoes-vender-thompson" then
		TriggerServerEvent("contrabando-vender","wammo|WEAPON_GUSENBERG")


	elseif data == "utilidades-comprar-algemas" then
		TriggerServerEvent("contrabando-comprar","algemas")
	elseif data == "utilidades-comprar-capuz" then
		TriggerServerEvent("contrabando-comprar","capuz")
	elseif data == "utilidades-comprar-lockpick" then
		TriggerServerEvent("contrabando-comprar","lockpick")
	elseif data == "utilidades-comprar-masterpick" then
		TriggerServerEvent("contrabando-comprar","masterpick")
	elseif data == "utilidades-comprar-pendrive" then
		TriggerServerEvent("contrabando-comprar","pendrive")
	elseif data == "utilidades-comprar-c4" then
		TriggerServerEvent("contrabando-comprar","c4")
	elseif data == "utilidades-comprar-placa" then
		TriggerServerEvent("contrabando-comprar","placa")
	elseif data == "utilidades-comprar-keycard" then
		TriggerServerEvent("contrabando-comprar","keycard")

	elseif data == "utilidades-vender-algemas" then
		TriggerServerEvent("contrabando-vender","algemas")
	elseif data == "utilidades-vender-capuz" then
		TriggerServerEvent("contrabando-vender","capuz")
	elseif data == "utilidades-vender-lockpick" then
		TriggerServerEvent("contrabando-vender","lockpick")
	elseif data == "utilidades-vender-masterpick" then
		TriggerServerEvent("contrabando-vender","masterpick")
	elseif data == "utilidades-vender-pendrive" then
		TriggerServerEvent("contrabando-vender","pendrive")
	elseif data == "utilidades-vender-c4" then
		TriggerServerEvent("contrabando-vender","c4")
	elseif data == "utilidades-vender-placa" then
		TriggerServerEvent("contrabando-vender","placa")
	elseif data == "utilidades-vender-keycard" then
		TriggerServerEvent("contrabando-vender","keycard")


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
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1243.25,1869.41,78.96,true)
		if distance <= 3 then
			rsTD = 4
			DrawMarker(21,1243.25,1869.41,78.96-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
		Wait(rsTD)
	end
end)
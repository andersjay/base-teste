local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
dogz = Tunnel.getInterface("vRP")
func = Tunnel.getInterface("vrp_notifypush")
local cachehud = {}
local sBuffer = {}
local vBuffer = {}
local CintoSeguranca = false
local ExNoCarro = false
local hour = nil
local minute = nil
local street = ""
local vehicleSignalIndicator = 'off'
local farol = "off"
local rua = ""
local carroLigado = true
local running = false
local engine = 0
local marcha = 0
local fuel = 0
local inCar = false
local hunger = 100
local thirst = 100


AddEventHandler("gameEventTriggered", function(eventName,args) 
	if eventName == "CEventNetworkPlayerEnteredVehicle" then 
		inCar = true
		while true do
			Citizen.Wait(5)	
			local ped = PlayerPedId()
			vehicle = GetVehiclePedIsIn(ped, false)
			running = GetIsVehicleEngineRunning(vehicle)
			if running then
				carroLigado = true;				
			else 
				carroLigado = false;
			end
			if carroLigado ~= false then
				SendNUIMessage({ action = 'setMotor', id = 'motor', value = carroLigado})
				cachehud.running = running
				local speed = math.ceil(GetEntitySpeed(vehicle) * 3.605936)
				local _,lights,highlights = GetVehicleLightsState(vehicle)
				marcha = GetVehicleCurrentGear(vehicle)
				local lock = GetVehicleDoorLockStatus(vehicle)
				fuel = GetVehicleFuelLevel(vehicle)
				engine = GetVehicleEngineHealth(vehicle)
			

				if lights == 1 and highlights == 0 then 
					farol = "normal"
				elseif (lights == 1 and highlights == 1) or (lights == 0 and highlights == 1) then 
					farol = "alto"
				elseif lights == 0 then
					farol = "off"
				end

				if marcha == 0 and speed > 0 then 
					marcha = "R" 
				elseif marcha == 0 and speed < 2 then 
					marcha = "N" 
				end
				if lock ~= cachehud.lock then
					cachehud.lock = lock	
					print(cachehud.lock)
        	        SendNUIMessage({ action = 'setLock', id = 'lock', value = lock})	
				end

				

				if carroLigado ~= cachehud.carroLigado then
					cachehud.carroLigado = carroLigado	
				SendNUIMessage({ action = 'setMotor', id = 'motor', value = carroLigado})
				end
				if marcha ~= cachehud.marcha then
					cachehud.marcha = marcha	
				SendNUIMessage({ action = 'setMarcha', id = 'marcha', value = marcha})	
				end
				if speed ~= cachehud.speed then
					cachehud.speed = speed	
				SendNUIMessage({ action = 'setSpeed', id = 'speed', value = speed})	
				end
				if engine ~= cachehud.engine then
					cachehud.engine = engine	
				SendNUIMessage({ action = 'setDurability', id = 'durability', value = engine})
				end
				if fuel ~= cachehud.fuel then
					cachehud.fuel = fuel
				SendNUIMessage({ action = 'setFuel', id = 'fuel', value = fuel})	
				end
				if farol ~= cachehud.farol then
					cachehud.farol = farol
				SendNUIMessage({ action = 'setLight', id = 'lights', value = farol})
				end

				-- local car = GetVehiclePedIsIn(ped)

				if car ~= 0  then
					if CintoSeguranca then
						SetPedConfigFlag(PlayerPedId(), 32, false)
						DisableControlAction(0,75)
					else
						SetPedConfigFlag(PlayerPedId(), 32, true)
					end
				end	
			end
				
			end
	end
end)

RegisterCommand('gas',function()
	fuel = GetVehicleFuelLevel(vehicle)


end)

RegisterKeyMapping("porcinto","Cinto","keyboard","g")
RegisterCommand("porcinto",function()
	local ped = PlayerPedId()
	local car = GetVehiclePedIsIn(ped)
	if carroLigado then
		if CintoSeguranca then
			TriggerEvent("vrp_sound:source","unbelt",0.5)
			CintoSeguranca = false
		else
			TriggerEvent("vrp_sound:source","belt",0.5)
			CintoSeguranca = true
		end
		SendNUIMessage({ action = 'setCinto', id = 'cinto', value = CintoSeguranca})

	end
end)
AddEventHandler("dallas:setRadio", function(radio)
	SendNUIMessage({action = 'hudChannel',value = radio}) 
end)

AddEventHandler("pma-voice:radioActive", function(status)
	SendNUIMessage({action = 'talkingRadio',value = status}) 
end)

RegisterNetEvent("pma-voice:setTalkingMode")
AddEventHandler("pma-voice:setTalkingMode", function(_mode) 
	SendNUIMessage({ action = 'hudMode',value = _mode })
 end)

local shownui = true
RegisterCommand("hud",function(source,args)
	shownui = not shownui
end)

RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	shownui = not status
end)

RegisterNetEvent("hudActived")
AddEventHandler("hudActived",function(status)
	shownui = status
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if playerActive then
			local ped = PlayerPedId()
			if GetGameTimer() >= updateFoods and GetEntityHealth(ped) > 101 then
				updateFoods = GetGameTimer() + 90000
				thirst = thirst - 1
				hunger = hunger - 1
				dogz.clientFoods()
			
			end
		end

		Citizen.Wait(30000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			if hunger >= 6 and hunger <= 15 then
				ApplyDamageToPed(ped,1,false)
				TriggerEvent("Notify","alert","<b>Aviso</b><br>Você está com fome!",5000)
			elseif hunger <= 5 then
				ApplyDamageToPed(ped,2,false)
				TriggerEvent("Notify","alert","<b>Aviso</b><br>Você está com fome!",5000)
			end

			if thirst >= 6 and thirst <= 15 then
				ApplyDamageToPed(ped,1,false)
				TriggerEvent("Notify","alert","<b>Aviso</b><br>Você está com sede!",5000)
			elseif thirst <= 5 then
				ApplyDamageToPed(ped,2,false)
				TriggerEvent("Notify","alert","<b>Aviso</b><br>Você está com sede!",5000)
			end
		end

		Citizen.Wait(15000)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSFOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusHunger", function(statusHunger)
	hunger = parseInt(statusHunger)
end)

RegisterNetEvent("statusThirst", function(statusThrist)
	thirst = parseInt(statusThrist)
end)


Citizen.CreateThread(function()
	Wait(1000)
	SendNUIMessage({ action = 'hudMode',value = 2 })
	while true do
			local ped = PlayerPedId()
			local vida = math.ceil((100 * ((GetEntityHealth(ped) - 100) / (GetEntityMaxHealth(ped) - 100))))
			local armour = GetPedArmour(ped)
			local coords = GetEntityCoords(ped)
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))


			hours = GetClockHours()
			minutes = GetClockMinutes()

			if hours <= 9 then
				hours = "0"..hours
			end

			if minutes <= 9 then
				minutes = "0"..minutes
			end
			
			if streetName ~= cachehud.streetName then
				cachehud.streetName = streetName
			SendNUIMessage({ action = 'setLocation', id = 'location', value = streetName})
			end
			if vida ~= cachehud.vida then
				cachehud.vida = vida
			SendNUIMessage({ action = 'setHealth', id = 'health', value = vida})
			end
			if hunger ~= cachehud.hunger then
				cachehud.hunger = hunger
			SendNUIMessage({ action = 'setHunger', id = 'hunger', value = hunger})
			end
			if thirst ~= cachehud.thirst then
				cachehud.thirst = thirst
			SendNUIMessage({ action = 'setThirst', id = 'thirst', value = thirst})
			end
			if armour ~= cachehud.armour then
				cachehud.armour = armour
				print(cachehud.armour .. 'Armour')
			SendNUIMessage({ action = 'setArmour', id = 'armour', value = armour})
			end
			if hours ~= cachehud.hours or minutes ~= cachehud.minutes then
				cachehud.hours = hours
				cachehud.minutes = hours
			SendNUIMessage({ action = 'setTime', id = 'time', value = hours..":"..minutes })
			end
			
			if not IsPedInAnyVehicle(PlayerPedId(), false) then 
				DisplayRadar(false)
				CintoSeguranca = false
				SendNUIMessage({
					action = "update"
				})
			else
				DisplayRadar(true)
				SendNUIMessage({
					action = "inCar"
				})
			end

			SendNUIMessage({ action = 'micColor',value = NetworkIsPlayerTalking(PlayerId()) })
			if IsPauseMenuActive() or  not shownui then
				SendNUIMessage({ action = 'setDisplay',value = false })
			else
				SendNUIMessage({ action = 'setDisplay', value = true })
			end
		Citizen.Wait(500)	
	end
end)

Citizen.CreateThread(function()
    SetFlyThroughWindscreenParams(25.0, 2.0, 15.0, 15.0) 
    SetPedConfigFlag(PlayerPedId(), 32, true)
end)

RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({action = 'setProgress', id = 'progress', value = progressTimer, progress = true, progressTimer = parseInt(progressTimer - 500)})
end)

RegisterCommand("progress", function()
	TriggerEvent("Progress", 10000)
end)

function Alert(title, message, time, type)
	title = type
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('nyo_notify')
AddEventHandler('nyo_notify', function(color, type, title, message, time)
	Alert(title, message, time, type)
end)

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(title,message,time)
	if time == nil then
		time = 5000
	end
	Alert(title, message, time, title)
end)


-- Blackout
local isBlackout = false
local oldSpeed = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
            local currentSpeed = GetEntitySpeed(vehicle)*2.236936
            if currentSpeed ~= oldSpeed then
                if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
                    blackout()
                end
                oldSpeed = currentSpeed
            end
        else
            if oldSpeed ~= 0 then
                oldSpeed = 0
            end
        end

        if isBlackout then
            DisableControlAction(0,71,true)
            DisableControlAction(0,72,true)
            DisableControlAction(0,63,true)
            DisableControlAction(0,64,true)
            DisableControlAction(0,75,true)
        end
    end
end)

function blackout()
    TriggerEvent("vrp_sound:source",'heartbeat',0.5)
    if not isBlackout then
        isBlackout = false
        SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-100)
		
        Citizen.CreateThread(function()
            DoScreenFadeOut(500)
            while not IsScreenFadedOut() do
                Citizen.Wait(10)
            end
            Citizen.Wait(5000)
            DoScreenFadeIn(5000)
            isBlackout = false
        end)
    end
end

--Progress bar

RegisterNetEvent("Progress")
AddEventHandler("Progress",function(progressTimer)
	SendNUIMessage({ progress = true, progressTimer = parseInt(progressTimer - 500) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NPC CONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        SetVehicleDensityMultiplierThisFrame(0.0)
        SetPedDensityMultiplierThisFrame(0.0)
        SetParkedVehicleDensityMultiplierThisFrame(0.0)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        Citizen.Wait(1)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR O [Q]
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if health >= 101 then
        DisableControlAction(0,44,true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR X NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
	Citizen.Wait(5)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsIn(ped)
		if GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
			DisableControlAction(0,73,true) 
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURAR PNEUS ASSIM QUE CAPOTAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local roll = GetEntityRoll(vehicle)
                if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
					  if IsVehicleTyreBurst(vehicle, wheel_rm1, 0) == false then
						rsTD = 4
                    SetVehicleTyreBurst(vehicle, 0, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 1, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 2, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 3, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 4, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 5, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 45, 1)
                    Citizen.Wait(100)
                    SetVehicleTyreBurst(vehicle, 47, 1)
                    end
                end
            end
		end
		Wait(rsTD)
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
        local ped = PlayerPedId()
		if IsPedArmed(ped,6) then
			rsTD = 4
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
		end
		Wait(rsTD)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local speed = GetEntitySpeed(vehicle)*2.236936
				if speed >= 40 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVA O CONTROLE DO CARRO ENQUANTO ESTIVER NO AR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if DoesEntityExist(veh) and not IsEntityDead(veh) then
			rsTD = 4
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABicycle(model) and not IsThisModelABike(model) and not IsThisModelAQuadbike(model) and IsEntityInAir(veh) then
                DisableControlAction(0,59)
                DisableControlAction(0,60)
                --DisableControlAction(0,73)
            end
		end
		Wait(rsTD)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURAR OS PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
                local speed = GetEntitySpeed(vehicle)*2.236936
                if speed >= 180 and math.random(100) >= 97 then
                    if GetVehicleTyresCanBurst(vehicle) == false then return end
                    local pneus = GetVehicleNumberOfWheels(vehicle)
                    local pneusEffects
                    if pneus == 2 then
                        pneusEffects = (math.random(2)-1)*4
                    elseif pneus == 4 then
                        pneusEffects = (math.random(4)-1)
                        if pneusEffects > 1 then
                            pneusEffects = pneusEffects + 2
                        end
                    elseif pneus == 6 then
                        pneusEffects = (math.random(6)-1)
                    else
                        pneusEffects = 0
                    end
                    SetVehicleTyreBurst(vehicle,pneusEffects,false,1000.0)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			rsTD = 4
			local speed = GetEntitySpeed(vehicle)*2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped 
				and (GetEntityModel(vehicle) ~= GetHashKey("coach") 
					and GetEntityModel(vehicle) ~= GetHashKey("bus") 
					and GetEntityModel(vehicle) ~= GetHashKey("youga2") 
					and GetEntityModel(vehicle) ~= GetHashKey("ratloader") 
					and GetEntityModel(vehicle) ~= GetHashKey("taxi") 
					and GetEntityModel(vehicle) ~= GetHashKey("boxville4") 
					and GetEntityModel(vehicle) ~= GetHashKey("trash2") 
					and GetEntityModel(vehicle) ~= GetHashKey("tiptruck") 
					and GetEntityModel(vehicle) ~= GetHashKey("rebel") 
					and GetEntityModel(vehicle) ~= GetHashKey("speedo") 
					and GetEntityModel(vehicle) ~= GetHashKey("phantom") 
					and GetEntityModel(vehicle) ~= GetHashKey("packer") 
					and GetEntityModel(vehicle) ~= GetHashKey("paramedicoambu")) then
					if speed <= 100.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end    
			end
		end
		Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(769322946975367188)
		SetDiscordRichPresenceAsset('logoronystore')
		SetRichPresence('discord.gg/6JKXNnXJeS')
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			rsTD = 4
			SetPedToRagdoll(ped,10000,10000,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			rsTD = 4
			tasertime = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			SetTimeout(5000,function()
				SetTimecycleModifier("hud_def_desat_Trevor")
				SetTimeout(10000,function()
					SetTimecycleModifier("")
					SetTransitionTimecycleModifier("")
					StopGameplayCamShaking()
				end)
			end)
		end
		Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKLIST WEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
blackWeapons = {
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	--"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	--"WEAPON_RAYPISTOL",
	"WEAPON_SMG_MK2",
	--"WEAPON_MACHINEPISTOL",
	"WEAPON_MINISMG",
	"WEAPON_RAYCARBINE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_ASSAULTRIFLE_MK2",
	--"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	--"WEAPON_COMPACTRIFLE",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	--"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RPG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_MINIGUN",
	--"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_GRENADE",
	--"WEAPON_BZGAS",
	"WEAPON_MOLOTOV",
	--"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_PIPEBOMB",
	"WEAPON_SNOWBALL",
	"WEAPON_BALL",
	"WEAPON_SMOKEGRENADE"
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in ipairs(blackWeapons) do
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(v) then
				RemoveWeaponFromPed(PlayerPedId(),GetHashKey(v))
				TriggerServerEvent("adminLogs:Armamentos", v)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
-- local isBlackout = false
-- local oldSpeed = 0
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		local vehicle = GetVehiclePedIsIn(PlayerPedId())
-- 		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
-- 			local currentSpeed = GetEntitySpeed(vehicle)*2.236936
-- 			if currentSpeed ~= oldSpeed then
-- 				if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
-- 					blackout()
-- 				end
-- 				oldSpeed = currentSpeed
-- 			end
-- 		else
-- 			if oldSpeed ~= 0 then
-- 				oldSpeed = 0
-- 			end
-- 		end

-- 		if isBlackout then
-- 			DisableControlAction(0,63,true)
-- 			DisableControlAction(0,64,true)
-- 			DisableControlAction(0,71,true)
-- 			DisableControlAction(0,72,true)
-- 			DisableControlAction(0,75,true)
-- 		end
-- 	end
-- end)

-- function blackout()
-- 	TriggerEvent("vrp_sound:source",'heartbeat',0.5)
-- 	if not isBlackout then
-- 		isBlackout = true
-- 		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-200)
-- 		Citizen.CreateThread(function()
-- 			DoScreenFadeOut(500)
-- 			while not IsScreenFadedOut() do
-- 				Citizen.Wait(10)
-- 			end
-- 			Citizen.Wait(5000)
-- 			DoScreenFadeIn(5000)
-- 			isBlackout = false
-- 		end)
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DAMAGE WALK MODE
-----------------------------------------------------------------------------------------------------------------------------------------
local hurt = false
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) then
			if GetEntityHealth(ped) <= 199 then
				setHurt()
				rsTD = 4
			elseif hurt and GetEntityHealth(ped) > 200 then
				setNotHurt()
			end
		end
		Wait(rsTD)
	end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(),"move_m@injured",true)
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	DisableControlAction(0,21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN BUNNYHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyhop = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
        local ped = PlayerPedId()
		if IsPedJumping(ped) and bunnyhop <= 0 then
			rsTD = 4
            bunnyhop = 5
        end
		if bunnyhop > 0 then
			rsTD = 4
            DisableControlAction(0,22,true)
        end
        Wait(rsTD)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICAM
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 80.0
local fov_min = 10.0
local zoomspeed = 2.0
local speed_lr = 3.0
local speed_ud = 3.0
local helicam = false
local fov = (fov_max+fov_min)*0.5

Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		if IsPlayerInPolmav() then
			local heli = GetVehiclePedIsIn(PlayerPedId())
			SetVehicleRadioEnabled(heli,false)
			if IsHeliHighEnough(heli) then
				rsTD = 4
				if IsControlJustPressed(0,51) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					helicam = true
				end
				if IsControlJustPressed(0,154) then
					if GetPedInVehicleSeat(heli,1) == PlayerPedId() or GetPedInVehicleSeat(heli,2) == PlayerPedId() then
						PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
						TaskRappelFromHeli(PlayerPedId(),1)
					end
				end
			end
		end

		if helicam then
			rsTD = 4
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end
			local heli = GetVehiclePedIsIn(PlayerPedId())
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,heli,0.0,0.0,-1.5,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam,fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform,"SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0)
			PopScaleformMovieFunctionVoid()
			while helicam and not IsEntityDead(PlayerPedId()) and (GetVehiclePedIsIn(PlayerPedId()) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(0,51) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					helicam = false
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam,zoomvalue)
				HandleZoom(cam)
				HideHUDThisFrame()
				PushScaleformMovieFunction(scaleform,"SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam,2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(10)
			end
			helicam = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false,false,0,1,0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam,false)
			SetNightvision(false)
			SetSeethrough(false)
		end
		Wait(rsTD)
	end
end)

function IsPlayerInPolmav()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	return IsVehicleModel(vehicle,GetHashKey("paramedicoheli")) or IsVehicleModel(vehicle,GetHashKey("policiaheli"))
end

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
end

function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z+rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then
		fov = math.max(fov-zoomspeed,fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov+zoomspeed,fov_max)
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then
		fov = current_fov
	end
	SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0),10,GetVehiclePedIsIn(PlayerPedId()),0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit > 0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num,math.cos(z)*num,math.sin(x))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADAR
-----------------------------------------------------------------------------------------------------------------------------------------
local radar = {
	shown = false,
	freeze = false,
	info = "INICIANDO O SISTEMA DO RADAR",
	info2 = "INICIANDO O SISTEMA DO RADAR"
}

Citizen.CreateThread(function()
	while true do
		Wait(5)
		local veh = GetVehiclePedIsIn(PlayerPedId())
		if IsControlJustPressed(1,306) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
			if radar.shown then
				radar.shown = false
			else
				radar.shown = true
			end
		end

		if IsControlJustPressed(1,301) and IsPedInAnyPoliceVehicle(PlayerPedId()) then
			if radar.freeze then
				radar.freeze = false
			else
				radar.freeze = true
			end
		end

		if radar.shown then
			if radar.freeze == false then
				local coordA = GetOffsetFromEntityInWorldCoords(veh,0.0,1.0,1.0)
				local coordB = GetOffsetFromEntityInWorldCoords(veh,0.0,105.0,0.0)
				local frontcar = StartShapeTestCapsule(coordA,coordB,3.0,10,veh,7)
				local a,b,c,d,e = GetShapeTestResult(frontcar)

				if IsEntityAVehicle(e) then
					local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
					local fvspeed = GetEntitySpeed(e)*2.236936
					local fplate = GetVehicleNumberPlateText(e)
					radar.info = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",fplate,fmodel,math.ceil(fvspeed))
				end

				local bcoordB = GetOffsetFromEntityInWorldCoords(veh,0.0,-105.0,0.0)
				local rearcar = StartShapeTestCapsule(coordA,bcoordB,3.0,10,veh,7)
				local f,g,h,i,j = GetShapeTestResult(rearcar)

				if IsEntityAVehicle(j) then
					local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
					local bvspeed = GetEntitySpeed(j)*2.236936
					local bplate = GetVehicleNumberPlateText(j)
					radar.info2 = string.format("~y~PLACA: ~w~%s   ~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MPH",bplate,bmodel,math.ceil(bvspeed))
				end
			end
			drawTxt(radar.info,4,0.5,0.905,0.50,255,255,255,180)
			drawTxt(radar.info2,4,0.5,0.93,0.50,255,255,255,180)
		end

		if not IsPedInAnyVehicle(PlayerPedId()) and radar.shown then
			radar.shown = false
		end
	end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE HUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	AddTextEntry('FE_THDR_GTAO', 'Rony Store v1.0')
	local rsTD = 1000
	while true do
		rsTD = 4
		N_0xf4f2c0d4ee209e20()
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"),1.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"),0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DAGGER"),0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"),0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BATTLEAXE"),0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_STONE_HATCHET"),0.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"),0.2)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"),0.0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"),0.0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),2.5)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"),1.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"),1.4)
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		HideHudComponentThisFrame(23)
		HideHudComponentThisFrame(24)
		HideHudComponentThisFrame(25)
		HideHudComponentThisFrame(26)
		HideHudComponentThisFrame(27)
		HideHudComponentThisFrame(28)
		HideHudComponentThisFrame(29)
		HideHudComponentThisFrame(30)
		HideHudComponentThisFrame(31)
		HideHudComponentThisFrame(32)
		HideHudComponentThisFrame(33)
		HideHudComponentThisFrame(34)
		HideHudComponentThisFrame(35)
		HideHudComponentThisFrame(36)
		HideHudComponentThisFrame(37)
		HideHudComponentThisFrame(38)
		HideHudComponentThisFrame(39)
		HideHudComponentThisFrame(40)
		HideHudComponentThisFrame(41)
		HideHudComponentThisFrame(42)
		HideHudComponentThisFrame(43)
		HideHudComponentThisFrame(44)
		HideHudComponentThisFrame(45)
		HideHudComponentThisFrame(46)
		HideHudComponentThisFrame(47)
		HideHudComponentThisFrame(48)
		HideHudComponentThisFrame(49)
		HideHudComponentThisFrame(50)
		HideHudComponentThisFrame(51)
		RemoveAllPickupsOfType(0x6C5B941A)
		RemoveAllPickupsOfType(0xF33C83B0)
		RemoveAllPickupsOfType(0xDF711959)
		RemoveAllPickupsOfType(0xB2B5325E)
		RemoveAllPickupsOfType(0x85CAA9B1)
		RemoveAllPickupsOfType(0xB2930A14)
		RemoveAllPickupsOfType(0xFE2A352C)
		RemoveAllPickupsOfType(0x693583AD)
		RemoveAllPickupsOfType(0x1D9588D3)
		RemoveAllPickupsOfType(0x3A4C2AD2)
		RemoveAllPickupsOfType(0x4D36C349)
		RemoveAllPickupsOfType(0x2F36B434)
		RemoveAllPickupsOfType(0xA9355DCD)
		RemoveAllPickupsOfType(0x96B412A3)
		RemoveAllPickupsOfType(0x9299C95B)
		RemoveAllPickupsOfType(0xF9AFB48F)
		RemoveAllPickupsOfType(0x8967B4F3)
		RemoveAllPickupsOfType(0x3B662889)
		RemoveAllPickupsOfType(0xFD16169E)
		RemoveAllPickupsOfType(0xCB13D282)
		RemoveAllPickupsOfType(0xC69DE3FF)
		RemoveAllPickupsOfType(0x278D8734)
		RemoveAllPickupsOfType(0x5EA16D74)
		RemoveAllPickupsOfType(0x295691A9)
		RemoveAllPickupsOfType(0x81EE601E)
		RemoveAllPickupsOfType(0x88EAACA7)
		RemoveAllPickupsOfType(0x872DC888)
		RemoveAllPickupsOfType(0xC5B72713)
		RemoveAllPickupsOfType(0x9CF13918)
		RemoveAllPickupsOfType(0x0968339D)
		RemoveAllPickupsOfType(0xBFEE6C3B)
		RemoveAllPickupsOfType(0xBED46EC5)
		RemoveAllPickupsOfType(0x079284A9)
		RemoveAllPickupsOfType(0x8ADDEC75)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedInfiniteAmmo(PlayerPedId(),true,GetHashKey("WEAPON_FIREEXTINGUISHER"))
		SetCreateRandomCops(false)
		SetGarbageTrucks(false)
		SetRandomBoats(false)
		SetVehicleModelIsSuppressed(GetHashKey("pounder"),true)

		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		RemoveVehiclesFromGeneratorsInArea(x-9999.0,y-9999.0,z-9999.0,x+9999.0,y+9999.0,z+9999.0)

		Citizen.Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	LoadInterior(GetInteriorAtCoords(440.84,-983.14,30.69))
	for _,ipl in pairs(allIpls) do
		loadInt(ipl.coords,ipl.interiorsProps)
	end
end)

function loadInt(coordsTable,table)
	local rsTD = 1000
	for _,coords in pairs(coordsTable) do
		local interiorID = GetInteriorAtCoords(coords[1],coords[2],coords[3])
		LoadInterior(interiorID)
		rsTD = 4
		for _,propName in pairs(table) do
			Citizen.Wait(10)
			EnableInteriorProp(interiorID,propName)
		end
		RefreshInterior(interiorID)

		Wait(rsTD)
	end
end

allIpls = {
	{
		interiorsProps = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = {{ -1150.7,-1520.7,10.6 }}
	},
	{
		interiorsProps = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = {{ -47.1,-1115.3,26.5 }}
	},
	{
		interiorsProps = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = {{ -802.3,175.0,72.8 }}
	},
	{
		interiorsProps = {
			"meth_lab_basic",
			"meth_lab_production",
			"meth_lab_setup"
		},
		coords = {{ 1009.5,-3196.6,-38.9 }} -- Metanfetamina
	},
	{
		interiorsProps = {
			"security_high",
			"equipment_basic",
			"equipment_upgrade",
			"production_upgrade",
			"table_equipment_upgrade",
			"coke_press_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ 1093.6,-3196.6,-38.9 }} -- Cocaina
	},
	{
		interiorsProps = {
			"counterfeit_cashpile100a",
			"counterfeit_cashpile100b",
			"counterfeit_cashpile100c",
			"counterfeit_cashpile100d",
			"counterfeit_security",
			"counterfeit_setup",
			"counterfeit_standard_equip",
			"money_cutter",
			"special_chairs",
			"dryera_on",
			"dryerb_on",
			"dryerc_on",
			"dryerd_on"
		},
		coords = {{ 1121.0,-3196.0,-40.4 }} -- Lavagem
	},
	{
		interiorsProps = {
			"coke_stash1",
			"coke_stash2",
			"coke_stash3",
			"decorative_02",
			"furnishings_02",
			"walls_01",
			"mural_02",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 1107.0,-3157.3,-37.5 }} -- Motoclub
	},
	{
		interiorsProps = {
			"coke_large",
			"decorative_01",
			"furnishings_01",
			"walls_01",
			"lower_walls_default",
			"gun_locker",
			"mod_booth"
		},
		coords = {{ 998.4,-3164.7,-38.9 }} -- Motoclub2
	},
	{
		interiorsProps = {
			"chair01",
			"equipment_basic",
			"interior_upgrade",
			"security_low",
			"set_up"
		},
		coords = {{ 1163.8,-3195.7,-39.0 }} -- Escritório
	},
	{
		interiorsProps = {
			"garage_decor_01",
			"garage_decor_02",
			"garage_decor_03",
			"garage_decor_04",
			"lighting_option01",
			"lighting_option02",
			"lighting_option03",
			"lighting_option04",
			"lighting_option05",
			"lighting_option06",
			"lighting_option07",
			"lighting_option08",
			"lighting_option09",
			"numbering_style01_n3",
			"numbering_style02_n3",
			"numbering_style03_n3",
			"numbering_style04_n3",
			"numbering_style05_n3",
			"numbering_style06_n3",
			"numbering_style07_n3",
			"numbering_style08_n3",
			"numbering_style09_n3",
			"urban_style_set",
			"car_floor_hatch",
			"door_blocker"
		},
		coords = {{ 994.59,-3002.59,-39.64 }} -- Mecanica
	},
	{
		interiorsProps = {
			"bunker_style_a",
			"upgrade_bunker_set",
			"security_upgrade",
			"office_upgrade_set",
			"gun_wall_blocker",
			"gun_range_lights",
			"gun_locker_upgrade",
			"Gun_schematic_set"
		},
		coords = {{ 899.55,-3246.03,-98.04 }} -- Bunker
	},
	{
		interiorsProps = {
			"Int01_ba_clubname_01",
	        "Int01_ba_Style03",
	        "Int01_ba_style03_podium",
	        "Int01_ba_equipment_setup",
	        "Int01_ba_equipment_upgrade",
	        "Int01_ba_security_upgrade",
	        "Int01_ba_dj04",
	        "DJ_01_Lights_01",
	        "DJ_02_Lights_01",
	        "DJ_03_Lights_01",
	        "DJ_04_Lights_01",
	        "Int01_ba_bar_content",
	        "Int01_ba_booze_03",
	        "Int01_ba_trophy01",
	        "Int01_ba_Clutter",
	        "Int01_ba_deliverytruck",
	        "Int01_ba_dry_ice",
	        "light_rigs_off",
	        "Int01_ba_lightgrid_01",
	        "Int01_ba_trad_lights",
	        "Int01_ba_trophy04",
	        "Int01_ba_trophy05",
	        "Int01_ba_trophy07",
	        "Int01_ba_trophy08",
	        "Int01_ba_trophy09",
	        "Int01_ba_trophy10",
	        "Int01_ba_trophy11",
	        "Int01_ba_booze_01",
			"Int01_ba_booze_02",
			"Int01_ba_booze_03",
			"int01_ba_lights_screen",
			"Int01_ba_bar_content"
        },
		coords = {{ -1604.664, -3012.583, -78.00 }} -- Galaxy
	}
}


-- IPLOADER

Citizen.CreateThread(function()
	LoadMpDlcMaps()
	EnableMpDlcMaps(true)
	RequestIpl("coronertrash")
	RequestIpl("Coroner_Int_On")
	RequestIpl("chop_props")
	RemoveIpl("hei_bi_hw1_13_door")
	RequestIpl("v_rockclub")
	--RemoveIpl("rc12b_default")
	--RequestIpl("rc12b_hospitalinterior")
	--RequestIpl("rc12b_destroyed")
	RemoveIpl("v_carshowroom")
	RemoveIpl("shutter_open")
	RemoveIpl("shutter_closed")
	RemoveIpl("shr_int")
	RemoveIpl("csr_inMission")
	RequestIpl("v_carshowroom")
	RequestIpl("shr_int")
	RequestIpl("shutter_closed")
	RequestIpl("FINBANK")
	RemoveIpl("facelobbyfake")
	RequestIpl("facelobby")
	RemoveIpl("CS1_02_cf_offmission")
	RequestIpl("CS1_02_cf_onmission1")
	RequestIpl("CS1_02_cf_onmission2")
	RequestIpl("CS1_02_cf_onmission3")
	RequestIpl("CS1_02_cf_onmission4")
	RequestIpl("des_farmhouse")
	RequestIpl("des_farmhs_endimap")
	RequestIpl("des_farmhs_end_occl")
	RequestIpl("des_farmhs_startimap")
	RequestIpl("des_farmhs_start_occl")
	RequestIpl("farm")
	RemoveIpl("farm_burnt")
	RemoveIpl("farm_burnt_props")
	RemoveIpl("farmint_cap")
	RequestIpl("farmint")
	RemoveIpl("farm_props")
	RequestIpl("FIBlobby")
	RemoveIpl("FIBlobbyfake")
	RequestIpl("FBI_colPLUG")
	RequestIpl("FBI_repair")
	RemoveIpl("id2_14_during_door")
	RemoveIpl("id2_14_during2")
	RemoveIpl("id2_14_on_fire")
	RemoveIpl("id2_14_post_no_int")
	RemoveIpl("id2_14_pre_no_int")
	RequestIpl("id2_14_during1")
	RequestIpl("TrevorsMP")
	RequestIpl("TrevorsTrailer")
	RequestIpl("TrevorsTrailerTidy")
	RequestIpl("TrevorsTrailerTrash")
	RemoveIpl("DT1_03_Gr_Closed")
	RemoveIpl("DT1_03_Shutter")
	RequestIpl("yogagame")
	RequestIpl("v_tunnel_hole")
	RequestIpl("V_Michael")
	RequestIpl("V_Michael_Garage")
	RequestIpl("V_Michael_FameShame")
	RequestIpl("V_Michael_JewelHeist")
	RequestIpl("V_Michael_plane_ticket")
	RequestIpl("V_Michael_Scuba")
	RemoveIpl("smboat")
	RequestIpl("hei_yacht_heist")
	RequestIpl("hei_yacht_heist_Bar")
	RequestIpl("hei_yacht_heist_Bedrm")
	RequestIpl("hei_yacht_heist_Bridge")
	RequestIpl("hei_yacht_heist_DistantLights")
	RequestIpl("hei_yacht_heist_enginrm")
	RequestIpl("hei_yacht_heist_LODLights")
	RequestIpl("hei_yacht_heist_Lounge")
	RequestIpl("cargoship")
	RemoveIpl("sp1_10_fake_interior")
	RemoveIpl("sp1_10_fake_interior_lod")
	RequestIpl("railing_start")
	RequestIpl("railing_end")
	RequestIpl("SC1_01_NewBill")
	RequestIpl("hw1_02_newbill")
	RequestIpl("hw1_emissive_newbill")
	RequestIpl("sc1_14_newbill")
	RequestIpl("dt1_17_newbill")
	RequestIpl("SC1_01_OldBill")
	RequestIpl("SC1_30_Keep_Closed")
	RequestIpl("refit_unload")
	RequestIpl("post_hiest_unload")
	RequestIpl("occl_meth_grp1")
	RequestIpl("Michael_premier")
	RemoveIpl("DT1_05_HC_REMOVE")
	RequestIpl("DT1_05_HC_REQ")
	RequestIpl("DT1_05_REQUEST")
	RemoveIpl("jewel2fake")
	RemoveIpl("bh1_16_refurb")
	RemoveIpl("ch1_02_closed")
	RemoveIpl("scafstartimap")
	RequestIpl("scafendimap")
	RemoveIpl("bh1_16_doors_shut")
	RequestIpl("ferris_finale_Anim")
	RequestIpl("des_stilthouse_rebuild")
	RequestIpl("CS2_06_TriAf02")
	--RequestIpl("cs3_07_mpgates")
	RequestIpl("CS4_08_TriAf02")
	RequestIpl("CS4_04_TriAf03")
	RequestIpl("AP1_04_TriAf01")
	RequestIpl("gr_case0_bunkerclosed")
	RequestIpl("gr_case1_bunkerclosed")
	RequestIpl("gr_case2_bunkerclosed")
	RequestIpl("gr_case3_bunkerclosed")
	RequestIpl("gr_case4_bunkerclosed")
	RequestIpl("gr_case5_bunkerclosed")
	RequestIpl("gr_case6_bunkerclosed")
	RequestIpl("gr_case7_bunkerclosed")
	RequestIpl("gr_case9_bunkerclosed")
	RequestIpl("gr_case10_bunkerclosed")
	RequestIpl("gr_case11_bunkerclosed")
	RequestIpl("cs5_4_trains")
	RequestIpl("chophillskennel")
	RequestIpl("bnkheist_apt_dest")
	RequestIpl("bnkheist_apt_norm")
	RequestIpl("redcarpet")
	RequestIpl("hei_sm_16_interior_v_bahama_milo_")
	RequestIpl("cs3_05_water_grp1")
	RequestIpl("cs3_05_water_grp1_lod")
	RequestIpl("cs3_05_water_grp2")
	RequestIpl("cs3_05_water_grp2_lod")
	RequestIpl("canyonriver01")
	RequestIpl("canyonriver01_lod")
	RequestIpl("bh1_47_joshhse_unburnt")
	RequestIpl("bh1_47_joshhse_unburnt_lod")
	RequestIpl("bkr_bi_hw1_13_int")
	RequestIpl("CanyonRvrShallow")
	RequestIpl("methtrailer_grp1")
	RequestIpl("lr_cs6_08_grave_closed")
	RequestIpl("bkr_bi_id1_23_door")
	RequestIpl("ch1_02_open")
	RequestIpl("sp1_10_real_interior")
	RequestIpl("sp1_10_real_interior_lod")
	RequestIpl("Carwash_with_spinners")
	RequestIpl("apa_v_mp_h_01_a")
	RequestIpl("apa_v_mp_h_06_b")
	RequestIpl("apa_v_mp_h_08_c")
	RequestIpl("ex_dt1_02_office_01c")
	RequestIpl("ex_dt1_11_office_01b")
	RequestIpl("ex_sm_13_office_01a")
	RequestIpl("ex_sm_15_office_02b")
	RequestIpl("bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo")
	RequestIpl("bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo")
	RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo")
	RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware02_milo")
	RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware03_milo")
	RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware04_milo")
	RequestIpl("bkr_biker_interior_placement_interior_2_biker_dlc_int_ware05_milo")
	RequestIpl("bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo")
	RequestIpl("bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo")
	RequestIpl("bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo")
	RequestIpl("bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo")
	RequestIpl("ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo")
	RequestIpl("ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo")
	RequestIpl("ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo")
	RequestIpl("imp_impexp_interior_placement")
	RequestIpl("imp_impexp_interior_placement_interior_0_impexp_int_01_milo_")
	RequestIpl("imp_impexp_interior_placement_interior_1_impexp_intwaremed_milo_")
	RequestIpl("imp_impexp_interior_placement_interior_2_imptexp_mod_int_01_milo_")
	RequestIpl("imp_impexp_interior_placement_interior_3_impexp_int_02_milo_")
	RequestIpl("gr_case0_bunkerclosed")
	RequestIpl("gr_case1_bunkerclosed")
	RequestIpl("gr_case2_bunkerclosed")
	RequestIpl("gr_case3_bunkerclosed")
	RequestIpl("gr_case4_bunkerclosed")
	RequestIpl("gr_case5_bunkerclosed")
	RequestIpl("gr_case6_bunkerclosed")
	RequestIpl("gr_case7_bunkerclosed")
	RequestIpl("gr_case9_bunkerclosed")
	RequestIpl("gr_case10_bunkerclosed")
	RequestIpl("gr_case11_bunkerclosed")
	RequestIpl("gr_entrance_placement")
	RequestIpl("gr_grdlc_interior_placement")
	RequestIpl("gr_grdlc_interior_placement_interior_0_grdlc_int_01_milo_")
	RequestIpl("gr_grdlc_interior_placement_interior_1_grdlc_int_02_milo_")
	RequestIpl("ch3_rd2_bishopschickengraffiti")
	RequestIpl("cs5_04_mazebillboardgraffiti")
	RequestIpl("cs5_roads_ronoilgraffiti")
	RequestIpl("ba_barriers_case0")
	RequestIpl("ba_case0_forsale")
	RequestIpl("ba_case0_dixon")
	RequestIpl("ba_case0_madonna")
	RequestIpl("ba_case0_solomun")
	RequestIpl("ba_case0_taleofus")
	RequestIpl("ba_barriers_case1")
	RequestIpl("ba_case1_forsale")
	RequestIpl("ba_case1_dixon")
	RequestIpl("ba_case1_madonna")
	RequestIpl("ba_case1_solomun")
	RequestIpl("ba_case1_taleofus")
	RequestIpl("ba_barriers_case2")
	RequestIpl("ba_case2_forsale")
	RequestIpl("ba_case2_dixon")
	RequestIpl("ba_case2_madonna")
	RequestIpl("ba_case2_solomun")
	RequestIpl("ba_case2_taleofus")
	RequestIpl("ba_barriers_case3")
	RequestIpl("ba_case3_forsale")
	RequestIpl("ba_case3_dixon")
	RequestIpl("ba_case3_madonna")
	RequestIpl("ba_case3_solomun")
	RequestIpl("ba_case3_taleofus")
	RequestIpl("ba_barriers_case4")
	RequestIpl("ba_case4_forsale")
	RequestIpl("ba_case4_dixon")
	RequestIpl("ba_case4_madonna")
	RequestIpl("ba_case4_solomun")
	RequestIpl("ba_case4_taleofus")
	RequestIpl("ba_barriers_case5")
	RequestIpl("ba_case5_forsale")
	RequestIpl("ba_case5_dixon")
	RequestIpl("ba_case5_madonna")
	RequestIpl("ba_case5_solomun")
	RequestIpl("ba_case5_taleofus")
	RequestIpl("ba_barriers_case6")
	RequestIpl("ba_case6_forsale")
	RequestIpl("ba_case6_dixon")
	RequestIpl("ba_case6_madonna")
	RequestIpl("ba_case6_solomun")
	RequestIpl("ba_case6_taleofus")
	RequestIpl("ba_barriers_case7")
	RequestIpl("ba_case7_forsale")
	RequestIpl("ba_case7_dixon")
	RequestIpl("ba_case7_madonna")
	RequestIpl("ba_case7_solomun")
	RequestIpl("ba_case7_taleofus")
	RequestIpl("ba_barriers_case8")
	RequestIpl("ba_case8_forsale")
	RequestIpl("ba_case8_dixon")
	RequestIpl("ba_case8_madonna")
	RequestIpl("ba_case8_solomun")
	RequestIpl("ba_case8_taleofus")
	RequestIpl("ba_barriers_case9")
	RequestIpl("ba_case9_forsale")
	RequestIpl("ba_case9_dixon")
	RequestIpl("ba_case9_madonna")
	RequestIpl("ba_case9_solomun")
	RequestIpl("ba_case9_taleofus")
	RequestIpl("gr_grdlc_yacht_lod")
	RequestIpl("gr_grdlc_yacht_placement")
	RequestIpl("gr_heist_yacht2")
	RequestIpl("gr_heist_yacht2_bar")
	RequestIpl("gr_heist_yacht2_bar_lod")
	RequestIpl("gr_heist_yacht2_bedrm")
	RequestIpl("gr_heist_yacht2_bedrm_lod")
	RequestIpl("gr_heist_yacht2_bridge")
	RequestIpl("gr_heist_yacht2_bridge_lod")
	RequestIpl("gr_heist_yacht2_enginrm")
	RequestIpl("gr_heist_yacht2_enginrm_lod")
	RequestIpl("gr_heist_yacht2_lod")
	RequestIpl("gr_heist_yacht2_lounge")
	RequestIpl("gr_heist_yacht2_lounge_lod")
	RequestIpl("gr_heist_yacht2_slod")
end)
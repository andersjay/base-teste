-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_stockade",src)
vSERVER = Tunnel.getInterface("vrp_stockade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pos = 0
local nveh = nil
local pveh01 = nil
local pveh02 = nil
local CoordenadaX = 849.93
local CoordenadaY = -1284.28
local CoordenadaZ = 28.00
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1221.98, ['y'] = -317.20, ['z'] = 37.60, ['x2'] = 3592.08, ['y2'] = 3763.92, ['z2'] = 29.97, ['h'] = 296.26, ['lugar'] = "1/8" },
	[2] = { ['x'] = -347.37, ['y'] = -26.85, ['z'] = 47.44, ['x2'] = 1245.13, ['y2'] = -3142.11, ['z2'] = 5.55, ['h'] = 248.83, ['lugar'] = "2/8" },
	[3] = { ['x'] = 262.77, ['y'] = 183.03, ['z'] = 104.38, ['x2'] = -343.11, ['y2'] = -925.10, ['z2'] = 30.23, ['h'] = 69.89, ['lugar'] = "3/8" },
	[4] = { ['x'] = 315.79, ['y'] = -264.95, ['z'] = 53.89, ['x2'] = -959.25, ['y2'] = -3047.97, ['z2'] = 13.94, ['h'] = 247.07, ['lugar'] = "4/8" },
	[5] = { ['x'] = 136.28, ['y'] = -1022.26, ['z'] = 29.31, ['x2'] = -1134.31, ['y2'] = 2693.17, ['z2'] = 18.80, ['h'] = 248.58, ['lugar'] = "5/8" },
	[6] = { ['x'] = -2960.66, ['y'] = 466.03, ['z'] = 15.17, ['x2'] = 1710.03, ['y2'] = -1631.85, ['z2'] = 112.48, ['h'] = 84.10, ['lugar'] = "6/8" },
	[7] = { ['x'] = -130.42, ['y'] = 6467.32, ['z'] = 31.40, ['x2'] = 2712.63, ['y2'] = 1521.84, ['z2'] = 24.50, ['h'] = 133.70, ['lugar'] = "7/8" },
	[8] = { ['x'] = 1175.08, ['y'] = 2695.01, ['z'] = 37.92, ['x2'] = -446.65, ['y2'] = -452.10, ['z2'] = 32.95, ['h'] = 107.89, ['lugar'] = "8/8" }	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		if Vdist(CoordenadaX,CoordenadaY,CoordenadaZ,x,y,z) <= 3 then
			DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if Vdist(CoordenadaX,CoordenadaY,CoordenadaZ,x,y,z) <= 1 then
				drawTxt("PRESSIONE  ~g~E~w~  PARA HACKEAR",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and vSERVER.checkTimers() then
					TriggerEvent('cancelando',true)
					vRP._playAnim(false,{{"anim@heists@ornate_bank@hack","hack_loop"}},true)
					laptop = CreateObject(GetHashKey("prop_laptop_01a"),x-0.6,y+0.2,z-1,true,true,true)
					SetEntityHeading(ped,85.77)
					SetEntityHeading(laptop,85.77)
					TriggerEvent("mhacking:show")
					TriggerEvent("mhacking:start",3,20,mycallback)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
function mycallback(success,time)
	if success then	
		TriggerEvent("mhacking:hide")
		vSERVER.checkStockade()
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	else
		TriggerEvent("mhacking:hide")
		vSERVER.resetTimer()
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startStockade()
	pos = math.random(#locs)
	src.spawnStockade(locs[pos].x,locs[pos].y,locs[pos].z,locs[pos].x2,locs[pos].y2,locs[pos].z2,locs[pos].h)
	TriggerEvent("Notify","sucesso","Hackeado com sucesso, o carro forte está saindo do <b>Banco "..locs[pos].lugar.."</b>.",8000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.spawnStockade(x,y,z,x2,y2,z2,h)
	local vhash = GetHashKey("stockade")
	while not HasModelLoaded(vhash) do
		RequestModel(vhash)
		Citizen.Wait(10)
	end

	local phash = GetHashKey("s_m_m_security_01")
	while not HasModelLoaded(phash) do
		RequestModel(phash)
		Citizen.Wait(10)
	end

	SetModelAsNoLongerNeeded(phash)

	if HasModelLoaded(vhash) then
		nveh = CreateVehicle(vhash,x,y,z,h,true,false)

		N_0x06faacd625d80caa(nveh)
		SetEntityAsNoLongerNeeded(nveh)
		SetVehicleOnGroundProperly(nveh)
		SetVehicleDoorsLocked(nveh,2)

		pveh01 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),-1,true,false)
		pveh02 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),0,true,false)
		pveh03 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),1,true,false)
		pveh04 = CreatePedInsideVehicle(nveh,4,GetHashKey("s_m_m_security_01"),2,true,false)
		setPedPropertys(pveh01,"WEAPON_MINISMG")
		setPedPropertys(pveh02,"WEAPON_MINISMG")
		setPedPropertys(pveh03,"WEAPON_CARBINERIFLE")
		setPedPropertys(pveh04,"WEAPON_CARBINERIFLE")

		SetEntityAsMissionEntity(pveh01,false,false)
		SetEntityAsMissionEntity(pveh02,false,false)
		SetEntityAsMissionEntity(pveh03,false,false)
		SetEntityAsMissionEntity(pveh04,false,false)

		TaskVehicleDriveToCoordLongrange(pveh01,nveh,x2,y2,z2,10.0,1074528293,1.0)
	end
end

function setPedPropertys(npc,weapon)
	SetPedShootRate(npc,850)
	SetPedSuffersCriticalHits(npc,0)
	SetPedAlertness(npc,100)
	AddArmourToPed(npc,100)
	SetPedAccuracy(npc,100)
	SetPedArmour(npc,100)
	SetPedCanSwitchWeapon(npc,true)
	SetEntityHealth(npc,300)
	SetPedFleeAttributes(npc,0,0)
	SetPedConfigFlag(npc,118,false)
	SetPedCanRagdollFromPlayerImpact(npc,0)
	SetPedCombatAttributes(npc,46,true)
	SetEntityIsTargetPriority(npc,1,0)
	SetPedGetOutUpsideDownVehicle(npc,1)
	SetPedPlaysHeadOnHornAnimWhenDiesInVehicle(npc,1)
	SetPedKeepTask(npc,true)
	SetEntityLodDist(npc,250)
	SetPedCombatAbility(npc,2)
	SetPedCombatRange(npc,50)
	SetPedPathAvoidFire(npc,1)
	SetPedPathCanUseLadders(npc,1)
	SetPedPathCanDropFromHeight(npc,1)
	SetPedPathPreferToAvoidWater(npc,1)
	SetPedGeneratesDeadBodyEvents(npc,1)
	GiveWeaponToPed(npc,GetHashKey(weapon),5000,true,true)

	SetPedCombatAttributes(npc,1,false)
	SetPedCombatAttributes(npc,13,false)
	SetPedCombatAttributes(npc,6,true)
	SetPedCombatAttributes(npc,8,false)
	SetPedCombatAttributes(npc,10,true)
	SetPedFleeAttributes(npc,512,true)
	SetPedConfigFlag(npc,118,false)
	SetPedFleeAttributes(npc,128,true)
	SetEntityLoadCollisionFlag(npc,true)

	SetPedRelationshipGroupHash(npc,GetHashKey("security_guard"))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if DoesEntityExist(nveh) and DoesEntityExist(pveh01) and DoesEntityExist(pveh02) and DoesEntityExist(pveh03) and DoesEntityExist(pveh04) then
			local x,y,z = table.unpack(GetEntityCoords(nveh))
			local x2,y2,z2 = table.unpack(GetOffsetFromEntityInWorldCoords(nveh,0.0,-4.0,0.5))

			if IsPedDeadOrDying(pveh01) and IsPedDeadOrDying(pveh02) and IsPedDeadOrDying(pveh03) and IsPedDeadOrDying(pveh04) and not DoesEntityExist(bomba) then
				vSERVER.markOcorrency(x,y,z)
				bomba = CreateObject(GetHashKey("prop_c4_final_green"),x,y,z,true,false,false)
				AttachEntityToEntity(bomba,nveh,GetEntityBoneIndexByName(nveh,"door_dside_r"),0.78,0.0,0.0,180.0,-90.0,180.0,false,false,false,true,2,true)
				SetTimeout(15000,function()
					TriggerServerEvent("trydeleteped",PedToNet(pveh01))
					TriggerServerEvent("trydeleteped",PedToNet(pveh02))
					TriggerServerEvent("trydeleteped",PedToNet(pveh03))
					TriggerServerEvent("trydeleteped",PedToNet(pveh04))
					TriggerServerEvent("trydeleteobj",ObjToNet(bomba))
					SetVehicleDoorOpen(nveh,2,0,0)
					SetVehicleDoorOpen(nveh,3,0,0)
					NetworkExplodeVehicle(nveh,1,1,1)
					vSERVER.dropSystem(x2,y2,z2)
					pveh01 = nil
					pveh02 = nil
					pveh03 = nil
					pveh04 = nil
				end)
			end

			if Vdist2(locs[pos].x2,locs[pos].y2,locs[pos].z2,x,y,z) <= 10.0 then
				TriggerServerEvent("trydeleteveh",VehToNet(nveh))
				TriggerServerEvent("trydeleteped",PedToNet(pveh01))
				TriggerServerEvent("trydeleteped",PedToNet(pveh02))
				TriggerServerEvent("trydeleteped",PedToNet(pveh03))
				TriggerServerEvent("trydeleteped",PedToNet(pveh04))
				nveh = nil
				pveh01 = nil
				pveh02 = nil
				pveh03 = nil
				pveh04 = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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
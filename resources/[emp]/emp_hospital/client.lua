-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("emp_hospital",cRP)
vSERVER = Tunnel.getInterface("emp_hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ 349.06,-577.17,43.29,349.58,-575.94,44.21,339.99 },
	{ 351.38,-578.0,43.29,351.85,-576.87,44.21,339.64 },
	{ 353.89,-578.92,43.29,354.4,-577.8,44.21,337.56 },
	{ 356.36,-579.81,43.29,356.84,-578.57,44.21,337.09 },
	{ 358.57,-580.65,43.29,359.04,-579.52,44.21,338.74 },
	{ 357.1,-583.59,43.29,356.62,-584.78,44.21,155.73 },
	{ 354.67,-582.71,43.29,354.12,-583.99,44.21,157.5 },
	{ 352.11,-581.72,43.29,351.6,-582.93,44.21,155.2 },
	{ 349.47,-580.8,43.29,348.95,-582.05,44.21,161.07 },
	{ 361.84,-579.72,43.33,361.07,-579.41,44.21,338.75 },
	{ 366.38,-581.28,43.33,367.27,-581.56,44.21,337.38 },
	{ 329.64,-573.96,43.29,329.16,-575.23,44.21,157.11 },
	{ 326.63,-572.87,43.29,326.1,-574.19,44.21,153.07 },
	{ 323.53,-571.66,43.29,323.02,-572.9,44.21,158.19 },
	{ 325.12,-568.42,43.29,325.67,-567.13,44.21,337.15 },
	{ 328.05,-569.51,43.29,328.6,-568.17,44.21,338.44 },
	{ 330.89,-570.56,43.29,331.49,-569.24,44.21,338.34 },
	{ 319.92,-567.37,43.29,320.38,-566.07,44.26,336.24 },
	{ 314.93,-565.53,43.29,315.4,-564.26,44.26,340.66 },
	{ 311.15,-563.65,43.29,310.6,-562.45,44.26,20.87 },
	{ 309.27,-574.62,43.29,308.73,-573.42,44.26,22.33 },
	{ 319.41,-585.05,43.29,319.05,-585.77,44.21,64.16 },
	{ 331.15,-584.22,43.29,330.75,-584.94,44.21,65.64 },
	{ 348.34,-573.01,28.9,348.83,-571.7,29.83,339.13 },
	{ 349.87,-569.03,28.9,350.39,-567.76,29.83,336.16 },
	{ 351.56,-564.35,28.9,352.05,-563.05,29.83,338.84 },
	{ 358.13,-565.28,28.9,357.57,-566.73,29.95,159.16 },
	{ 356.25,-571.09,28.9,355.7,-572.41,29.95,159.46 },
	{ 315.94,-590.78,28.9,315.47,-592.03,29.95,156.11 },
	{ 305.94,-578.25,48.23,305.43,-579.6, 49.02,160.66 },
	{ 310.47,-572.34,48.23,308.79,-571.74,49.22,66.81 },
	{ 1827.14,3675.54,34.28,1826.5,3676.79,35.2,29.15 },
	{ 1820.41,3671.81,34.28,1819.78, 3673.04,35.2,28.61 },
	{ 1827.89,3679.44,34.28,1828.73, 3677.9,34.98,207.15 },
	{ 1831.97,3673.02,34.28,1830.95, 3674.47,34.99,34.07 },
	{ 1819.66,3679.13,34.28,1818.06, 3678.25,35.02,118.77 }, 
	{ 1820.56,3679.73,34.28,1822.08, 3680.57,34.99,300.66 }
}

Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		local ped = GetPlayerPed(-1)
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(beds) do
				local distance = Vdist(x,y,z,v[1],v[2],v[3])
				if distance <= 1.1 then
					rsTD = 4
					DrawText3Ds(v[1],v[2],v[3],"~g~E ~w~ DEITAR       ~g~G ~w~ TRATAMENTO")
					if distance <= 0.6 then
						if IsControlJustPressed(1,38) then
							SetEntityHeading(ped,v[7])
							SetEntityCoords(ped,v[4],v[5],v[6],1,0,0,1)
							vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
						end

						if IsControlJustPressed(1,47) then
							if vSERVER.checkServices() then
								local health = GetEntityHealth(ped)
								local armour = GetPedArmour(ped)
								NetworkResurrectLocalPlayer(x,y,z-1,GetEntityHeading(ped),true,false)
								SetEntityHealth(ped,health)
								SetPedArmour(ped,armour)

								TriggerEvent("resetBleeding")
								TriggerEvent("resetDiagnostic")
								TriggerEvent("tratamento-macas")
								SetEntityCoords(ped,v[4]+0.0001,v[5]+0.0001,v[6]+0.0001,1,0,0,1)
								SetEntityHeading(ped,v[7])
								vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
							end
						end
					end
				end
			end
		end
		Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/500
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

RegisterNetEvent("tratamento-macas")
AddEventHandler("tratamento-macas",function()
	TriggerEvent("cancelando",true)
	repeat
		SetEntityHealth(GetPlayerPed(-1),GetEntityHealth(GetPlayerPed(-1))+1)
		Citizen.Wait(1000)
	until GetEntityHealth(GetPlayerPed(-1)) >= 400 or GetEntityHealth(GetPlayerPed(-1)) <= 101
		TriggerEvent("Notify","Importante","Tratamento concluido.",8000)
		TriggerEvent("cancelando",false)
end)
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_paramedico")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0

local coordenadas = {
	{ ['id'] = 1, ['x'] = 304.01, ['y'] = -597.35, ['z'] = 43.29 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 151.30, ['y'] = -1028.63, ['z'] = 28.84 },
	[2] = { ['x'] = 423.84, ['y'] = -959.30, ['z'] = 28.81 },
	[3] = { ['x'] = 1.03, ['y'] = -1510.86, ['z'] = 29.40 },
	[4] = { ['x'] = -188.07, ['y'] = -1612.28, ['z'] = 33.39 },
	[5] = { ['x'] = 98.88, ['y'] = -1927.16, ['z'] = 20.25 },
	[6] = { ['x'] = 402.29, ['y'] = -1921.17, ['z'] = 24.74 },
	[7] = { ['x'] = 755.53, ['y'] = -2486.26, ['z'] = 19.54 },
	[8] = { ['x'] = 1057.66, ['y'] = -2124.80, ['z'] = 32.20 },
	[9] = { ['x'] = 1377.08, ['y'] = -1530.01, ['z'] = 56.07 },
	[10] = { ['x'] = 1260.24, ['y'] = -588.15, ['z'] = 68.53 },
	[11] = { ['x'] = 899.58, ['y'] = -590.58, ['z'] = 56.85 },
	[12] = { ['x'] = 945.18, ['y'] = -140.04, ['z'] = 74.07 },
	[13] = { ['x'] = 84.44, ['y'] = 476.19, ['z'] = 146.91 },
	[14] = { ['x'] = -720.03, ['y'] = 482.23, ['z'] = 107.10 },
	[15] = { ['x'] = -1244.39, ['y'] = 497.98, ['z'] = 93.86 },
	[16] = { ['x'] = -1514.99, ['y'] = 442.97, ['z'] = 109.70 },
	[17] = { ['x'] = -1684.14, ['y'] = -308.47, ['z'] = 51.41 },
	[18] = { ['x'] = -1413.14, ['y'] = -531.91, ['z'] = 30.98 },
	[19] = { ['x'] = -1036.80, ['y'] = -492.27, ['z'] = 36.15 },
	[20] = { ['x'] = -551.46, ['y'] = -648.64, ['z'] = 32.73 },
	[21] = { ['x'] = -616.30, ['y'] = -920.80, ['z'] = 22.98 },
	[22] = { ['x'] = -752.13, ['y'] = -1041.29, ['z'] = 12.25 },
	[23] = { ['x'] = -1155.20, ['y'] = -1413.48, ['z'] = 4.46 },
	[24] = { ['x'] = -997.88, ['y'] = -1599.65, ['z'] = 4.59 },
	[25] = { ['x'] = -829.38, ['y'] = -1218.09, ['z'] = 6.54 },
	[26] = { ['x'] = -334.47, ['y'] = -1418.13, ['z'] = 29.71 },
	[27] = { ['x'] = 135.28, ['y'] = -1306.46, ['z'] = 28.65 },
	[28] = { ['x'] = -34.00, ['y'] = -1079.86, ['z'] = 26.26 },
	[29] = { ['x'] = 296.15, ['y'] = -582.48, ['z'] = 42.93 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		if not servico then
			for _,v in pairs(coordenadas) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)

				if distance <= 3 then
					rsTD = 4
					DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~g~E~w~  PARA INICIAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and emP.checkPermission() then
							servico = true
							if v.id == 2 then
								selecionado = 43
							else
								selecionado = 1
							end
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","sucesso","Você entrou em serviço.")
						end
					end
				end
			end
		end
		Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		if servico then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				rsTD = 4
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
				if distance <= 4.5 then
					if emP.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("paramedicoambu")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("paramedicocharger2014")) then
							RemoveBlip(blips)
							if selecionado == 42 then
								selecionado = 1
							elseif selecionado == 82 then
								selecionado = 43
							else
								selecionado = selecionado + 1
							end							
							emP.checkPayment()
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
		Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		if servico then
			rsTD = 4
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
			end
		end
		Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Patrulha")
	EndTextCommandSetBlipName(blips)
end

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
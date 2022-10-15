local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("bratva_coletar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 1443.80
local CoordenadaY = 1132.46
local CoordenadaZ = 114.33
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 255.35, ['y'] = -48.35, ['z'] = 69.94 },
	[2] = { ['x'] = 845.01, ['y'] = -1035.98, ['z'] = 28.19 },
	[3] = { ['x'] = -664.74, ['y'] = -932.91, ['z'] = 21.82 },
	[4] = { ['x'] = -1302.79, ['y'] = -392.20, ['z'] = 36.69 },
	[5] = { ['x'] = 20.45, ['y'] = -1104.05, ['z'] = 29.79 },
	[6] = { ['x'] = 812.92, ['y'] = -2159.70, ['z'] = 29.61 },
	[7] = { ['x'] = 2570.61, ['y'] = 291.94, ['z'] = 108.73 },
	[8] = { ['x'] = 1690.06, ['y'] = 3759.56, ['z'] = 34.70 },
	[9] = { ['x'] = -1121.27, ['y'] = 2698.60, ['z'] = 18.55 },
	[10] = { ['x'] = -3175.17, ['y'] = 1086.34, ['z'] = 20.83 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 10.5 then
				rsTD = 4
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~g~E~w~  PARA INICIAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
					end
				end
			end
		end
		Wait(rsTD)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 10.5 then
				rsTD = 4
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~g~E~w~  PARA COLETAR OS ITENS",4,0.5,0.93,0.50,255,255,255,180)

			if IsControlJustPressed(0,38) and emP.checkPermission() then
				if emP.checkPayment() then
					RemoveBlip(blips)
					if selecionado == #locs then
						selecionado = 1
					else
						selecionado = selecionado + 1
					end
					 CriandoBlip(locs,selecionado)
				end
					end
				end
			end
		end
		Wait(rsTD)
	end
end)

Citizen.CreateThread(function()
	while true do
	local rsTD = 1000
	if servico then
		rsTD = 4
			drawTxt("~y~PRESSIONE ~r~F7 ~y~SE DESEJA FINALIZAR A ROTA",4,0.270,0.905,0.45,255,255,255,200)
			drawTxt("VÁ ATÉ O DESTINO PARA COLETAR OS ~g~ITENS",4,0.270,0.93,0.45,255,255,255,200)
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
			end
		end
		Wait(rsTD)
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

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de itens")
	EndTextCommandSetBlipName(blips)
end

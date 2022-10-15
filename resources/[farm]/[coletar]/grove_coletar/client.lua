local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("grove_coletar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = -224.79
local CoordenadaY = -1649.04
local CoordenadaZ = 35.05
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 1384.4771728516, ['y'] = -2080.1088867188, ['z'] = 52.412433624268 },
	[2] = { ['x'] = 1437.5046386719, ['y'] = -1491.8695068359, ['z'] = 63.622745513916 },
	[3] = { ['x'] = 2580.9738769531, ['y'] = 464.92486572266, ['z'] = 108.62721252441 },
	[4] = { ['x'] = 2555.9362792969, ['y'] = 2607.2719726563, ['z'] = 38.086742401123 },
	[5] = { ['x'] = 1776.3692626953, ['y'] = 3327.2504882813, ['z'] = 41.433292388916 },
	[6] = { ['x'] = 1689.9405517578, ['y'] = 3581.5754394531, ['z'] = 35.620849609375 },
	[7] = { ['x'] = 2455.4223632813, ['y'] = 4058.5053710938, ['z'] = 38.064678192139 },
	[8] = { ['x'] = 2554.6171875, ['y'] = 4668.2587890625, ['z'] = 34.043064117432 },
	[9] = { ['x'] = 2334.8566894531, ['y'] = 4859.5307617188, ['z'] = 41.808223724365 },
	[10] = { ['x'] = 1725.3543701172, ['y'] = 4642.83203125, ['z'] = 43.875495910645 },
	[11] = { ['x'] = 749.97039794922, ['y'] = 4184.5512695313, ['z'] = 41.08784866333 },
	[12] = { ['x'] = -679.26147460938, ['y'] = 5834.61328125, ['z'] = 17.331310272217 },
	[13] = { ['x'] = -254.85806274414, ['y'] = 6148.4243164063, ['z'] = 31.515224456787 },
	[14] = { ['x'] = -359.75512695313, ['y'] = 6334.4599609375, ['z'] = 29.848705291748 },
	[15] = { ['x'] = 56.458740234375, ['y'] = 6646.6645507813, ['z'] = 32.276405334473 },
	[16] = { ['x'] = 416.1471862793, ['y'] = 6520.8256835938, ['z'] = 27.736043930054 },
	[17] = { ['x'] = 2221.8435058594, ['y'] = 5614.8920898438, ['z'] = 54.899543762207 },
	[18] = { ['x'] = 2848.64453125, ['y'] = 4450.4145507813, ['z'] = 48.512390136719 },
	[19] = { ['x'] = 2588.1428222656, ['y'] = 3167.8659667969, ['z'] = 51.367336273193 },
	[20] = { ['x'] = 1094.7243652344, ['y'] = -265.60357666016, ['z'] = 69.313835144043 },
	[21] = { ['x'] = 1172.8271484375, ['y'] = -445.82019042969, ['z'] = 66.699928283691 },
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

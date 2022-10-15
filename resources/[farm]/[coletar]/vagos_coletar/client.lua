local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("vagos_coletar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 279.85
local CoordenadaY = -2043.74
local CoordenadaZ = 19.76
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 852.76586914063, ['y'] = -2432.8220214844, ['z'] = 28.068881988525 },
	[2] = { ['x'] = 1055.2592773438, ['y'] = -2366.8198242188, ['z'] = 30.573120117188 },
	[3] = { ['x'] = 1336.7647705078, ['y'] = -1578.8686523438, ['z'] = 54.444149017334 },
	[4] = { ['x'] = 1224.8764648438, ['y'] = -391.44720458984, ['z'] = 68.667854309082 },
	[5] = { ['x'] = 1215.7678222656, ['y'] = 1846.1602783203, ['z'] = 78.908302307129 },
	[6] = { ['x'] = 265.85415649414, ['y'] = 2598.2436523438, ['z'] = 44.842239379883 },
	[7] = { ['x'] = 46.706798553467, ['y'] = 2789.16796875, ['z'] = 57.878299713135 },
	[8] = { ['x'] = -1123.6468505859, ['y'] = 2682.5415039063, ['z'] = 18.755025863647 },
	[9] = { ['x'] = -2544.0827636719, ['y'] = 2316.01953125, ['z'] = 33.216102600098 },
	[10] = { ['x'] = -1490.4393310547, ['y'] = 4981.2690429688, ['z'] = 63.356983184814 },
	[11] = { ['x'] = -841.50122070313, ['y'] = 5400.7583007813, ['z'] = 34.615207672119 },
	[12] = { ['x'] = -678.86370849609, ['y'] = 5834.1127929688, ['z'] = 17.331312179565 },
	[13] = { ['x'] = -315.63162231445, ['y'] = 6193.9760742188, ['z'] = 31.56079864502 },
	[14] = { ['x'] = -161.6944732666, ['y'] = 6189.5361328125, ['z'] = 31.433891296387 },
	[15] = { ['x'] = 1510.4881591797, ['y'] = 6325.9560546875, ['z'] = 24.60710144043 },
	[16] = { ['x'] = 2697.6176757813, ['y'] = 4324.4526367188, ['z'] = 45.85205078125 },
	[17] = { ['x'] = 2481.236328125, ['y'] = 4100.0478515625, ['z'] = 38.131580352783 },
	[18] = { ['x'] = 1690.1663818359, ['y'] = 3581.6147460938, ['z'] = 35.620845794678 },
	[19] = { ['x'] = 310.32055664063, ['y'] = -723.21533203125, ['z'] = 29.316781997681 },
	[20] = { ['x'] = 195.00772094727, ['y'] = -1291.2481689453, ['z'] = 29.323293685913 },
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

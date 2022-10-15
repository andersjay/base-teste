local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("ballas_coletar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 114.32
local CoordenadaY = -1961.19
local CoordenadaZ = 21.33
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -421.28076171875, ['y'] = -2171.4636230469, ['z'] = 11.338548660278 },
	[2] = { ['x'] = -1025.5477294922, ['y'] = -2127.8337402344, ['z'] = 13.597304344177 },
	[3] = { ['x'] = -734.97314453125, ['y'] = -1137.275390625, ['z'] = 10.830207824707 },
	[4] = { ['x'] = -1505.9459228516, ['y'] = 1512.0257568359, ['z'] = 115.28856658936 },
	[5] = { ['x'] = -1105.8961181641, ['y'] = 2696.4118652344, ['z'] = 18.615339279175 },
	[6] = { ['x'] = -287.63885498047, ['y'] = 2535.775390625, ['z'] = 75.700004577637 },
	[7] = { ['x'] = -264.06094360352, ['y'] = 2196.4033203125, ['z'] = 130.39880371094 },
	[8] = { ['x'] = -43.930145263672, ['y'] = 1959.7044677734, ['z'] = 190.35334777832 },
	[9] = { ['x'] = 265.98147583008, ['y'] = 2598.3356933594, ['z'] = 44.829662322998 },
	[10] = { ['x'] = 194.91023254395, ['y'] = 3030.96875, ['z'] = 43.891021728516 },
	[11] = { ['x'] = 247.22929382324, ['y'] = 3169.3642578125, ['z'] = 42.793640136719 },
	[12] = { ['x'] = 15.182905197144, ['y'] = 3688.6745605469, ['z'] = 39.993064880371 },
	[13] = { ['x'] = 775.78179931641, ['y'] = 4184.0546875, ['z'] = 41.780822753906 },
	[14] = { ['x'] = 1682.8629150391, ['y'] = 4689.9697265625, ['z'] = 43.066806793213 },
	[15] = { ['x'] = 2564.2473144531, ['y'] = 4680.31640625, ['z'] = 34.072471618652 },
	[16] = { ['x'] = 2868.3210449219, ['y'] = 4415.9150390625, ['z'] = 49.099445343018 },
	[17] = { ['x'] = 2632.0603027344, ['y'] = 3258.0783691406, ['z'] = 55.463356018066 },
	[18] = { ['x'] = 322.01071166992, ['y'] = -305.9084777832, ['z'] = 52.583015441895 },
	[19] = { ['x'] = -177.27987670898, ['y'] = -1158.6192626953, ['z'] = 23.813600540161 },
	[20] = { ['x'] = -428.48614501953, ['y'] = -1727.8209228516, ['z'] = 19.78385925293 },
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

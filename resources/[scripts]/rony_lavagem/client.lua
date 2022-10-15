local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

func = Tunnel.getInterface('rony_lavagem')

local progresso = false
local segundos = 0

local coords = {
	{ ['id'] = 1, ['x'] = -571.61, ['y'] = 288.98, ['z'] = 79.18, ['h'] = 261.68, ['permissao'] = 'tequila.lavagem' },
	{ ['id'] = 2, ['x'] = 95.41, ['y'] = -1293.35, ['z'] = 29.31, ['h'] = 305.87, ['permissao'] = 'vanilla.lavagem' }
}

Citizen.CreateThread(function()
	while true do
		local rsTD = 1000
		for k,v in pairs(coords) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x, v.y, v.z)
			local distance = GetDistanceBetweenCoords(v.x, v.y, cdz, x, y, z, true)
			local coords = coords[k]
			if distance <= 1.2 then
				rsTD = 5
				DrawMarker(21, coords.x, coords.y, coords.z - 0.6, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 50, 0, 0, 0, 1)
				if distance <= 1.2 then
					drawTxt('PRESSIONE  ~g~E~w~  PARA LAVAR DINHEIRO SUJO', 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
					if IsControlJustPressed(0, 38) and func.checandoPermissao(v.permissao) then
						func.lavagem(v.id, v.x, v.y, v.z, v.h)
					end
				end
			end
		end
		Wait(rsTD)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if progresso then
			segundos = segundos - 1
			if segundos <= 0 then
				progresso = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando', false)
			end
		end
	end
end)

RegisterNetEvent('rony:lavagem:iniciar')
AddEventHandler('rony:lavagem:iniciar', function(x, y, z, heading)
	segundos = 30
	progresso = true
	SetEntityCoords(PlayerPedId(), x, y, z - 1, false, false, false, false)
	SetEntityHeading(PlayerPedId(), heading)
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
	TriggerEvent('cancelando', true)
end)

function drawTxt(text, font, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry('STRING')
	AddTextComponentString(text)
	DrawText(x, y)
end
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("vrp_races",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local racePoint = 1
local permissao = 'corridas.ilegal'
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local payments = {
	[1] = { 9000,14000 },
	[2] = { 12000,17000 },
	[3] = { 14000,19000 },
	[4] = { 6000,11000 },
	[5] = { 6000,11000 },
	[6] = { 9000,14000 },
	[7] = { 10000,15000 },
	[8] = { 10000,15000 },
	[9] = { 7000,12000 },
	[10] = { 7000,12000 },
	[11] = { 6000,11000 },
	[12] = { 6000,11000 },
	[13] = { 8000,13000 },
	[14] = { 9000,14000 },
	[15] = { 14000,19000 },
	[16] = { 12000,17000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDOMPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		racePoint = math.random(#payments)
		Citizen.Wait(5*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETRACEPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.getRacepoint()
	return parseInt(racePoint)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTBOMBRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.startRace()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("eblips:add2",{ name = "Corredor", src = source, color = 2 })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPerm()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,""..permissao.."")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBOMBRACE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.removeRace(check,status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("eblips:remove",source)

		if status then
			vRP.wantedTimer(user_id,300)

				local result = math.random(payments[check][1],payments[check][2])
				vRP.giveInventoryItem(user_id,"dirtydollars",parseInt(result))

				if vRP.tryGetInventoryItem(user_id,"energetic",1) then
					vRP.giveInventoryItem(user_id,"dirtydollars",math.random(1000,1500))
				end
			end
		end
	end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("defuse",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Policia") then
			local nplayer = vRPclient.getNearestPlayer(source,3)
			if nplayer then
				TriggerClientEvent("vrp_races:defuse",nplayer)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("racenum",function(source,args,rawCommand)
	racePoint = parseInt(args[1])
end)
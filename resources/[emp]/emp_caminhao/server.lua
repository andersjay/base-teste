local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_caminhao",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local gas = 1
local cars = 1
local show = 1
local woods = 1
local diesel = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local paylist = {
	["diesel"] = {
		[1] = { pay = math.random(7200,11700) },
		[2] = { pay = math.random(7200,11700) },
		[3] = { pay = math.random(7200,11700) },
		[4] = { pay = math.random(7200,11700) },
		[5] = { pay = math.random(7200,11700) },
		[6] = { pay = math.random(7200,11700) }
	},
	["gas"] = {
		[1] = { pay = math.random(6000,7800) },
		[2] = { pay = math.random(3900,6600) },
		[3] = { pay = math.random(3900,6600) },
		[4] = { pay = math.random(3900,6600) },
		[5] = { pay = math.random(3900,6600) },
		[6] = { pay = math.random(3900,6600) },
		[7] = { pay = math.random(3900,6600) },
		[8] = { pay = math.random(3900,6600) },
		[9] = { pay = math.random(3900,6600) },
		[10] = { pay = math.random(5400,7800) },
		[11] = { pay = math.random(5400,7800) },
		[12] = { pay = math.random(4500,7800) }
	},
	["cars"] = {
		[1] = { pay = math.random(10800,16200) },
		[2] = { pay = math.random(10800,16200) },
		[3] = { pay = math.random(10800,16200) },
		[4] = { pay = math.random(4200,6000) },
		[5] = { pay = math.random(6600,8400) },
		[6] = { pay = math.random(3000,4500) }
	},
	["woods"] = {
		[1] = { pay = math.random(8400,10800) },
		[2] = { pay = math.random(5400,7200) },
		[3] = { pay = math.random(10800,16200) },
		[4] = { pay = math.random(10800,16200) }
	},
	["show"] = {
		[1] = { pay = math.random(6000,7800) },
		[2] = { pay = math.random(10800,16200) },
		[3] = { pay = math.random(10800,16200) },
		[4] = { pay = math.random(3900,16200) }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(id,mod,health)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveMoney(user_id,parseInt(paylist[mod][id].pay+(health-700)))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(paylist[mod][id].pay+(health-700))).." dólares</b>.")
		if mod == "cars" then
			local value = vRP.getSData("meta:concessionaria")
			local metas = json.decode(value) or 0
			if metas then
				vRP.setSData("meta:concessionaria",json.encode(parseInt(metas+1)))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		diesel = math.random(#paylist["diesel"])
		gas = math.random(#paylist["gas"])
		cars = math.random(#paylist["cars"])
		woods = math.random(#paylist["woods"])
		show = math.random(#paylist["show"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETTRUCKPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.getTruckpoint(point)
	if point == "diesel" then
		return parseInt(diesel)
	elseif point == "gas" then
		return parseInt(gas)
	elseif point == "cars" then
		return parseInt(cars)
	elseif point == "woods" then
		return parseInt(woods)
	elseif point == "show" then
		return parseInt(show)
	end
end
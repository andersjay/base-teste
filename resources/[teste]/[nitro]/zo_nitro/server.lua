
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
--  discord.gg/dogz1n
Tunnel.bindInterface("zo_nitro", src)
Proxy.addInterface("zo_nitro", src)
vCLIENT = Tunnel.getInterface("zo_nitro")
function src.getInfos()
    local source = source
    local user_id = zof.getUserId(source)
    local vehicle, vnetid, placa, vname, lock, banned = zof.vehList(source, 5)
    if vehicle and placa then
        local placa_user_id = zof.getUserByRegistration(placa)
        if placa_user_id ~= nil then
            return { placa_user_id = placa_user_id, vname = vname, placa = placa, veh = vehicle }
        end
    end
    return false
end
--  discord.gg/dogz1n
function src.checkVehicleBlackList()
    local source = source
    local user_id = zof.getUserId(source)
    local vehicle, vnetid, placa, vname, lock, banned = zof.vehList(source, 5)
    for i, v in pairs(veiculosBlackList) do
        if v == vname then
            return true
        end
    end
end

--  discord.gg/dogz1n
function src.getInfosVeh(veh)
    local source = source
    local vehicle, vnetid, placa, vname, lock, banned = zof.vehList(source, 5)
    if vnetid == veh then
        return vname
    end
    return false
end

--  discord.gg/dogz1n
function src.getCustom()
    local infos = src.getInfos()
    if infos then
        local tuning = zof.getSData("customVehicle:u".. infos.placa_user_id .. "veh_" .. infos.vname .. "placa_" .. infos.placa) or {}
        local custom = json.decode(tuning) or {}
        return custom, infos
    end
    return false
end
function src.setCustom(custom, infos)
    if infos then
        zof.setSData("customVehicle:u".. infos.placa_user_id .. "veh_" .. infos.vname .. "placa_" .. infos.placa, json.encode(custom))
    end
end
function src.checkPermission()
    local source = source
    local user_id = zof.getUserId(source)
    if not next(permissaoParaInstalarNitro) then
        return true
    end
    for k, group in pairs(permissaoParaInstalarNitro) do
        if zof.hasPermission(user_id, group) then
            return true
        end
    end
    return false
end

--  discord.gg/dogz1n
function src.setNitro(vehi)
    local source = source
    local user_id = zof.getUserId(source)
    if zof.tryGetInventoryItem(user_id, 'notebook', 1) then
        local custom, infos = src.getCustom()
        if custom and infos.veh == vehi then
            custom.nitro = 1
            custom.nitro_q = 100
            src.setCustom(custom, infos)
        end
    end
end
function src.setQtdNitro(qtd, vehi)
    local source = source
    local user_id = zof.getUserId(source)
    if zof.tryGetInventoryItem(user_id, itemGarrafaNitro, 1) then
        local custom, infos = src.getCustom()
        if custom and infos.veh == vehi then
            custom.nitro_q = qtd
            src.setCustom(custom, infos)
        end
    end
end
function src.checkVehicleNitro()
    local custom = src.getCustom()
    if custom then
        if custom.nitro == 1 then
            return true
        end
    end
    return false
end
function src.getVehicleQuantityNitro()
    local custom = src.getCustom()
    if custom then
        return custom.nitro_q
    end
    return false
end
function src.anim(name, dict, time, bool)
    local source = source
    zof._playAnim(source, bool, name, dict, 1, true)
    SetTimeout(time, function()
        zof.DeletarObjeto(source)
        zof._stopAnim(source, false)
        vCLIENT.instalando(source, false)
    end)
end
RegisterNetEvent('nitro:__sync')
AddEventHandler('nitro:__sync', function (bool, veh)
    local source = source
    local players = zof.getNearestPlayers(source, 5)
    TriggerClientEvent('nitro:__update', -1, bool, veh)
    for p, k in pairs(players) do
        TriggerClientEvent('nitro:__update_screen', p, bool, veh)
    end
end)
RegisterServerEvent("tryCapo")
AddEventHandler("tryCapo",function(nveh, abrir)
    TriggerClientEvent("syncCapo", -1, nveh, abrir)
end)
RegisterNetEvent("zosync:alignMechanicAndCarHeading")
AddEventHandler("zosync:alignMechanicAndCarHeading", function(h, n)
    TriggerClientEvent("zo:alignMechanicAndCarHeading", -1, h, n)
end)
Citizen.CreateThread(function()
    Citizen.Wait(3000)
    vCLIENT.createNitroValidation(-1)
end)
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    Citizen.Wait(3000)
    vCLIENT.createNitroValidation(source)
end)

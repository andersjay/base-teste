local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("zo_nitro", src)
vSERVER = Tunnel.getInterface("zo_nitro")
local function f(n) return (n + 0.00001) end
function returnCoordBone(veh, bone, px, py, pz)
    local b = GetEntityBoneIndexByName(veh, bone)
    local bx, by, bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
    local ox2, oy2, oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
    local vector = GetOffsetFromEntityInWorldCoords(veh, ox2 + f(px), oy2 + f(py), oz2 + f(pz))
    local x, y, z = table.unpack(vector)
    return x, y, z, vector
end
RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "closeNui" then
        SetNuiFocus(false, false)
        SendNUIMessage({ type = "ui", display = false })
        SendNUIMessage({ type = "config", display = false })
        open = false
        hudOpen = false
    end
end)
Citizen.CreateThread(function()
    RegisterCommand(comandoAbrirHud, function()
        SetNuiFocus(true, true)
        hudOpen = true
        SendNUIMessage({ porcentagem = 100 })
        SendNUIMessage({ type = "ui", display = true })
        SendNUIMessage({ type = "config", display = true })
    end)
end)
instalarKitNitro = function()
    if vSERVER.checkVehicleNitro() then
        TriggerEvent("Notify", "aviso", dict[0], 5000)
        return
    end
    if vSERVER.checkVehicleBlackList() then
        TriggerEvent("Notify", "aviso", dict[10], 5000)
        return
    end
    if not vSERVER.checkPermission() then
        TriggerEvent("Notify", "aviso", dict[1], 5000)
        return
    end
    instalando = false
    instalado = false
    cancelado = false
    pEngine = 1
    Citizen.CreateThread(function()
        local threadCreate = false
        while not instalado and not cancelado do
            local w = 1000
            local ped = PlayerPedId()
            local pCDS = GetEntityCoords(ped)
            local veh = zof.getNearestVehicle(5)
            local px, py, pz = table.unpack(pCDS)
            if not threadCreate then
                threadCreate = true
                Citizen.CreateThread(function()
                    while not instalado and not cancelado do
                        Citizen.Wait(1000)
                        pCDS = GetEntityCoords(ped)
                        vehicleInstall = zof.getNearestVehicle(5)
                        if vehicleInstall ~= veh then
                            TriggerEvent("Notify", "aviso", dict[2], 5000)
                            cancelado = true
                            threadCreate = false
                            TriggerServerEvent("tryCapo", VehToNet(veh), false)
                            ClearPedTasks(ped)
                            FreezeEntityPosition(ped, false)
                            FreezeEntityPosition(veh, false)
                            return
                        end
                    end
                end)
                for i, v in pairs(veiculosPositionEngine) do
                    local nveh = vSERVER.getInfosVeh(VehToNet(veh))
    
                    if nveh then
                        nveh = GetHashKey(nveh)
                    end
    
                    if GetHashKey(i) == nveh then
                        pEngine = v
                    end
                end
            end
            local x, y, z, vector = returnCoordBone(veh, "engine", 0, f(pEngine), 0)
            vector = vector3(x, y, pz)
            local dist = #(pCDS - vector)
            if dist < 11 then
                w = 5
                if not instalando then
                    zof.drawMarker(x, y, pz)
                end
                if dist < 2 and IsControlJustPressed(0, 38) and not instalando then
                    instalando = true
                    local h = GetEntityHeading(veh)
                    if pEngine < 0 then
                        h = h * -1
                    end
                    
                    TriggerServerEvent("zosync:alignMechanicAndCarHeading", h, 170)
                    Citizen.Wait(1000)
                    TriggerServerEvent("tryCapo", VehToNet(veh), true)
                    Citizen.Wait(500)
                    vSERVER.anim("mini@repair", "fixing_a_player", tempoInstalacaoKitNitro * 1000, false)
                    PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", veh, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
                    FreezeEntityPosition(ped, true)
                    FreezeEntityPosition(veh, true)
                    TriggerEvent("progress", tempoInstalacaoKitNitro * 1000, dict[8])
                    SetTimeout(tempoInstalacaoKitNitro * 1000, function()
                        PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
                        TriggerEvent("Notify", "aviso", dict[3], 5000)
                        turbo = 100
                        instalado = true
                        instalando = false
                        vSERVER.setNitro(veh)
                        threadCreate = false
                        vehicleCheck = false
                        
                        TriggerServerEvent("tryCapo", VehToNet(veh), false)
                        
                        Citizen.Wait(1000)
                        ClearPedTasks(ped)
                        FreezeEntityPosition(ped, false)
                        FreezeEntityPosition(veh, false)
                    end)
                end
            end
            Citizen.Wait(w)
        end
    end)
end
recarregarNitro = function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if not vSERVER.checkVehicleNitro() then
        TriggerEvent("Notify", "aviso", dict[4], 5000)
        return
    end
    if not GetPedInVehicleSeat(veh, 1) or not GetPedInVehicleSeat(veh, 1) then
        TriggerEvent("Notify", "aviso", dict[5], 5000)
        return
    end
    
    if math.ceil(GetEntitySpeed(veh) * 3.605936) >= 1 then
        TriggerEvent("Notify", "aviso", dict[6], 5000)
        return
    end
    vSERVER.anim("mini@repair", "fixing_a_ped", tempoParaTrocarGarrafaNitro * 1000, true)
    PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", veh, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
    FreezeEntityPosition(ped, true)
    FreezeEntityPosition(veh, true)
    TriggerEvent("progress", tempoParaTrocarGarrafaNitro * 1000, dict[7])
    SetTimeout(tempoParaTrocarGarrafaNitro * 1000, function()
        PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
        vSERVER.setQtdNitro(100, veh)
        TriggerEvent("Notify", "aviso", dict[9], 5000)
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        FreezeEntityPosition(veh, false)
        open = false
    end)
end
-- RegisterCommand("rnitro", function()
--     recarregarNitro()
-- end)
-- RegisterCommand("turbo", function()
--     if not instalando then
--         instalarKitNitro()
--     end
-- end)
RegisterNetEvent('zo_install_nitro', function()
    if not instalando then
        instalarKitNitro()
    end
end)
RegisterNetEvent('zo_recharge_nitro', function()
    recarregarNitro()
end)
src.createNitroValidation = function()
    Citizen.CreateThread(function()
        turbo = 0
        vehicleCheck = false
        sync = false
        open = false
        while true do
            local wait = 1000
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
            if veh ~= 0 then
                if vehicleCheck then
                    wait = 1
                    local turboAtivado = false
                    if not open and GetPedInVehicleSeat(veh, -1) == ped then
                        local qnitro = vSERVER.getVehicleQuantityNitro()
                        SendNUIMessage({ porcentagem = qnitro })
                        Citizen.Wait(5)
                        SendNUIMessage({ type = "ui", display = true })
                        open = true
                    end
                    
                    while IsControlPressed(0, teclaParaUsarNitro) do
                        if not turboAtivado then
                            turboAtivado = true
                            turbo = vSERVER.getVehicleQuantityNitro()
                            Citizen.CreateThread(function()
                                while turboAtivado do
                                    if turbo > 0 then
                                        turbo = turbo - 1
                                        
                                        SendNUIMessage({ porcentagem = turbo })
                                    end
                                    Citizen.Wait(tempoDuracaoTotalNitro * 10)
                                end
                            end)
                            Citizen.CreateThread(function()
                                while turboAtivado do
                                    if turbo > 0 then
                                        MudarTela(true)
                                        SetVehicleLightTrailEnabled(veh, true)
                                        TriggerServerEvent('nitro:__sync', true, VehToNet(veh))
                                        FogoNoScape(veh, f(TamanhoDoFogoNoEscape))
                                        SetVehicleCheatPowerIncrease(veh, f(AumentoDeTorqueAoUsarNitro))
                                        ModifyVehicleTopSpeed(veh, f(AumentoDeVelocidadeFinalAoUsarNitro))
                                    else
                                        MudarTela(false)
                                        SetVehicleLightTrailEnabled(veh, false)
                                        TriggerServerEvent('nitro:__sync', false, VehToNet(veh))
                                        SetVehicleCheatPowerIncrease(veh, 0.0)
                                        ModifyVehicleTopSpeed(veh, 0.0)
                                    end
                                    Citizen.Wait(100)
                                end
                            end)
                        end
                        Citizen.Wait(5)
                    end
                    if turboAtivado then
                        MudarTela(false)
                        SetVehicleLightTrailEnabled(veh, false)
                        TriggerServerEvent('nitro:__sync', false, VehToNet(veh))
                        turboAtivado = false
                        SetVehicleCheatPowerIncrease(veh, 0.0)
                        ModifyVehicleTopSpeed(veh, 0.0)
                        Citizen.Wait(tempoDuracaoTotalNitro * 10)
                        vSERVER.setQtdNitro(turbo, veh)
                    end
                else
                    vehicleCheck = vSERVER.checkVehicleNitro()
                    turbo = vSERVER.getVehicleQuantityNitro()
                end
            else
                vehicleCheck = false
                open = false
                if not hudOpen then
                    SendNUIMessage({ type = "ui", display = false })
                end
            end
            Citizen.Wait(wait)
        end
    end)
end
function FogoNoScape(CarroID, Longitude)
    local escapes = {
        "exhaust", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5",
        "exhaust_6", "exhaust_7", "exhaust_8", "exhaust_9", "exhaust_10",
        "exhaust_11", "exhaust_12", "exhaust_13", "exhaust_14", "exhaust_15",
        "exhaust_16"
    }
    for k, v in ipairs(escapes) do
        BoneEscape = v
        local escapeID = GetEntityBoneIndexByName(CarroID, BoneEscape)
        if escapeID > -1 then
            local Escape = GetWorldPositionOfEntityBone(CarroID, escapeID)
            local localEscape = GetOffsetFromEntityGivenWorldCoords(CarroID, Escape)
            UseParticleFxAssetNextCall('core')
            StartParticleFxNonLoopedOnEntity('veh_backfire', CarroID, localEscape, 0.0, 0.0, 0.0, Longitude, false, false, false)
        end
    end
end
function MudarTela(status)
    if status == true then
        StopScreenEffect('RaceTurbo')
        StartScreenEffect('RaceTurbo', 0, false)
        SetTimecycleModifier('rply_motionblur')
    else
        SetTransitionTimecycleModifier('default', 0.35)
    end
end
RegisterNetEvent("zo:alignMechanicAndCarHeading")
AddEventHandler("zo:alignMechanicAndCarHeading", function(h, n)
    local ped = PlayerPedId()
    SetPedDesiredHeading(ped, tonumber(h - n))
end)
RegisterNetEvent("syncCapo")
AddEventHandler("syncCapo", function(index, open)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToVeh(index)
        if DoesEntityExist(v) then
            if IsEntityAVehicle(v) then
                if open then
                    SetVehicleDoorOpen(v, 4, 0, 0)
                else
                    SetVehicleDoorShut(v, 4, 0)
                end
            end
        end
    end
end)
function CreateVehicleLightTrail(vehicle, bone, scale)
    UseParticleFxAssetNextCall('core')
    local ptfx = StartParticleFxLoopedOnEntityBone('veh_light_red_trail', vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone, scale, false, false, false)
    SetParticleFxLoopedEvolution(ptfx, "speed", 1.0, false)
    return ptfx
end
function StopVehicleLightTrail(ptfx, duration)
    Citizen.CreateThread(function()
        local startTime = GetGameTimer()
        local endTime = GetGameTimer() + duration
        while GetGameTimer() < endTime do
            Citizen.Wait(0)
            local now = GetGameTimer()
            local scale = (endTime - now) / duration
            SetParticleFxLoopedScale(ptfx, scale)
            SetParticleFxLoopedAlpha(ptfx, scale)
        end
        StopParticleFxLooped(ptfx)
    end)
end
local vehicles = {}
local particles = {}
function IsVehicleLightTrailEnabled(vehicle) return vehicles[vehicle] == true end
function SetVehicleLightTrailEnabled(vehicle, enabled)
    if not animacaoLanternaVeiculoAoUsarNitro then return end
    if IsVehicleLightTrailEnabled(vehicle) == enabled then return end
    if enabled then
        local ptfxs = {}
        local leftTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName( vehicle, "taillight_l"), 1.0)
        local rightTrail = CreateVehicleLightTrail(vehicle, GetEntityBoneIndexByName( vehicle, "taillight_r"), 1.0)
        table.insert(ptfxs, leftTrail)
        table.insert(ptfxs, rightTrail)
        vehicles[vehicle] = true
        particles[vehicle] = ptfxs
    else
        if particles[vehicle] and #particles[vehicle] > 0 then
            for _, particleId in ipairs(particles[vehicle]) do
                StopVehicleLightTrail(particleId, 100)
            end
        end
        vehicles[vehicle] = nil
        particles[vehicle] = nil
    end
end
RegisterNetEvent('nitro:__update')
AddEventHandler('nitro:__update', function(nitro, veh)
    if nitro then FogoNoScape(NetToVeh(veh), f(TamanhoDoFogoNoEscape)) end
end)
RegisterNetEvent('nitro:__update_screen')
AddEventHandler('nitro:__update_screen', function(bool, veh)
    veh = NetToVeh(veh)
    ped = PlayerPedId()
    if veh == GetVehiclePedIsUsing(ped) then
        MudarTela(bool)
        SetVehicleLightTrailEnabled(veh, bool)
    end
end)
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.003 + factor, 0.03, 41, 11, 41, 68)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("zo_carteiras", src)
vSERVER = Tunnel.getInterface("zo_carteiras")

function closeMaquina()
    SetNuiFocus(false, false)
    vRP._DeletarObjeto()
    vRP._stopAnim(false)
    SendNUIMessage({
        type = 'fecharLoja'
    })
    ClearPedTasks(PlayerPedId())
end

Citizen.CreateThread(function()
    closeMaquina()
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "fecharLoja" then
        closeMaquina()
    end

    if data.action == "comprarItem" then
        local data = data.dataItem
        TriggerServerEvent("comprarItem", data)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId()
        for v, lock in pairs(blips_lojas.blips) do
            local vA = GetEntityCoords(ped)
            local vB = vector3(lock.x, lock.y, lock.z)
            local distance = #(vA - vB)

            if distance < 5 then
                wait = 5
                DrawMarker(blips_lojas.config_blip.icon, lock.x, lock.y, lock.z - 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, blips_lojas.config_blip.red, blips_lojas.config_blip.green, blips_lojas.config_blip.blue, blips_lojas.config_blip.alpha, 0, 0, 0, 1)

                if IsControlJustPressed(1, 38) then
                    local vA = GetEntityCoords(ped)
                    local vB = vector3(lock.x, lock.y, lock.z)
                    local distance = #(vA - vB)

                    if distance < 1.5 then
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            type = 'abrirLoja',
                            produtos = itens
                        })
                    end
                end
            end
        end

        Citizen.Wait(wait)
    end
end)



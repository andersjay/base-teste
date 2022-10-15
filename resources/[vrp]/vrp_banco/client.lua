bankClient = {}
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vrp_banco")

local cfg = module("vrp_banco","config")

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
    local rsTD = 1000
    local ped = PlayerPedId()
    local cds = GetEntityCoords(ped)
    for bancos = 1,#cfg.cds do 
        local dist = #(cds - cfg.cds[bancos])
        if dist < 10.0 then 
            rsTD = 5
            DrawMarker(21, cfg.cds[bancos][1],cfg.cds[bancos][2],cfg.cds[bancos][3] - 0.6, 0, 0, 0, 0.0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 50, 0, 0, 0, 1)
            if dist <= 3.0 then 
                if IsControlJustPressed(0, 38) then 
                    bankClient.clOpenNui()
                end
            end
        end
    end
    Citizen.Wait(rsTD)
    end
end)

bankClient.close = function()
    SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ acao = "close" })
    TransitionFromBlurred(500)
end

RegisterNUICallback("close",function(data)
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ acao = "close" })
    TransitionFromBlurred(500)
end)

bankClient.clOpenNui = function()
    local carteira, banco, nome, telefone, multas = vRPserver.info()
    local logs = "."
    SendNUIMessage({
        acao = "open",
        carteira = carteira,
        banco = banco,
        nome = nome,
        phone = telefone,
        logs = logs,
        multas = multas
    })
    SetNuiFocus(true, true)
    TransitionToBlurred(1000)
end

bankClient.updateBank = function()
    local carteira, banco, nome, telefone, multas = vRPserver.info()
    local logs = "."
    SendNUIMessage({
        acao = "update",
        carteira = carteira,
        banco = banco,
        nome = nome,
        phone = telefone,
        logs = logs,
        multas = multas
    })
end

RegisterNUICallback("transferencia",function(data)
    vRPserver.transferencia(data.nid,data.amount)
end)
RegisterNUICallback("saque",function(data)
    vRPserver.saque(data.amount)
end)
RegisterNUICallback("deposito",function(data)
    vRPserver.depositar(data.amount)
end)
RegisterNUICallback("multas",function(data)
    vRPserver.multas(data.amount)
end)
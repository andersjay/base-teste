--PARA CRIAR UM TEXTO 3D NA TELA FLUTUANTE EM ALGUMA POSIÇÃO
DrawText3D = function(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.45
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline(1)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.030, 66, 66, 66, 150)
    end
end

-- NOTIFICAÇÃO PADRÃO DO GTA V
function notificacao(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--DESENHA TEXTO EM ALGUM LUGAR NA TELA
function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- VERIFICA SE O PLAYER ESTA PROXIMO DE ALGUMA COISA - PASSE AS COORDENADAS , e o Distancia o valor minimo de distancia
function proximo(x, y, z, distancia)
    local player = GetPlayerPed()
    local playerCoords = GetEntityCoords(player, 0)

    local distance = GetDistanceBetweenCoords(x, y, z, playerCoords["x"], playerCoords["y"], playerCoords["z"], true)
    if (distance <= distancia) then
        return true
    end
end

function IsNearBlipCraft()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(locais) do
        local distance =
            GetDistanceBetweenCoords(
            item.coords.x,
            item.coords.y,
            item.coords.z,
            plyCoords["x"],
            plyCoords["y"],
            plyCoords["z"],
            true
        )
        if (distance <= 6)then
                    DrawMarker(23, item.coords.x,
                    item.coords.y,
                    item.coords.z-0.9701, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
        end
        if (distance <= 1) then
            coords = item.coords
            receitaMesa = item.receitas
            permissaoMesa = item.permissao
            return true
        end
       
    end
end

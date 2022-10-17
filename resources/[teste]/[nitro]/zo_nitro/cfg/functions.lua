zof = {
    getUserId = function(source)
        return vRP.getUserId(source)
    end,

    vehList = function(source, distance)
        return vRPclient.vehList(source, distance)
    end,

    getUserByRegistration = function(placa)
        return vRP.getUserByRegistration(placa)
    end,

    setSData = function(key, data)
        return vRP.setSData(key, data)
    end,

    getSData = function(key)
        return vRP.getSData(key)
    end,

    hasPermission = function(user_id, group)
        return vRP.hasPermission(user_id, group)
    end,

    tryGetInventoryItem = function(user_id, item, qtd)
        return vRP.tryGetInventoryItem(user_id, item, qtd)
    end,
    
    _playAnim = function(source, bool, name, dict, int, bool2)
        return vRPclient._playAnim(source, bool, {{name, dict, int}}, bool2)
    end,

    DeletarObjeto = function(source)
        return vRPclient.DeletarObjeto(source)
    end,

    _stopAnim = function(source, bool)
        return vRPclient._stopAnim(source, bool)
    end,
    
    getNearestPlayers = function(source, distance)
        return vRPclient.getNearestPlayers(source, distance)
    end,

    getNearestVehicle = function(distance)
        return vRP.getNearestVehicle(distance)
    end,

    drawMarker = function(x, y, z)
        DrawMarker(1, x, y, z - 1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.7, 0, 255, 0, 155, 0, 0, 0, 1)
        DrawText3D(x, y, z, "Pressione [~r~E~w~] para instalar o nitro.")
    end
}
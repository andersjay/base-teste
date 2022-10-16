--NOTIFY
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,timer)
	SendNUIMessage({ css = css, mensagem = mensagem, timer = timer or 5000 })
	TriggerEvent("vrp_sound:source", "popup", 1)
end)

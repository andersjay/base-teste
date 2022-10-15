local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

func = {}
Tunnel.bindInterface('rony_lavagem', func)

local itemName = 'dinheirosujo'

function func.checandoPermissao(permissao)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id, permissao)
end

function func.lavagem(id, x, y, z, heading)
	local source = source
	local user_id = vRP.getUserId(source)

	local valor_total = vRP.prompt(source, 'Digite a quantia que você deseja lavar:', '')
	local dinheiro_limpo = vRP.getMoney(user_id)

	if valor_total == '' then
		return TriggerClientEvent('Notify', source, 'negado', 'Você não insiriu nenhum valor.')
	end
	if valor_total == '' then
		return TriggerClientEvent('Notify', source, 'negado', 'Você não insiriu nenhum valor.')
	end

	if vRP.getInventoryItemAmount(user_id, ''..itemName..'') >= parseInt(valor_total) then
		TriggerClientEvent('rony:lavagem:iniciar', source, x, y, z, heading)
		TriggerClientEvent('progress', source, 30000, 'lavando')
		vRPclient._playAnim(source, false, {{'anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop'}}, true)
		vRP.tryGetInventoryItem(user_id, ''..itemName..'', parseInt(valor_total))
		SetTimeout(30000, function()
			vRPclient._stopAnim(source, false)
			vRP.setMoney(user_id, dinheiro_limpo + valor_total)
			TriggerClientEvent('Notify', source, 'sucesso', 'Você lavou <b>$'..valor_total..'</b> dólares.')
		end)
	else
		TriggerClientEvent('Notify', source, 'negado', 'Você não tem <b>dinheiro sujo</b> suficiente.')
	end
end
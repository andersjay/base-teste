local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--ANÚNCIO DE ADMIN
local permadm = "admin.permissao"
--ANÚNCIO DE POLÍCIA
local permpolicia = "policia.permissao"
--ANÚNCIO D0 HOSPITAL
local permhp = "hospital.permissao"
--TEMPO DA NOTIFY DA POLÍCIA (PADRÃO 30 SEGUNDO/30000MS)
local tempopolicia = 30000
--TEMPO DA NOTIFY DO HOSPITAL (PADRÃO 30 SEGUNDO/30000MS)
local tempohospital = 30000          

RegisterCommand('anuncioadm',function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,permadm) then
        local titulo = vRP.prompt(source,"Título:","")
        local mensagem = vRP.prompt(source,"Mensagem:","")
        local tempo = vRP.prompt(source,"Tempo em segundos:","")
        if mensagem then
        TriggerClientEvent("Notify",source,"adm","<b>"..titulo.."</b><br>"..mensagem.."<br><br>Mensagem enviada por: "..identity.name.."", tempo*1000)
        end
    end
end)

RegisterCommand('anunciopm',function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,permpolicia) then
        local titulo = vRP.prompt(source,"Título:","")
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem then
        TriggerClientEvent("Notify",source,"policia","<b>"..titulo.."</b><br>"..mensagem.."", tempopolicia)
        end
    end
end)

RegisterCommand('anunciohp',function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,permhp) then
        local titulo = vRP.prompt(source,"Título:","")
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem then
        TriggerClientEvent("Notify",source,"hospital","<b>"..titulo.."</b><br>"..mensagem.."", tempohospital)
        end
    end
end)

RegisterCommand('notify',function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,permadm) then
        TriggerClientEvent("Notify",source,"sucess","<b>Sucesso</b><br>Você ganhou na loteria.", 15000)
        TriggerClientEvent("Notify",source,"fracasso","<b>Fracasso</b><br>Você perdeu na loteria.", 15000)
        TriggerClientEvent("Notify",source,"alert","<b>Aviso</b><br>Você apostou na loteria.", 15000)
        TriggerClientEvent("Notify",source,"adm","<b>Prefeitura</b><br>Prefeitura ganhou na loteria.", 15000)
        TriggerClientEvent("Notify",source,"policia","<b>Polícia</b><br>Polícia pegou o dinheiro da loteria.", 15000)
        TriggerClientEvent("Notify",source,"hospital","<b>Hospital</b><br>Curou o atendente da loteria.", 15000)
        TriggerClientEvent("Notify",source,"loc","<b>Sucesso</b><br>Você recebeu a localização da loteria.", 15000)
    end
end)
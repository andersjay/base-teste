local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_banco")
isTransfer = false
vRPserver = {}
emP = {}

Tunnel.bindInterface("vrp_banco",vRPserver)
emP = Tunnel.getInterface("vrp_banco")

vRP._prepare("sRP/banco",[[
  CREATE TABLE IF NOT EXISTS vrp_banco(
    id INTEGER AUTO_INCREMENT,
    user_id INTEGER,
    extrato VARCHAR(255),
    data VARCHAR(255),
    CONSTRAINT pk_banco PRIMARY KEY(id)
  )
]])

vRP._prepare("sRP/inserir_table","INSERT INTO vrp_banco(user_id, extrato, data) VALUES(@user_id, @extrato, DATE_FORMAT(CURDATE(), '%d/%m/%Y') )")
vRP._prepare("sRP/get_banco_id","SELECT * FROM vrp_banco WHERE user_id = @user_id")
vRP._prepare("sRP/get_dinheiro","SELECT bank FROM vrp_user_moneys WHERE user_id = @user_id")
vRP._prepare("sRP/set_banco","UPDATE vrp_user_moneys SET bank = @bank WHERE user_id = @user_id")

async(function()
  vRP.execute("sRP/banco")
end)

function vRPserver.info()
	local source = source
  local user_id = vRP.getUserId(source)
  if user_id then
    local carteira = vRP.getMoney(user_id)
    local banco = vRP.getBankMoney(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local mymultas = vRP.getUData(user_id,"vRP:multas")
    local multas = json.decode(mymultas) or 0
    return carteira, banco, identity.name.." "..identity.firstname, identity.phone, multas
  end
end

function vRPserver.depositar(amount)
	local source = source
  local user_id = vRP.getUserId(source)
  local banco = vRP.getBankMoney(user_id)
	if user_id then
    if amount > 0 then
      if vRP.tryDeposit(user_id,parseInt(amount)) then
        TriggerClientEvent("Notify",source,"sucesso","Você depositou <b>R$ "..amount.."</b> na sua conta.",5000)
        TriggerClientEvent("vrp_banco:update", source)
      else
        TriggerClientEvent("Notify",source,"negado","Dinheiro <b>insuficiente</b> na sua carteira.",5000)
      end
		end
	end
end

function vRPserver.saque(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local mymultas = vRP.getUData(user_id,"vRP:multas")
    local multas = json.decode(mymultas) or 0
    if multas >= 30000 then
      TriggerClientEvent("Notify",source,"negado","Encontramos <b>multas pendentes</b>, não fornecemos dinheiro aos devedores.",3000)
      return
    end

		if parseInt(amount) > 0 then
			if vRP.tryWithdraw(user_id,parseInt(amount)) then
        TriggerClientEvent("Notify",source,"sucesso","Você sacou <b>R$ "..amount.."</b> da sua conta.",5000)
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro <b>insuficiente</b> na sua conta bancária.",5000)
			end
		end
	end
end

function vRPserver.multas(amount)
	local source = source
  local user_id = vRP.getUserId(source)
  local banco = vRP.getBankMoney(user_id)
  if user_id then
    local mymultas = vRP.getUData(user_id,"vRP:multas")
    local multas = json.decode(mymultas) or 0
    if banco >= parseInt(amount) then
			if parseInt(amount) <= parseInt(multas) then
        vRP.setBankMoney(user_id,parseInt(banco-amount))
        vRP.setUData(user_id,"vRP:multas",json.encode(parseInt(multas)-parseInt(amount)))
        TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..amount.." dólares</b> em multas.",8000)
      else
        TriggerClientEvent("Notify",source,"negado","Você não pode pagar mais do que deve.",8000)
      end
    else
      TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",8000)
    end
  end
end
    

function vRPserver.transferencia(to ,amountt)
  local _source = source
	local user_id = vRP.getUserId(_source)
	local identity = vRP.getUserIdentity(user_id)

	local _nplayer = vRP.getUserSource(parseInt(to))
	local nuser_id = vRP.getUserId(_nplayer)
	local identitynu = vRP.getUserIdentity(nuser_id)
	local banco = 0

	if nuser_id == nil then
		TriggerClientEvent("Notify",_source,"negado","Passaporte inválido ou indisponível.")
	else
		if nuser_id == user_id then
			TriggerClientEvent("Notify",_source,"negado","Você não pode transferir dinheiro para si mesmo.")	
		else
			local banco = vRP.getBankMoney(user_id)
			local banconu = vRP.getBankMoney(nuser_id)
			
			if banco <= 0 or banco < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent("Notify",_source,"negado","Dinheiro Insuficiente")
			else
				vRP.setBankMoney(user_id,banco-tonumber(amountt))
				vRP.setBankMoney(nuser_id,banconu+tonumber(amountt))

				TriggerClientEvent("Notify",_nplayer,"sucesso","<b>"..identity.name.." "..identity.firstname.."</b> depositou <b>$"..amountt.." dólares</b> na sua conta.")
				TriggerClientEvent("Notify",_source,"sucesso","Você transferiu <b>$"..amountt.." dólares</b> para conta de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.")
			end
		end
	end
end
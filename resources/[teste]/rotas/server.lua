-------------------------------------------------------------------------------------------------
--[ VRP ]----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
-------------------------------------------------------------------------------------------------
--[ CONEXÃO ]------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface('routes',cRP)
vCLIENT = Tunnel.getInterface('routes')
-------------------------------------------------------------------------------------------------
--[ VARIABLES ]----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local rotas = {
	['weed'] = { -- C.V (cv)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['ecstasy'] = { -- P.C.C (pcc)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['lsd'] = { -- T.C.P (tcp)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['cocaine'] = { -- A.D.A (ada)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['meth'] = { -- Cartel (cartel)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['weapons'] = { -- Milícia (milicia) / Yakuza (Yakuza)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['ammo'] = { -- T.D.C (canada) / Motoclub (Motoclub)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['smuggling'] = { -- T.D.L (tdl)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	},
	['wash'] = { -- Cassino (Vanilla), Bahamas (Bahamas)
		itens = { 
			{
				name = 'Cobre',
				image = 'copper' ,
				quantidade = 1,
				item = 'copper'
			},
			{
				name = 'Aluminio',
				image = 'aluminum' ,
				quantidade = 1,
				item = 'aluminum'
			},
			{
				name = 'Borracha',
				image = 'rubber' ,
				quantidade = 1,
				item = 'rubber'
			}
		}
	}
}
-------------------------------------------------------------------------------------------------
--[ CHECKPERMISSAO ]-----------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function cRP.checkPermission(permissao)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		if vRP.hasPermission(user_id,permissao) then

			return true
		else
			TriggerClientEvent('Notify',source,'negado','Você não possui acesso.')
			return false
		end						
	end
end
-------------------------------------------------------------------------------------------------
--[ CHECKPAYMENT ]-------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function cRP.checkPayment(currentRoute, position)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if cRP.checkPermission(currentRoute) then
			for key,value in pairs(rotas[currentRoute].itens) do
				if ((key - 1) == tonumber(position)) then
					if vRP.inventoryWeight(user_id) + (itemWeight(value.item) * parseInt(value.quantidade)) <= vRP.getBackpack(user_id) then
						vRP.giveInventoryItem(user_id, value.item, tonumber(value.quantidade),true)
					else
						TriggerClientEvent('Notify',source,'vermelho','<b>Mochila</b> cheia.',8000)
					end
				end
			end
		end
	end
end
-------------------------------------------------------------------------------------------------
--[ GETITEMS ]-----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function cRP.getItems(routes)
	return rotas[routes].itens
end
-------------------------------------------------------------------------------------------------
--[ SELECTROUTE ]--------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNetEvent('routes:selectRoute', function(currentRoute, position)
AddEventHandler('routes:selectRoute')
	local source = source
	local user_id = vRP.getUserId(source)
		if user_id then
		for key,value in pairs(rotas[currentRoute].itens) do
			if ((key - 1) == tonumber(position)) then
				TriggerClientEvent('routes:startRoute', source, currentRoute, value.name)		
			end
		end
	end
end)
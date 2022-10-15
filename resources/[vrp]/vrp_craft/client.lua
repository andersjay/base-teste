Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_craft")
func = Tunnel.getInterface("vrp_craft", "vrp_craft")
permissaoMesa = ""
local show = false
local temp_pinventory = nil
local temp_inventory = nil
local temp_weight = nil
local temp_maxWeight = nil
local temp_iWeight = nil
local temp_iMaxWeight = nil
local cooldown = 0
local craftando = false
local openCraft = false
function openGui(pinventory, inventory, weight, maxWeight, iWeight, iMaxWeight, dt, style)
	if show == false then
		show = true
		SetNuiFocus(true, true)
		SendNUIMessage(
			{
				show = true,
				pinventory = pinventory,
				inventory = inventory,
				p_i_weight = weight,
				p_i_maxWeight = maxWeight,
				i_weight = iWeight,
				i_maxWeight = iMaxWeight,
				dataType = dt,
				style = style
			}
		)
	end
end

function closeGui()
	show = false
	openCraft = false
	SetNuiFocus(false)
	SendNUIMessage({show = false})
end

RegisterNetEvent("vrp_craft:openGui")
AddEventHandler(
	"vrp_craft:openGui",
	function(dt, name, name2, style)
		TriggerServerEvent("vrp_craft:openGui", dt, name, name2, style)
	end
)

RegisterNetEvent("vrp_craft:updateInventory")
AddEventHandler(
	"vrp_craft:updateInventory",
	function(pinventory, inventory, weight, maxWeight, iWeight, iMaxWeight, dt, style)
		cooldown = Config.AntiSpamCooldown
		temp_pinventory = pinventory
		temp_inventory = inventory
		temp_weight = weight
		temp_maxWeight = maxWeight
		temp_iWeight = iWeight
		temp_iMaxWeight = iMaxWeight
		openGui(temp_pinventory, temp_inventory, temp_weight, temp_maxWeight, temp_iWeight, temp_iMaxWeight, dt, style)
	end
)

RegisterNetEvent("vrp_craft:UINotification")
AddEventHandler(
	"vrp_craft:UINotification",
	function(type, title, message)
		show = true
		SetNuiFocus(true, true)
		SendNUIMessage(
			{
				show = true,
				notification = true,
				type = type,
				title = title,
				message = message
			}
		)
	end
)

RegisterNetEvent("vrp_craft:closeGui")
AddEventHandler(
	"vrp_craft:closeGui",
	function()
		closeGui()
	end
)

RegisterNUICallback(
	"close",
	function(data)
		closeGui()
	end
)

RegisterCommand(
	"craft",
	function(source, args, rawCommand)
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		if veh ~= 0 then
			TriggerEvent(
				"vrp_craft:openGui",
				1,
				string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),
				string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),
				1
			)
		else
			TriggerEvent("vrp_craft:openGui", 1, 0, 0, 1)
			SendNUIMessage(
				{
					receita = true,
					receitax = receitas
				}
			)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			teste = false

			if teste then
				local ped = PlayerPedId()
				local veh = GetVehiclePedIsIn(ped, false)
				if veh ~= 0 then
					TriggerEvent(
						"vrp_craft:openGui",
						1,
						string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),
						string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh))),
						1
					)
				else
					TriggerEvent("vrp_craft:openGui", 1, 0, 0, 1)
					SendNUIMessage(
						{
							receita = true,
							receitax = receitas
						}
					)
				end
			end
			if IsControlJustPressed(0, 38) then
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if cooldown > 0 then
				cooldown = cooldown - 1
			end
		end
	end
)

AddEventHandler(
	"onResourceStop",
	function(resource)
		if resource == GetCurrentResourceName() then
			closeGui()
		end
	end
)

local cancelando = false
RegisterNetEvent("cancelando")
AddEventHandler(
	"cancelando",
	function(status)
		cancelando = status
	end
)
--------------------------------------------------------------

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if cancelando then
				DisableControlAction(0, 288, true)
				DisableControlAction(0, 289, true)
				DisableControlAction(0, 170, true)
				DisableControlAction(0, 166, true)
				DisableControlAction(0, 187, true)
				DisableControlAction(0, 189, true)
				DisableControlAction(0, 190, true)
				DisableControlAction(0, 188, true)
				DisableControlAction(0, 57, true)
				DisableControlAction(0, 73, true)
				DisableControlAction(0, 167, true)
				DisableControlAction(0, 311, true)
				DisableControlAction(0, 344, true)
				DisableControlAction(0, 29, true)
				DisableControlAction(0, 182, true)
				DisableControlAction(0, 245, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 47, true)
			end
		end
	end
)

RegisterNUICallback(
	"craftar",
	function(data)
		closeGui()
		qtProduzir = func.getIng(data.nomeitem, data.ingredientes, data.producaominima)
		print(qtProduzir)
		if qtProduzir > 0 then
			tempo = qtProduzir * 1000
			TriggerEvent("progress", tempo, "Produzindo " .. data.nome .. " x " .. qtProduzir)
			--TriggerEvent("Notify", "sucesso", "Você Craftou " .. data.nome)
			craftando = true
			segundos = qtProduzir
			vRP.playAnim(true, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female", 1}}, true)

			repeat
				Citizen.Wait(1)
			until segundos == 0
			vRP._stopAnim(false)

			craftando = false
			TriggerServerEvent("vrp_craft:craftar", data.nomeitem, data.ingredientes, qtProduzir)
		else
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if craftando then
				if segundos > 0 then
					segundos = segundos - 1
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsNearBlipCraft() then
				if not openCraft and permitido and not craftando then
					DrawText3D(coords.x, coords.y, coords.z + 0.5, "PRESSIONE  ~g~E~w~  PARA ~g~ABRIR~w~ A MESA DE FABRICAÇÃO")

					if IsControlJustPressed(0, 38) then
						openCraft = true

						TriggerEvent("vrp_craft:openGui", 1, 0, 0, 1)
						SendNUIMessage(
							{
								receita = true,
								receitax = receitaMesa
							}
						)
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			permitido = func.Permissao(permissaoMesa)
		end
	end
)

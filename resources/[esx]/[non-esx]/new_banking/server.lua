--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit1')
AddEventHandler('bank:deposit1', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('chatMessage', _source, "Invalid Amount")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
	end
end)


RegisterServerEvent('bank:withdraw1')
AddEventHandler('bank:withdraw1', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('chatMessage', _source, "Invalid Amount")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
	
end)


RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	local balance = 0
	balance = xPlayer.getAccount('bank').money
	zbalance = zPlayer.getAccount('bank').money
	
	if tonumber(_source) == tonumber(to) then
		TriggerClientEvent('chatMessage', _source, "You cannot transfer to your self")
	else
		if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
			TriggerClientEvent('chatMessage', _source, "You don't have enough money in the bank.")
		else
			xPlayer.removeAccountMoney('bank', amountt)
			zPlayer.addAccountMoney('bank', amountt)
		end
		
	end
end)

-- RegisterServerEvent('bank:transfer')﻿﻿
-- AddEventHandler('bank:transfer', function(to, amountt)
	-- local _source = source
	-- local xPlayer = ESX.GetPlayerFromId(_source)
	-- local zPlayer = ESX.GetPlayerFromId(to)
	-- local balance = 0

	-- if(zPlayer == nil or zPlayer == -1) then
		-- TriggerClientEvent('bank:result', _source, "error", "Destinataire introuvable.")
	-- else
		-- balance = xPlayer.getAccount('bank').money
		-- zbalance = zPlayer.getAccount('bank').money
		
		-- if tonumber(_source) == tonumber(to) then
			-- TriggerClientEvent('bank:result', _source, "error", "Vous ne pouvez pas faire de transfert à vous même.")
		-- else
			-- if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				-- TriggerClientEvent('bank:result', _source, "error", "Vous n'avez pas assez d'argent en banque.")
			-- else
				-- xPlayer.removeAccountMoney('bank', tonumber(amountt))
				-- zPlayer.addAccountMoney('bank', tonumber(amountt))
				-- TriggerClientEvent('bank:result', _source, "success", "Transfert effectué.")
			-- end
		-- end
	-- end
-- end)






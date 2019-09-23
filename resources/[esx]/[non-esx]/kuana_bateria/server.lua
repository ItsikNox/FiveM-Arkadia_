ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kuana:createdb')
AddEventHandler('kuana:createdb', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	local checkdb = MySQL.Sync.fetchScalar("SELECT porcento FROM bateria WHERE owner = @id", {['@id'] = xPlayer.identifier})

	if checkdb then
		TriggerClientEvent("kuana:setbateria", source, checkdb)
	else
		MySQL.Async.execute('INSERT INTO bateria (owner, porcento) VALUES (@owner, @porcento)',
		{
			['@owner']   = xPlayer.identifier,
			["@porcento"] = 100
		}, function (rowsChanged)
			
		end)
	end
end)

RegisterServerEvent('kuana:updatebateria')
AddEventHandler('kuana:updatebateria', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local bateriac = MySQL.Sync.fetchScalar("SELECT porcento FROM bateria WHERE owner = @id", {['@id'] = xPlayer.identifier})
	bateriac = bateriac - 1
	TriggerClientEvent("kuana:setbateria", source, bateriac)
	MySQL.Async.execute("UPDATE bateria SET porcento = @porcento WHERE owner = @owner",
		{
			["@owner"] = xPlayer.identifier,
			["@porcento"] = bateriac
		}
	)
end)

RegisterServerEvent('kuana:updatebateriacarr')
AddEventHandler('kuana:updatebateriacarr', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local bateriac = MySQL.Sync.fetchScalar("SELECT porcento FROM bateria WHERE owner = @id", {['@id'] = xPlayer.identifier})
	bateriac = bateriac + 1
	TriggerClientEvent("kuana:setbateria", source, bateriac)
	MySQL.Async.execute("UPDATE bateria SET porcento = @porcento WHERE owner = @owner",
		{
			["@owner"] = xPlayer.identifier,
			["@porcento"] = bateriac
		}
	)
end)

RegisterServerEvent('kuana:updatebateriat')
AddEventHandler('kuana:updatebateriat', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local bateriac = MySQL.Sync.fetchScalar("SELECT porcento FROM bateria WHERE owner = @id", {['@id'] = xPlayer.identifier})
	TriggerClientEvent("kuana:setbateria", source, bateriac)
end)
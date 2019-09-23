ESX               = nil
local cars 		  = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Supprésion au démarrage des double de clés
AddEventHandler('onMySQLReady', function()
MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE NB = @NB',
		{
		['@NB']   = 2
		},
		function(result)


		for i=1, #result, 1 do
			MySQL.Async.execute(
						'DELETE FROM open_car WHERE id = @id',
						{
							['@id'] = result[i].id
						}
					)
		end
	end)
end)

-- Dépence d'autre scripts
ESX.RegisterServerCallback('esx_society:isowned', function(source, cb, plate, jobs)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)

				MySQL.Async.fetchAll(
					'SELECT * FROM owned_vehicles WHERE owner = @owner',
					{
						['@owner'] = 'society:'..jobs
					},
					function(result)

						local found = false

						for i=1, #result, 1 do

							local vehicleProps = json.decode(result[i].vehicle)

							if vehicleProps.plate == plate then
								found = true
								break
							end
						end
						cb(found)
					end)
end)


-- Véhicle appartenue mais sans clés

ESX.RegisterServerCallback('esx_vehiclelock:getVehiclesnokey', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE identifier = @owner',
		{
			['@owner'] = xPlayer.identifier
		},
		function(result2)

			MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles WHERE owner = @owner',
		{
			['@owner'] = xPlayer.identifier
		},
		function(result)

			local vehicles = {}
			
			for i=1, #result, 1 do
				local found = false
				local vehicleData = json.decode(result[i].vehicle)
				for j=1, #result2, 1 do
					if result2[j].value == vehicleData.plate then
						
						found = true
						
					end
				end

				if found ~= true then
					
					table.insert(vehicles, vehicleData)
				end

			end
			cb(vehicles)
		end
	)
		end
	)
end)

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Véhicle appartenue mais sans clés

ESX.RegisterServerCallback('esx_vehiclelock:getVehiclesnokeycardealer', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE identifier = @owner',
		{
			['@owner'] = xPlayer.identifier
		},
		function(result2)

			MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles WHERE owner = @owner',
		{
			['@owner'] = xPlayer.identifier
		},
		function(result)

			local vehicles = {}

			for i=1, #result, 1 do
				local found = false
				local vehicleData = json.decode(result[i].vehicle)
				for j=1, #result2, 1 do
					if result2[j].value == vehicleData.plate then
						found = true
					end
				end
				if found ~= true then
					table.insert(vehicles, vehicleData)
				end
			end
			cb(vehicles)
		end
	)
		end
	)
end)

-- Donné les clé
RegisterServerEvent('esx_vehiclelock:givekeycardealer')
AddEventHandler('esx_vehiclelock:givekeycardealer', function(target, plate)
local _source = source
local xPlayer = nil
local toplate = plate
xPlayertarget = ESX.GetPlayerFromId(target)
xPlayer = ESX.GetPlayerFromId(_source)

MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = toplate,
			['@NB']   		  = 1,
			['@got']  		  = 'true',
			['@identifier']   = xPlayertarget.identifier
		},
		function(result)
			TriggerClientEvent('esx:showNotification', xPlayertarget.source, '~g~Vous avez reçu les clés de votre véhicule ~g~')
		end)
end)

RegisterServerEvent('esx_vehiclelock:deletekeycardealer')
AddEventHandler('esx_vehiclelock:deletekeycardealer', function(target, plate)
local _source = source
local xPlayer = nil
local toplate = plate
xPlayer = ESX.GetPlayerFromId(_source)

MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE value = @plate AND NB = @NB AND identifier = @identifier',
		{
		['@NB']   		= 3,
		['@plate'] 		= toplate,
		['@identifier'] = xPlayer.identifier
		},
		function(result)

		for i=1, #result, 1 do
			MySQL.Async.execute(
			'DELETE FROM open_car WHERE id = @id',
			{
				['@id'] = result[i].id
			}
		)
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous avez donné les clé à l'acheteur ~g~")
	end)
end)


RegisterServerEvent('esx_vehiclelock:registerkeycardealer')
AddEventHandler('esx_vehiclelock:registerkeycardealer', function(plate, target)
local _source = source
local xPlayer = nil
if target == 'no' then
	 xPlayer = ESX.GetPlayerFromId(_source)
else
	 xPlayer = ESX.GetPlayerFromId(target)
end
MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = plate,
			['@NB']   		  = 3,
			['@got']  		  = 'true',
			['@identifier']   = xPlayer.identifier

		},
		function(result)
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez un nouvelle paire de clés ! ')
				TriggerClientEvent('esx:showNotification', _source, 'Clés bien enregistrer ! ')
		end)
end)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--Clés appartenue par rapport a la plaque
ESX.RegisterServerCallback('esx_vehiclelock:mykey', function(source, cb, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE value = @plate AND identifier = @identifier', 
		{
			['@plate'] = plate,
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false
			if result[1] ~= nil then
				
				if xPlayer.identifier == result[1].identifier then 
					found = true
				end
			end
			if found then
				cb(true)
	
			else
				cb(false)
			end

		end
	)
end)

-- Toutes les clés appartenu par le joueur
ESX.RegisterServerCallback('esx_vehiclelock:allkey', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE identifier = @identifier', 
		{
			['@identifier'] = xPlayer.identifier

		},
		function(result)
			key = {}
			for i=1, #result, 1 do
				
				keyadd = { plate = result[i].value,
							  NB = result[i].NB,
							 got = result[i].got }
					
					table.insert(key, keyadd)
			end
			cb(key)
		end
	)
end)

-- Suppression clé jobs
RegisterServerEvent('esx_vehiclelock:deletekeyjobs')
AddEventHandler('esx_vehiclelock:deletekeyjobs', function(target, plate)
local _source = source
local xPlayer = nil
local toplate = plate

if target ~= 'no' then
	
	 xPlayer = ESX.GetPlayerFromId(target)
else
	
	 xPlayer = ESX.GetPlayerFromId(_source)
end

MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE identifier = @identifier',
		{
		['@identifier']   = xPlayer.identifier
		},
		function(result)


		for i=1, #result, 1 do
			MySQL.Async.execute(
						'DELETE FROM open_car WHERE value = @value',
						{
							['@value'] = toplate
						}
					)
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez rendu les clés du véhicule de fonction')
	end)
end)

-- Donné un double
RegisterServerEvent('esx_vehiclelock:givekey')
AddEventHandler('esx_vehiclelock:givekey', function(target, plate)
local _source = source
local xPlayer = nil
local toplate = plate

if target == 'no' then
	 xPlayer = ESX.GetPlayerFromId(_source)
else
	 xPlayer = ESX.GetPlayerFromId(target)
end


MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = toplate,
			['@NB']   		  = 2,
			['@got']  		  = 'true',
			['@identifier']   = xPlayer.identifier

		},
		function(result)
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez recu un double de clés ')
		end)

end)


--Enregistrement d'une nouvelle paire de clés
RegisterServerEvent('esx_vehiclelock:registerkey')
AddEventHandler('esx_vehiclelock:registerkey', function(plate, target)
local _source = source
local xPlayer = nil
if target == 'no' then
	 xPlayer = ESX.GetPlayerFromId(_source)
else
	 xPlayer = ESX.GetPlayerFromId(target)
end
MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = plate,
			['@NB']   		  = 1,
			['@got']  		  = 'true',
			['@identifier']   = xPlayer.identifier

		},
		function(result)
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez une nouvelle paire de clés ! ')
				TriggerClientEvent('esx:showNotification', _source, 'Clés bien enregistrer ! ')
		end)

end)

--Perte des clés 
RegisterServerEvent('esx_vehiclelock:onplayerdeath')
AddEventHandler('esx_vehiclelock:onplayerdeath', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)

MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE identifier = @identifier',
		{
		['@identifier']   = xPlayer.identifier

		},
		function(result)

		for i=1, #result, 1 do
			if result[i].NB == 1 then 
			MySQL.Async.execute(
						'UPDATE open_car SET got = @got WHERE id = @id',
						{
							['@id'] = result[i].id,
							['@got'] = 'false'
						}
					)
			else
				MySQL.Async.execute(
						'DELETE FROM open_car WHERE id = @id',
						{
							['@id'] = result[i].id
						}
					)
			end
		end
	end)
end)


---------------------------------------------------------------------------------------------
--------------------------------- Menu pour donner / preter clé -----------------------------
---------------------------------------------------------------------------------------------
--
---- changement de propriétaire
RegisterServerEvent('esx_vehiclelock:changeowner')
AddEventHandler('esx_vehiclelock:changeowner', function(target, plate)
local _source = source
local xPlayer = nil
local toplate = plate
xPlayertarget = ESX.GetPlayerFromId(target)
xPlayer = ESX.GetPlayerFromId(_source)

MySQL.Async.fetchAll(
		'INSERT INTO owned_vehicles (owner, plate) VALUES (@owner, @plate)',
		{
		['@owner']   = xPlayertarget.identifier,
		['@plate'] = toplate
		},
		function(result)
			print("insert into terminé")
	end)
end)

------ Donné clé
RegisterServerEvent('esx_vehiclelock:donnerkey')
AddEventHandler('esx_vehiclelock:donnerkey', function(target, plate)
local _source = source
local xPlayer = nil
local toplate = plate
xPlayertarget = ESX.GetPlayerFromId(target)
xPlayer = ESX.GetPlayerFromId(_source)

MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = toplate,
			['@NB']   		  = 1,
			['@got']  		  = 'true',
			['@identifier']   = xPlayertarget.identifier

		},
		function(result)
				TriggerClientEvent('esx:showNotification', xPlayertarget.source, 'Vous avez reçu de nouvelle clé ')
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez donné votre clé, vous ne les avez plus !')
		end)
end)

--- suppression des clés NB = 1
RegisterServerEvent('esx_vehiclelock:deletekey')
AddEventHandler('esx_vehiclelock:deletekey', function(plate)
local _source = source
local xPlayer = nil
local toplate = plate
xPlayer = ESX.GetPlayerFromId(_source)

MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE value = @plate AND NB = @NB AND identifier = @identifier',
		{
		['@NB']   		= 1,
		['@plate'] 		= toplate,
		['@identifier'] = xPlayer.identifier
		},
		function(result)

		for i=1, #result, 1 do
			MySQL.Async.execute(
			'DELETE FROM open_car WHERE id = @id',
			{
				['@id'] = result[i].id
			}
		)
		end
	end)
end)

------- Préter clé
RegisterServerEvent('esx_vehiclelock:preterkey')
AddEventHandler('esx_vehiclelock:preterkey', function(target, plate)
local _source = source
local xPlayer = nil
local toplate = plate
xPlayertarget = ESX.GetPlayerFromId(target)
xPlayer = ESX.GetPlayerFromId(_source)

MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = toplate,
			['@NB']   		  = 2,
			['@got']  		  = 'true',
			['@identifier']   = xPlayertarget.identifier

		},
		function(result)
				TriggerClientEvent('esx:showNotification', xPlayertarget.source, 'Vous avez reçu un double de clé ')
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez prété votre clé')
		end)

end)

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------
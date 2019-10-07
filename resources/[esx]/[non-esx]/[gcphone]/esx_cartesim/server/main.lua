ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

function GenerateUniquePhoneNumber()
    local running = true
    local phone = nil
    while running do
		--local num = '555' .. math.random(0001,9999)
		local numBase0 = math.random(555,555)
   		local numBase1 = math.random(0,9999)
		local rand = string.format("%03d-%04d", numBase0, numBase1 )
      --  --('Recherche ... : ' .. rand)
        local count = MySQL.Sync.fetchScalar("SELECT COUNT(phone_number) FROM sim WHERE phone_number = @phone_number", { ['@phone_number'] = rand })
        if count < 1 then
            phone = rand
            running = false
        end
    end
  --  --('Numero Choisi  : ' .. phone)
    return phone
end

function rNum(source)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
  
	local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
		['@identifier'] = xPlayer.identifier
	})
	  
	if result[1] ~= nil then
		return result[1].phone_number
	else
		return nil
	end
end


AddEventHandler('esx:playerLoaded',function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if rNum(_source) ~= nil or rNum(_source) ~= 0 or rNum(_source) ~= "0" then
		MySQL.Async.fetchAll(
				'SELECT * FROM users WHERE identifier = @identifier',
				{
					['@identifier'] = xPlayer.identifier
				},
				function(result)

					local phoneNumber = rNum(_source)
					
					local count = MySQL.Sync.fetchScalar("SELECT COUNT(phone_number) FROM sim WHERE phone_number = @phone_number", { ['@phone_number'] = phoneNumber })
					if count == 0 then
						MySQL.Async.execute(
							'INSERT INTO sim (phone_number, identifier) VALUES (@phone_number, @identifier)',
							{
								['@phone_number']   = phoneNumber,
								['@identifier']   = xPlayer.identifier,
							},
							function (rowsChanged)

							end
						)
					end
		end)
	end
	
end)

ESX.RegisterUsableItem('sim', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('sim', 1)
	NewSim(source)
end)

function NewSim(source)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
		MySQL.Async.fetchAll(
			'SELECT * FROM users WHERE identifier = @identifier',
			{
				['@identifier'] = xPlayer.identifier
			},
			function(result)

				local phoneNumber = GenerateUniquePhoneNumber() 
				
				MySQL.Async.execute(
					'INSERT INTO sim (phone_number, identifier) VALUES (@phone_number, @identifier)',
					{
						['@phone_number']   = phoneNumber,
						['@identifier']   = xPlayer.identifier,
					},
					function (rowsChanged)
					TriggerClientEvent('esx:showNotification', source, "Vous avez une nouvelle carte sim")
					end
				)
		end)
end

ESX.RegisterServerCallback('esx_cartesim:CheckSim', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local cartesim = rNum(_source)

	if cartesim == 0 then
		cb(false)
	else
		cb(true)
	end
end)

--donner la carte sim a un autre joueur
RegisterServerEvent('esx_cartesim:sim_give')
AddEventHandler('esx_cartesim:sim_give', function (store, index)
  local _source = source
  local id = index
  local xPlayer = ESX.GetPlayerFromId(_source)
  local xPlayer2 = ESX.GetPlayerFromId(id)
  local simZ = store
  local cartesim = nil
  
  TriggerClientEvent('esx:showNotification', _source, "Vous avez donné la carte sim ~o~" .. simZ)
  TriggerClientEvent('esx:showNotification', id, "Vous avez recu la carte sim ~o~" .. simZ)
			
	if simZ ~= nil then

		local num = rNum(_source)

		if num ~= nil then
			if num == simZ then
				MySQL.Async.execute(
					'UPDATE `users` SET phone_number = @phone_number WHERE `identifier` = @identifier',
					{
						['@identifier']   = xPlayer.identifier,
						['@phone_number'] = 0
					}
				)
			end
		end

		MySQL.Async.execute(
			'UPDATE sim SET identifier = @identifier WHERE phone_number = @phone_number',
			{
				['@identifier'] = xPlayer2.identifier,
				['@phone_number'] = simZ
			}
		)
    end
end)

--supprimer la carte sim
RegisterServerEvent('esx_cartesim:sim_delete')
AddEventHandler('esx_cartesim:sim_delete', function (sim)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sim = sim

	local num = rNum(source)

	if num ~= nil then
		if num == sim then
			MySQL.Async.execute(
				'UPDATE `users` SET phone_number = @phone_number WHERE `identifier` = @identifier',
				{
					['@identifier']   = xPlayer.identifier,
					['@phone_number'] = 0
				}
			)
		end
	end

	MySQL.Async.fetchAll(
	  'SELECT * FROM sim',
	  {},
	  function (result)
		for i=1, #result, 1 do
		  local simZ = result[i].phone_number
  
		  if simZ == sim then
			MySQL.Async.execute(
			  'DELETE FROM sim WHERE phone_number = @phone_number',
			  { ['@phone_number'] = result[i].phone_number }
			)
		  end
		end
	  end
	)

end)

--changer de carte sim (need change identifier inside phone_users_contacts)
RegisterServerEvent('esx_cartesim:sim_use')
AddEventHandler('esx_cartesim:sim_use', function (sim)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--local new = sim
	TriggerClientEvent("gcPhone:myPhoneNumber",_source,sim)
	TriggerClientEvent("gcPhone:UpdateNumber",_source,sim)

	MySQL.Async.execute(
		'UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.getIdentifier(),
			['@phone_number'] = sim
		}
	)
end)

--Recupere les cartes sim
ESX.RegisterServerCallback('esx_cartesim:GetList', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local cartesim = {}

	MySQL.Async.fetchAll("SELECT * FROM sim WHERE identifier=@identifier",{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
		for _,v in pairs(data) do
			table.insert(cartesim, {number = v.phone_number})
		end
		cb(cartesim)
	end)
end)

ESX.RegisterServerCallback('esx_cartesim:GetNameZ', function(source, cb, id)
	local id = tostring(id)
	local test = {}

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier=@identifier",{['@identifier'] = id}, function(data) 
		if data ~= nil then
		  for _,v in pairs(data) do
			table.insert(test, {name = v.name, identifier = v.identifier})
		  end
		  cb(test)
		end
	end)
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------
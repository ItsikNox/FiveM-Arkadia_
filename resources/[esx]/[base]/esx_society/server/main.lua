ESX                 = nil
Jobs                = {}
RegisteredSocieties = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end

AddEventHandler('onMySQLReady', function()

  local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

  for i=1, #result, 1 do
    Jobs[result[i].name]        = result[i]
    Jobs[result[i].name].grades = {}
  end

  local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

  for i=1, #result2, 1 do
    Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
  end

end)

AddEventHandler('esx_society:registerSociety', function(name, label, account, datastore, inventory, data)

  local found = false

  local society = {
    name      = name,
    label     = label,
    account   = account,
    datastore = datastore,
    inventory = inventory,
    data      = data,
  }

  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      found                  = true
      RegisteredSocieties[i] = society
      break
    end
  end

  if not found then
    table.insert(RegisteredSocieties, society)
  end

end)

AddEventHandler('esx_society:getSocieties', function(cb)
  cb(RegisteredSocieties)
end)

AddEventHandler('esx_society:getSociety', function(name, cb)
  cb(GetSociety(name))
end)

RegisterServerEvent('esx_society:withdrawMoney')
AddEventHandler('esx_society:withdrawMoney', function(society, amount)

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(society)

  TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)

    if amount > 0 and account.money >= amount then

      account.removeMoney(amount)
      xPlayer.addMoney(amount)

      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', amount))

    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
    end

  end)

end)

RegisterServerEvent('esx_society:depositMoney')
AddEventHandler('esx_society:depositMoney', function(society, amount)

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(society)

  if amount > 0 and xPlayer.get('money') >= amount then

    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
      xPlayer.removeMoney(amount)
      account.addMoney(amount)
    end)

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', amount))

  else
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
  end

end)

local function WhiteningMoney(source,percent)
	local source = source
		SetTimeout(10000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local blackMoney	= xPlayer.getAccount('black_money')
			local _percent		= Config.Percentage
			
			if blackMoney.money < Config.Slice then
				TriggerClientEvent("esx_society:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Nocash') .. Config.Slice)
			else
				local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
				local washedMoney = math.floor(Config.Slice / 100 * (_percent + bonus))

				xPlayer.removeAccountMoney('black_money', Config.Slice)
				xPlayer.addMoney(washedMoney)
				WhiteningMoney(source,_percent)
				
				TriggerClientEvent("esx_society:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))
			end
		end
	end)
end

RegisterServerEvent('esx_society:washMoney')
AddEventHandler('esx_society:washMoney', function(amount)
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')

	if amount > 0 and account.money >= amount then
		
		local washedMoney = math.floor(amount)	

		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(washedMoney)
		
		TriggerClientEvent("esx_society:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))
		
		TriggerEvent("esx:washingmoneyalert",xPlayer.name,amount)
	else
		TriggerClientEvent("esx_society:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('invalid_amount'))
	end

end)

RegisterServerEvent('esx_society:putVehicleInGarage')
AddEventHandler('esx_society:putVehicleInGarage', function(societyName, vehicle)

  local society = GetSociety(societyName)

  TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
    local garage = store.get('garage') or {}
    table.insert(garage, vehicle)
    store.set('garage', garage)
  end)

end)

RegisterServerEvent('esx_society:removeVehicleFromGarage')
AddEventHandler('esx_society:removeVehicleFromGarage', function(societyName, vehicle)

  local society = GetSociety(societyName)

  TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
    
    local garage = store.get('garage') or {}

    for i=1, #garage, 1 do
      if garage[i].plate == vehicle.plate then
        table.remove(garage, i)
        break
      end
    end

    store.set('garage', garage)

  end)

end)

ESX.RegisterServerCallback('esx_society:getSocietyMoney', function(source, cb, societyName)

  local society = GetSociety(societyName)

  if society ~= nil then

    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
      cb(account.money)
    end)

  else
    cb(0)
  end

end)

ESX.RegisterServerCallback('esx_society:getEmployees', function(source, cb, society)

  if Config.EnableESXIdentity then
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job = @job ORDER BY job_grade DESC',
      { ['@job'] = society },
      function (results)
        local employees = {}

        for i=1, #results, 1 do
          table.insert(employees, {
            name        = results[i].firstname .. ' ' .. results[i].lastname,
            identifier  = results[i].identifier,
            job = {
              name        = results[i].job,
              label       = Jobs[results[i].job].label,
              grade       = results[i].job_grade,
              grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
              grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  else
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job = @job ORDER BY job_grade DESC',
      { ['@job'] = society },
      function (result)
        local employees = {}

        for i=1, #result, 1 do
          table.insert(employees, {
            name        = result[i].name,
            identifier  = result[i].identifier,
            job = {
              name        = result[i].job,
              label       = Jobs[result[i].job].label,
              grade       = result[i].job_grade,
              grade_name  = Jobs[result[i].job].grades[tostring(result[i].job_grade)].name,
              grade_label = Jobs[result[i].job].grades[tostring(result[i].job_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  end
end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('esx_society:getEmployees2', function(source, cb, society)

  if Config.EnableESXIdentity then
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job2 = @job2 ORDER BY job2_grade DESC',
      { ['@job2'] = society },
      function (results)
        local employees = {}

        for i=1, #results, 1 do
          table.insert(employees, {
            name        = results[i].firstname .. ' ' .. results[i].lastname,
            identifier  = results[i].identifier,
            job2 = {
              name        = results[i].job2,
              label       = Jobs[results[i].job2].label,
              grade       = results[i].job2_grade,
              grade_name  = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].name,
              grade_label = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  else
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job2 = @job2 ORDER BY job2_grade DESC',
      { ['@job2'] = society },
      function (result)
        local employees = {}

        for i=1, #result, 1 do
          table.insert(employees, {
            name        = result[i].name,
            identifier  = result[i].identifier,
            job2 = {
              name        = result[i].job2,
              label       = Jobs[result[i].job2].label,
              grade       = result[i].job2_grade,
              grade_name  = Jobs[result[i].job2].grades[tostring(result[i].job2_grade)].name,
              grade_label = Jobs[result[i].job2].grades[tostring(result[i].job2_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  end
end)

ESX.RegisterServerCallback('esx_society:getJob', function(source, cb, society)

  local job    = json.decode(json.encode(Jobs[society]))
  local grades = {}

  for k,v in pairs(job.grades) do
    table.insert(grades, v)
  end

  table.sort(grades, function(a, b)
    return a.grade < b.grade
  end)

  job.grades = grades

  cb(job)

end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('esx_society:getJob2', function(source, cb, society)

  local job2    = json.decode(json.encode(Jobs[society]))
  local grades = {}

  for k,v in pairs(job2.grades) do
    table.insert(grades, v)
  end

  table.sort(grades, function(a, b)
    return a.grade < b.grade
  end)

  job2.grades = grades

  cb(job2)

end)

ESX.RegisterServerCallback('esx_society:setJob', function(source, cb, identifier, job, grade, type)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local isBoss = xPlayer.job.grade_name == 'boss'

  if isBoss then
      local xTarget = ESX.GetPlayerFromIdentifier(identifier)

      if xTarget then
          xTarget.setJob(job, grade)

          if type == 'hire' then
              TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_hired', job))
          elseif type == 'promote' then
              TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
          elseif type == 'fire' then
              TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.getJob().label))
          end

          cb()
      else
          MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
              ['@job']        = job,
              ['@job_grade']  = grade,
              ['@identifier'] = identifier
          }, function(rowsChanged)
              cb()
          end)
      end
  else
      notifMsg    = "[JOB] | " ..xPlayer.name.. " ["..xPlayer.identifier.. "] a été automatiquement kick pour avoir tenté de ce mettre Patron d'un métier."
      playerMsg    = " Exploi de esx_society. Si vous pensez que c'est une erreur, veuillez consulter notre Discord : https://discord.gg/ACHANGER"
      print(notifMsg)
      DropPlayer(source, 'Lua Execution/Mod Menu')
      TriggerClientEvent('chatMessage', -1, '^3[Chat]', {255, 0, 0}, "^3" ..xPlayer.name.. "^1 a été kick pour avoir tenté de ce mettre Patron d'un métier.")
      TriggerEvent('DiscordBot:ToDiscord', 'cheat', 'AntiCheat', notifMsg, 'https://scotchandiron.org/gameassets/anticheat-icon.png', true)
      cb()
    end
end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('esx_society:setJob2', function(source, cb, identifier, job2, grade2, type)

	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

	if xPlayer ~= nil then
		xPlayer.setJob2(job2, grade2)
		
		if type == 'hire' then
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_been_hired', job2))
		elseif type == 'promote' then
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_been_promoted'))
		elseif type == 'fire' then
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_been_fired', xPlayer.getJob2().label))
		end
	end

	MySQL.Async.execute(
		'UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier',
		{
			['@job2']        = job2,
			['@job2_grade']  = grade2,
			['@identifier'] = identifier
		},
		function(rowsChanged)
			cb()
		end
	)

end)

ESX.RegisterServerCallback('esx_society:setJobSalary1', function(source, cb, job, grade, salary)

  MySQL.Async.execute(
    'UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade',
    {
      ['@salary']   = salary,
      ['@job_name'] = job,
      ['@grade']    = grade
    },
    function(rowsChanged)

      Jobs[job].grades[tostring(grade)].salary = salary

      local xPlayers = ESX.GetPlayers()

      for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == job and xPlayer.job.grade == grade then
          xPlayer.setJob(job, grade)
        end

      end

      cb()
    end
  )

end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('esx_society:setJobSalary2', function(source, cb, job2, grade2, salary)

  MySQL.Async.execute(
    'UPDATE job2_grades SET salary = @salary WHERE job2_name = @job2_name AND grade2 = @grade',
    {
      ['@salary']   = salary,
      ['@job2_name'] = job2,
      ['@grade']    = grade2
    },
    function(rowsChanged)

      Jobs[job2].grades[tostring(grade2)].salary = salary

      local xPlayers = ESX.GetPlayers()

      for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job2.name == job2 and xPlayer.job2.grade == grade2 then
          xPlayer.setJob2(job2, grade2)
        end

      end

      cb()
    end
  )

end)

ESX.RegisterServerCallback('esx_society:getOnlinePlayers', function(source, cb)

  local xPlayers = ESX.GetPlayers()
  local players  = {}

  for i=1, #xPlayers, 1 do

    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

    table.insert(players, {
      source     = xPlayer.source,
      identifier = xPlayer.identifier,
      name       = xPlayer.name,
      job        = xPlayer.job
    })

  end

  cb(players)

end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('esx_society:getOnlinePlayers2', function(source, cb)

  local xPlayers = ESX.GetPlayers()
  local players  = {}

  for i=1, #xPlayers, 1 do

    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

    table.insert(players, {
      source     = xPlayer.source,
      identifier = xPlayer.identifier,
      name       = xPlayer.name,
      job2        = xPlayer.job2
    })

  end

  cb(players)

end)

ESX.RegisterServerCallback('esx_society:getVehiclesInGarage', function(source, cb, societyName)

  local society = GetSociety(societyName)

  TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
    local garage = store.get('garage') or {}
    cb(garage)
  end)

end)
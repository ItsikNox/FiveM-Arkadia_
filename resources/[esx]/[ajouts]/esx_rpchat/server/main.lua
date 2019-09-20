ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end

--------------------OOC

RegisterCommand('ooc', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(5)
  local name = getIdentity(source)
  fal = name.firstname .. " " .. name.lastname
  TriggerClientEvent('chat:addMessage', -1, {
      template = '<div class="chat-message-ooc"><b>OOC {0}:</b> {1}</div>',
      args = { fal, msg }
  })
end, false)

--------------------ANO

AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
     if sm[1] == "/ano" then
      local identity = getIdentity(source)
	  local msg = string.sub(msg,5)
         CancelEvent()
  -- TriggerClientEvent('chatMessage', -1, "^0[^4Anonyme^0]^0", {255, 255, 255}, string.sub(msg,6))
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message-vpn"><b>VPN :</b> {1}</div>',
        args = { fal, msg }
    })
     end
  end
end)



--------------------Me

AddEventHandler('chatMessage', function(source, name, msg)
  if msg:sub(1, 1) == "/" then
    sm = stringsplit(msg, " ");
     if sm[1] == "/me" then
      local identity = getIdentity(source)
         CancelEvent()
 TriggerClientEvent('chatMessage', -1, "^9 " .. identity.firstname .. " " .. identity.lastname .. "", {255, 255, 255}, string.sub(msg,5))
     end
  end
end)


--------------------TWT

RegisterCommand('twt', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(5)
  local name = getIdentity(source)
  fal = name.firstname .. " " .. name.lastname
  TriggerClientEvent('chat:addMessage', -1, {
      template = '<div class="chat-message"><b>Twitter @{0}:</b> {1}</div>',
      args = { fal, msg }
  })
end, false)


--------------------NEWS

RegisterCommand('news', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(6)
  local name = getIdentity(source)
  if xPlayer.job.name == 'mecano' or xPlayer.job.name == 'cardealer' or xPlayer.job.name == 'ammu' or xPlayer.job.name == 'journaliste' or xPlayer.job.name == 'unicorn' or xPlayer.job.name == 'nightclub' or xPlayer.job.name == 'bahama' or xPlayer.job.name == 'taxi' then
  fal = name.firstname .. " " .. name.lastname
  TriggerClientEvent('chat:addMessage', -1, {
      template = '<div class="chat-message-ad"><b>Annonce Publicitaire :</b> {1}</div>',
      args = { fal, msg }
  })
  end
end, false)


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

function makeArgs(cmd)
    args = {}
    for i = 2, #cmd, 1 do
        table.insert(args, cmd[i])
    end
    return args
end

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------
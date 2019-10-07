--====================================================================================
-- # Discord gcphone#7085
--====================================================================================
function YellowGetPagess (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT yellow_tweets.*,
        users.firstname,
        users.phone_number
      FROM yellow_tweets
        LEFT JOIN users
        ON yellow_tweets.firstname = users.firstname
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  end
end

function getUserYellow(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT firstname, phone_number FROM users WHERE users.firstname = @firstname AND users.phone_number = @phone_number", {
    ['@phone_number'] = phone_number,
	['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end


function YellowPostPages (phone_number, firstname, lastname, message, sourcePlayer, cb)
    getUserYellow(phone_number, firstname, function (user)
    if user == nil then
      if sourcePlayer ~= nil then
        TwitterShowError(sourcePlayer, 'Twitter Info', 'APP_TWITTER_NOTIF_LOGIN_ERROR')
      end
      return
    end
    MySQL.Async.insert("INSERT INTO yellow_tweets (`phone_number`, `firstname`, `lastname`, `message`) VALUES(@phone_number, @firstname, @lastname, @message);", {
	  ['@phone_number'] = phone_number,
	  ['@firstname'] = firstname,
	  ['@lastname'] = lastname,
      ['@message'] = message
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from yellow_tweets WHERE id = @id', {
        ['@id'] = id
      }, function (pagess)
        pages = pagess[1]
        pages['firstname'] = user.firstname
        pages['phone_number'] = user.phone_number
        TriggerClientEvent('gcphone:yellow_newPagess', -1, pages)
        TriggerEvent('gcphone:yellow_newPagess', pages)
      end)
    end)
  end)
end


function YellowShowError (sourcePlayer, title, message)
  TriggerClientEvent('gcphone:yellow_showError', sourcePlayer, message)
end
function YellowShowSuccess (sourcePlayer, title, message)
  TriggerClientEvent('gcphone:yellow_showSuccess', sourcePlayer, title, message)
end

RegisterServerEvent('gcphone:yellow_getPagess')
AddEventHandler('gcphone:yellow_getPagess', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
  if phone_number ~= nil and phone_number ~= "" and firstname ~= nil and firstname ~= "" then
    getUserYellow(phone_number, firstname, function (user)
      local accountId = user and user.id
      YellowGetPagess(accountId, function (pagess)
        TriggerClientEvent('gcphone:yellow_getPagess', sourcePlayer, pagess)
      end)
    end)
  else
    YellowGetPagess(nil, function (pagess)
      TriggerClientEvent('gcphone:yellow_getPagess', sourcePlayer, pagess)
    end)
  end
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			phone_number = identity['phone_number'],
		}
	else
		return nil
	end
end

RegisterServerEvent('gcphone:yellow_postPagess')
AddEventHandler('gcphone:yellow_postPagess', function(firstname, phone_number, lastname, message)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
  YellowPostPages(name.phone_number, name.firstname, name.lastname, message, sourcePlayer)
end)


function deleteYellow(id)
    MySQL.Sync.execute("DELETE FROM yellow_tweets WHERE `id` = @id", {
        ['@id'] = id
    })
end

RegisterServerEvent('gcphone:deleteYellow')
AddEventHandler('gcphone:deleteYellow', function(id)
    deleteYellow(id)
end)



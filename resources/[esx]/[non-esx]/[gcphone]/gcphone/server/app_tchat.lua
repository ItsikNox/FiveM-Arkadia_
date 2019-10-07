--====================================================================================
-- # Discord gcphone#7085
--====================================================================================

function TchatGetMessageChannel (channel, cb)
    MySQL.Async.fetchAll("SELECT * FROM phone_app_chat WHERE channel = @channel ORDER BY time DESC LIMIT 100", { 
        ['@channel'] = channel
    }, cb)
end

function TchatAddMessage (channel, message)
  local Query = "INSERT INTO phone_app_chat (`channel`, `message`) VALUES(@channel, @message);"
  local Query2 = 'SELECT * from phone_app_chat WHERE `id` = @id;'
  local Parameters = {
    ['@channel'] = channel,
    ['@message'] = message
  }
  MySQL.Async.insert(Query, Parameters, function (id)
    MySQL.Async.fetchAll(Query2, { ['@id'] = id }, function (reponse)
      TriggerClientEvent('gcphone:tchat_receive', -1, reponse[1])
    end)
  end)
end


RegisterServerEvent('gcphone:tchat_channel')
AddEventHandler('gcphone:tchat_channel', function(channel)
  local sourcePlayer = tonumber(source)
  TchatGetMessageChannel(channel, function (messages)
    TriggerClientEvent('gcphone:tchat_channel', sourcePlayer, channel, messages)
  end)
end)

RegisterServerEvent('gcphone:tchat_addMessage')
AddEventHandler('gcphone:tchat_addMessage', function(channel, message)
  TchatAddMessage(channel, message)
end)
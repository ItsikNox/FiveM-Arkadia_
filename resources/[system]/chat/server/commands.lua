--[[ COMMANDS ]]--
Config        = {}

Config.EnableESXIdentity = true
Config.OnlyFirstname     = false

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

--[[
RegisterCommand('ooc', function(source, args, rawCommand)
    local src = source
    local msg = rawCommand:sub(5)
    if player ~= false then
        local user = GetPlayerName(src)
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message-ooc"><b>OOC {0}:</b> {1}</div>',
            args = { user, msg }
        })
    end
end, false)

RegisterCommand('twt', function(source, args, rawCommand)
    local src = source
    local msg = rawCommand:sub(5)
    if player ~= false then
        local name = GetCharacterName(src)
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message"><b>Twitter @{0}:</b> {1}</div>',
            args = { name, msg }
        })
    end
end, false)

RegisterCommand('adv', function(source, args, rawCommand)
    local src = source
    local msg = rawCommand:sub(5)
    if player ~= false then
        local name = GetCharacterName(src)
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message-ad"><b>Annonce Publicitaire :</b> {1}</div>',
            args = { name, msg }
        })
    end
end, false)

RegisterCommand('vpn', function(source, args, rawCommand)
    local src = source
    local msg = rawCommand:sub(5)
    if player ~= false then
        local name = ""
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message-vpn"><b>VPN :</b> {1}</div>',
            args = { name, msg }
        })
    end
end, false)

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
--]]
-- CONFIG --

-- Ping Limit
pingLimit = 400

-- CODE --

RegisterServerEvent("checkMyPingBro")
AddEventHandler("checkMyPingBro", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "Ping trop élevé (Limite: " .. pingLimit .. " Votre ping: " .. ping .. ")")
	end
end)
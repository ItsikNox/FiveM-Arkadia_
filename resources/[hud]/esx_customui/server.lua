TriggerEvent('es:addCommand', 'togglehud', function(source, args)
	if not args then 
		TriggerClientEvent('chatMessage', source, "[SYNTAX]", {255, 0, 0}, "/togglehud [on/off]") 
	else
	local a = tostring(args[1])
		if a == "off" then
			TriggerClientEvent('ui:toggle', source,false)
		elseif a == "on" then
			TriggerClientEvent('ui:toggle', source,true)
		else
			TriggerClientEvent('chatMessage', source, "[SYNTAX]", {255, 0, 0}, "/togglehud [on/off]") 
		end
	end
end, {help = "Toggles the hud on and off"})

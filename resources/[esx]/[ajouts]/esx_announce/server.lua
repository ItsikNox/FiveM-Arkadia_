-- Announcing
TriggerEvent('es:addGroupCommand', 'announce', "admin", function(source, args, user)
	TriggerClientEvent('announce', -1, "~o~ANNONCE", table.concat(args, " "), 5)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Autorisations insuffisantes !")
end, {help = "Annoncer un message à l'ensemble du serveur", params = {{name = "announcement", help = "Le message à annoncer"}}})
RegisterNetEvent('BanSql:Respond')
AddEventHandler('BanSql:Respond', function()
	TriggerServerEvent("BanSql:CheckMe")
end)
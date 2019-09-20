ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('announce')
AddEventHandler('announce', function(title, msg, sec)
	ESX.Scaleform.ShowFreemodeMessage(title, msg, sec)
end)

--ikNox#6088
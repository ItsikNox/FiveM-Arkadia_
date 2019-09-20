--ESX INIT--
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--SERVER EVENT--

ESX.RegisterUsableItem('jumelles', function(source) -- Consider the item as usable

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('jumelles:Active', source) --Trigger the event when the player is using the item

end)
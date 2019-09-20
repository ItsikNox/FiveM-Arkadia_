ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('buyEau')
AddEventHandler('buyEau', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceEau
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('water', 1)
end)

RegisterNetEvent('buyChocolat')
AddEventHandler('buyChocolat', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceChocolat
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('chocolate', 1)
end)

RegisterNetEvent('buyCocaCola')
AddEventHandler('buyCocaCola', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceCocaCola
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('cocacola', 1)
end)

RegisterNetEvent('buySoda')
AddEventHandler('buySoda', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceSoda
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('soda', 1)
end)

RegisterNetEvent('buyHamburgerPlate')
AddEventHandler('buyHamburgerPlate', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceHamburgerPlate
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('hamburgerplate', 1)
end)

RegisterNetEvent('buyBreadSaucisson')
AddEventHandler('buyBreadSaucisson', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceBreadSaucisson
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('breadsaucisson', 1)
end)

RegisterNetEvent('buyPain')
AddEventHandler('buyPain', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PricePain
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('bread', 1)
end)

RegisterNetEvent('buySandwich')
AddEventHandler('buySandwich', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceSandwich
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('sandwich', 1)
end)

RegisterNetEvent('buyHamburger')
AddEventHandler('buyHamburger', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceHamburger
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('hamburger', 1)
end)

RegisterNetEvent('buyCupCake')
AddEventHandler('buyCupCake', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceCupCake
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('cupcake', 1)
end)

RegisterNetEvent('buyGPS')
AddEventHandler('buyGPS', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceGPS
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('gps', 1)
end)


RegisterNetEvent('buyBeef')
AddEventHandler('buyBeef', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceBeef
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('beef', 1)
end)

RegisterNetEvent('buyChocolat')
AddEventHandler('buyChocolat', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceChocolat
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('chocolat', 1)
end)

RegisterNetEvent('buySim')
AddEventHandler('buySim', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceSim
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('sim', 1)
end)

RegisterNetEvent('buyTel')
AddEventHandler('buyTel', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.PriceTel
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('tel', 1)
end)


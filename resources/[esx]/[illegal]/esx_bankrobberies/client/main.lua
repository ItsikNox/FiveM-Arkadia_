Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX                           = nil
local hasbag                  = false
local MinPolice = 3
local blip = nil

local robberyOngoing = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj
        end)

        Citizen.Wait(1)
    end

    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
    end
end) 

RegisterNetEvent('esx_bankrobberies:killblip')
AddEventHandler('esx_bankrobberies:killblip', function()
    RemoveBlip(blip)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

BankHeists = {
    ["Fleeca_Bank_Highway"] = {

        ["Money"] = 150000,

        ["Bank_Vault"] = {
            ["model"] = -63539571,
            ["x"] = -2958.539,
            ["y"] = 482.2706,
            ["z"] = 15.835,
            ["hStart"] = 0.0,
            ["hEnd"] = -79.5
        },

        ["Start_Robbing"] = { 
            ["x"] = -2956.5705566406, 
            ["y"] = 481.70111083984, 
            ["z"] = 15.697088241577, 
            ["h"] = 357.9729309082 
        },

        ["Cash_Pile"] = { 
            ["x"] = -2954.1071777344, 
            ["y"] = 484.38818359375, 
            ["z"] = 16.267852783203, 
            ["h"] = 86.886528015137 
        }

    },

    ["Fleeca_Bank_Center"] = {

        ["Money"] = 150000,

        ["Bank_Vault"] = {
            ["model"] = 2121050683,
            ["x"] = 148.025,
            ["y"] = -1044.364,
            ["z"] = 29.50693,
            ["hStart"] = 249.846,
            ["hEnd"] = -183.599
        },

        ["Start_Robbing"] = { 
            ["x"] = 146.86993408203, 
            ["y"] = -1046.0607910156, 
            ["z"] = 29.368083953857, 
            ["h"] = 218.72334289551
        },

        ["Cash_Pile"] = { ["x"] = 148.67572021484, ["y"] = -1049.197265625, ["z"] = 29.93883895874, ["h"] = 160.95620727539 },
        ["Bags"] = { ["x"] = 150.79, ["y"] = -1046.19, ["z"] = 28.44, ["h"] = 67.99 }


    },

    ["Fleeca_Bank_Top"] = {

        ["Money"] = 150000,

        ["Bank_Vault"] = {
            ["model"] = 2121050683,
            ["x"] = -352.725,
            ["y"] = -53.564,
            ["z"] = 49.50693,
            ["hStart"] = 249.846,
            ["hEnd"] = -183.599
        },

        ["Start_Robbing"] = { 
            ["x"] = -353.85614013672, 
            ["y"] = -55.297225952148, 
            ["z"] = 49.036598205566, 
            ["h"] = 222.63375854492
        },

        ["Cash_Pile"] = { ["x"] = -352.00219726563, ["y"] = -58.390628814697, ["z"] = 49.60733795166, ["h"] = 160.58137512207 },
        ["Bags"] = { ["x"] = -350.12, ["y"] = -55.31, ["z"] = 47.81, ["h"] = 67.99 }


    },
}

RegisterNetEvent("esx_bankrobbery:alertCops")
AddEventHandler("esx_bankrobbery:alertCops", function(bankId)
    local coords = BankHeists[bankId]["Start_Robbing"]

    ESX.ShowNotification("BANK: ALARM!", "", 10000)

    blip = AddBlipForCoord(coords["x"], coords["y"], coords["z"])
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 75)
end)

Citizen.CreateThread(function()
    ResetDoors()

    while true do
        Citizen.Wait(5)

        if not robberyOngoing then

            for bank, values in pairs(BankHeists) do
                local StartPosition = values["Start_Robbing"]

                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                local distanceCheck = GetDistanceBetweenCoords(pedCoords, StartPosition["x"], StartPosition["y"], StartPosition["z"], true)

                if distanceCheck <= 5.0 then
                    ESX.Game.Utils.DrawText3D(StartPosition, "[E] Démarré le casse", 0.4)
                    if distanceCheck <= 1.5 then

                        if IsControlJustPressed(0, Keys["E"]) then
                            ESX.TriggerServerCallback("esx_bankrobbery:fetchCops", function(IsEnough)
                                if IsEnough then
                                    TriggerServerEvent("esx_bankrobbery:startRobbery", bank)
                                else
                                    ESX.ShowNotification("Il n'y a pas assez de policier !")
                                end
                            end, MinPolice)
                        end
                    end
                end
            end

        end
    end

end)

RegisterNetEvent("esx_bankrobbery:startRobbery")
AddEventHandler("esx_bankrobbery:startRobbery", function(bankId)
    RemoveBlip(blip)
    DeleteEntity(CashPile)
    StartRobbery(bankId)
end)

RegisterNetEvent("esx_bankrobbery:endRobbery")
AddEventHandler("esx_bankrobbery:endRobbery", function(bankId)
    robberyOngoing = false
    DeleteEntity(CashPile)
    RemoveBlip(blip)
end)

RegisterNetEvent("esx_bankrobbery:changeCash")
AddEventHandler("esx_bankrobbery:changeCash", function(bankId, newCash)
    if newCash <= 0 then
        BankHeists[bankId]["Money"] = 0
    end

    BankHeists[bankId]["Money"] = newCash
end)

function StartRobbery(bankId)

    DeleteEntity(CashPile)
    robberyOngoing = true

    local CashPosition = BankHeists[bankId]["Cash_Pile"]
    local BagPosition = BankHeists[bankId]["Bags"]

    loadModel("bkr_prop_bkr_cashpile_04")
    loadAnimDict("anim@heists@ornate_bank@grab_cash_heels")

    local CashPile = CreateObject(GetHashKey("bkr_prop_bkr_cashpile_04"), CashPosition["x"], CashPosition["y"], CashPosition["z"], false)
    PlaceObjectOnGroundProperly(CashPile)
    SetEntityRotation(CashPile, 0, 0, CashPosition["h"], 2)
    FreezeEntityPosition(CashPile, true)
    SetEntityAsMissionEntity(CashPile, true, true)

    local Bags = CreateObject(GetHashKey("prop_cs_heist_bag_01"), BagPosition["x"], BagPosition["y"], BagPosition["z"], false)
    PlaceObjectOnGroundProperly(Bag)
    SetEntityRotation(Bag, 0, 0, BagPosition["h"], 2)
    FreezeEntityPosition(Bag, false)
    SetEntityAsMissionEntity(Bag, true, true)

    Citizen.CreateThread(function()
        while robberyOngoing do
            Citizen.Wait(5)

            local Cash = BankHeists[bankId]["Money"]

            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local distanceCheck = GetDistanceBetweenCoords(pedCoords, CashPosition["x"], CashPosition["y"], CashPosition["z"], false)
            local distanceCheck2 = GetDistanceBetweenCoords(pedCoords, BagPosition["x"], BagPosition["y"], BagPosition["z"], false)
            local bag = {['bags_1'] = 44, ['bags_2'] = 0}
            local bagdone = {['bags_1'] = 45, ['bags_2'] = 0}

            if hasbag == false then
            if distanceCheck2 <= 1.5 then
                ESX.Game.Utils.DrawText3D({ x = BagPosition["x"], y = BagPosition["y"], z = BagPosition["z"] }, "[E] Grab Bag ", 0.4)
                if IsControlJustPressed(0, Keys["E"]) then
                    hasbag = true
                    TriggerEvent('skinchanger:getSkin', function(skin)
        
                            if skin.sex == 0 then
                                TriggerEvent('skinchanger:loadClothes', skin, bag)
                            else
                                TriggerEvent('skinchanger:loadClothes', skin, bag)
                            end
                        end)
                    end
                end
            end

            if distanceCheck <= 1.5 then
                if robberyOngoing == true then
                    if hasbag == true then
                ESX.Game.Utils.DrawText3D({ x = CashPosition["x"], y = CashPosition["y"], z = CashPosition["z"] }, "[E] Grab " .. Cash, 0.4)
                if IsControlJustPressed(0, Keys["E"]) then

                    if Cash > 0 then
                        GrabCash(bankId)
                    else
                        DeleteEntity(CashPile)
                        DeleteEntity(Bags)

                        BankHeists[bankId]["Money"] = 0

                        ESX.ShowNotification("Everything is already recieved!")

                        TriggerServerEvent("esx_bankrobbery:endRobbery", bankId)
                        DeleteEntity(CashPile)
                        TriggerEvent('skinchanger:getSkin', function(skin)
        
                            if skin.sex == 0 then
                                TriggerEvent('skinchanger:loadClothes', skin, bagdone)
                            else
                                TriggerEvent('skinchanger:loadClothes', skin, bagdone)
                            end
                        end)
                    end
                end
            end

            if IsControlJustPressed(0, Keys["X"]) then
                DeleteEntity(CashPile)
                DeleteEntity(Bags)
                robberyOngoing = false
                hasbag = false
            end
        end
        end
    end
    end)

end

function GrabCash(bankId)
    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)

    Citizen.Wait(7500)

    ClearPedTasks(PlayerPedId())

    local cashRecieved = math.random(5000, 7000)

    TriggerServerEvent("esx_bankrobbery:grabbedCash", bankId, BankHeists[bankId]["Money"], cashRecieved)
end

function loadAnimDict(dict)
    Citizen.CreateThread(function()
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            
            Citizen.Wait(1)
        end
    end)
end

function loadModel(model)
    Citizen.CreateThread(function()
        while not HasModelLoaded(model) do
            RequestModel(model)
          Citizen.Wait(1)
        end
    end)
end

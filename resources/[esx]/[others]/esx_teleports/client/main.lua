ESX                           = nil

local PlayerData              = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    LoadMarkers()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    PlayerData.job2 = job2
end)

function LoadMarkers()
    Citizen.CreateThread(function()
    
        while true do
            Citizen.Wait(5)

            local plyCoords = GetEntityCoords(PlayerPedId())

            for location, val in pairs(Config.Teleporters) do

                local Enter = val['Enter']
                local Exit = val['Exit']
                local JobNeeded = val['Job2']

                local dstCheckEnter, dstCheckExit = GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'], Enter['z'], true), GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true)

                if dstCheckEnter <= 7.5 then
                    if JobNeeded ~= 'none' then
                        if PlayerData.job2.name == JobNeeded then

                            DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'])

                            if dstCheckEnter <= 1.2 then
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'enter')
                                end
                            end

                        end
                    else
                        DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'])

                        if dstCheckEnter <= 1.2 then

                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'enter')
                            end

                        end

                    end
                end

                if dstCheckExit <= 7.5 then
                    if JobNeeded ~= 'none' then
                        if PlayerData.job2.name == JobNeeded then

                            DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'])

                            if dstCheckExit <= 1.2 then
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'exit')
                                end
                            end

                        end
                    else

                        DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'])

                        if dstCheckExit <= 1.2 then

                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'exit')
                            end

                        end
                    end
                end

            end

        end

    end)
end

function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Exit'])

        DoScreenFadeIn(100)
    else
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Enter'])

        DoScreenFadeIn(100)
    end
end


function DrawM(hint, type, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end

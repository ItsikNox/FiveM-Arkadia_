POSITIONS = {}

POSITIONS.marker = {}
POSITIONS.marker.active = false
POSITIONS.marker.x = 0.0
POSITIONS.marker.y = 0.0
POSITIONS.marker.z = 0.0
POSITIONS.marker.h = 0.0
POSITIONS.marker.r = 1.0

POSITIONS.start = function () 
    if POSITIONS.marker.active then return end

    POSITIONS.marker.x = (Floor((GetEntityCoords(GetPlayerPed(-1), true).x)*100))/100
    POSITIONS.marker.y = (Floor((GetEntityCoords(GetPlayerPed(-1), true).y)*100))/100
    POSITIONS.marker.z = (Floor((GetEntityCoords(GetPlayerPed(-1), true).z)*100))/100
    POSITIONS.marker.h = Floor(GetEntityHeading(GetPlayerPed(-1)))
    POSITIONS.marker.r = 1.0

    POSITIONS.marker.h = POSITIONS.marker.h + 0.5
    if POSITIONS.marker.h > 360 then 
        POSITIONS.marker.h = 0.0
    elseif POSITIONS.marker.h < 0 then  
        POSITIONS.marker.h = 360.0
    end

    POSITIONS.marker.active = true
end

function subTitle(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time or 3000, 1)
end

Citizen.CreateThread(function () 
    while true do 
        Citizen.Wait(0)
        if (IsControlJustReleased(1, 29)) then
            POSITIONS.start()
        end
        
        if (IsControlPressed(1, 172)) then -- ARROW UP
            POSITIONS.marker.x = POSITIONS.marker.x + 0.01
        end

        if (IsControlPressed(1, 173)) then -- ARROW DOWN
            POSITIONS.marker.x = POSITIONS.marker.x - 0.01
        end

        if (IsControlPressed(1, 174)) then -- ARROW LEFT
            POSITIONS.marker.y = POSITIONS.marker.y + 0.01
        end

        if (IsControlPressed(1, 175)) then -- ARROW RIGHT
            POSITIONS.marker.y = POSITIONS.marker.y - 0.01
        end
        
        if (IsControlPressed(1, 10)) then -- PAGE UP
            POSITIONS.marker.z = POSITIONS.marker.z + 0.01
        end

        if (IsControlPressed(1, 11)) then --PAGE DOWN
            POSITIONS.marker.z = POSITIONS.marker.z - 0.01
        end

        if (IsControlPressed(1, 108)) then -- NUMPAD 4
            POSITIONS.marker.h = POSITIONS.marker.h + 0.5
            if POSITIONS.marker.h > 360 then 
                POSITIONS.marker.h = 0.0
            elseif POSITIONS.marker.h < 0 then  
                POSITIONS.marker.h = 360.0
            end
        end

        if (IsControlPressed(1, 109)) then -- NUMPAD 6
            POSITIONS.marker.h = POSITIONS.marker.h - 0.5
            if POSITIONS.marker.h > 360 then 
                POSITIONS.marker.h = 0.0
            elseif POSITIONS.marker.h < 0 then  
                POSITIONS.marker.h = 360.0
            end
        end

        if (IsControlPressed(1, 96)) then -- NUMPAD +
            POSITIONS.marker.r = POSITIONS.marker.r + 0.05
            Citizen.Wait(10)
        end

        if (IsControlPressed(1, 97)) then --NUMPAD -
            POSITIONS.marker.r = POSITIONS.marker.r - 0.05
            Citizen.Wait(10)
        end

        if (IsControlJustReleased(1, 176)) then -- ENTER
            local text = "{x = "..POSITIONS.marker.x..", y = "..POSITIONS.marker.y..", z = "..POSITIONS.marker.z..", h = "..POSITIONS.marker.h..", r = "..POSITIONS.marker.r.."},"
            subTitle(text)

            TriggerServerEvent("position:s:insert", text)
            
            POSITIONS.marker.x = 0.0
            POSITIONS.marker.y = 0.0
            POSITIONS.marker.z = 0.0
            POSITIONS.marker.h = 0.0
            POSITIONS.marker.active = false

            subTitle("Position saved !")
        end

        if (IsControlJustReleased(1, 177)) then
            POSITIONS.marker.x = 0.0
            POSITIONS.marker.y = 0.0
            POSITIONS.marker.z = 0.0
            POSITIONS.marker.h = 0.0
            POSITIONS.marker.active = false
        end
    end 
end)

Citizen.CreateThread(function () 
    while true do 
        Citizen.Wait(0)
        if POSITIONS.marker.active then
            DrawMarker(26, POSITIONS.marker.x, POSITIONS.marker.y, POSITIONS.marker.z, 0, 0, 0, 0, 0, POSITIONS.marker.h, POSITIONS.marker.r, POSITIONS.marker.r, 0.5, 0, 0, 255, 120, 0, 0, 2, 0, 0, 0, 0)
            
            local text = "{x = "..POSITIONS.marker.x..", y = "..POSITIONS.marker.y..", z = "..POSITIONS.marker.z..", h = "..POSITIONS.marker.h..", r = "..POSITIONS.marker.r.."},"
            subTitle(text)
        end
    end 
end)
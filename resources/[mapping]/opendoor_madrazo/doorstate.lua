--
lockState = {    
   [1] = { ["objName"] = "v_ilev_ra_door4l", ["x"]= 1395.920, ["y"]= 1142.904, ["z"]= 114.700, ["locked"]= false }, -- front left
   [2] = { ["objName"] = "v_ilev_ra_door4r", ["x"]= 1395.919, ["y"]= 1140.704, ["z"]= 114.790, ["locked"]= false }, -- front right
}
--
drawOnScreen3D = function(dx,dy,dz, text, size)

    local onScreen, x, y = World3dToScreen2d(dx,dy,dz)
    local camCoords      = GetGameplayCamCoords()
    local dist           = GetDistanceBetweenCoords(camCoords.x, camCoords.y, camCoords.z, dx, dy, dz, 1)
    local size           = size
  
    if size == nil then
      size = 1
    end
  
    local scale = (size / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
  
    if onScreen then
  
      SetTextScale(0.0 * scale, 0.55 * scale)
      SetTextFont(0)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry('STRING')
      SetTextCentre(1)
  
      AddTextComponentString(text)
  
      DrawText(x, y)
    end
  
  end
--
RegisterNetEvent('OD:state')
AddEventHandler('OD:state', function(id, isLocked)
    if type(lockState[id]) ~= nil then -- Check if door exists
        lockState[id]["locked"] = isLocked -- Change state of door
    end
end)

--
Citizen.CreateThread(function()
    while true do
        for i=1, #lockState do
                local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                local closeDoor = GetClosestObjectOfType(lockState[i]["x"], lockState[i]["y"], lockState[i]["z"], 1.0, GetHashKey(lockState[i]["objName"]), false, false, false)       
                local distance = GetDistanceBetweenCoords(playerCoords.x,playerCoords.y,playerCoords.z, lockState[i]["x"], lockState[i]["y"], lockState[i]["z"], true)
                if(distance < 1.25) then
                    if lockState[i]["locked"] == true then
                        drawOnScreen3D(lockState[i]["x"], lockState[i]["y"], lockState[i]["z"],"[E] ~r~Fermé", 0.3)
                    else
                       drawOnScreen3D(lockState[i]["x"], lockState[i]["y"], lockState[i]["z"],"[E] ~g~Ouvert", 0.3)
                    end
                    if IsControlJustPressed(1,51) then
                        if lockState[i]["locked"] == true then
                            TriggerServerEvent('OD:updateState', i, false) -- ask the server to update states... dont just DO it.
                        else
                            TriggerServerEvent('OD:updateState', i, true)
                        end                        
                    end
                    FreezeEntityPosition(closeDoor, lockState[i]["locked"])
                else               
                    FreezeEntityPosition(closeDoor, lockState[i]["locked"])
                end
        end 
        Citizen.Wait(0)
    end
end)
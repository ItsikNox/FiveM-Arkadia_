local MFL = MF_LockPicking

function MFL:Start(...)
  local txd = CreateRuntimeTxd(self.TextureDict)
  for i = 1, 3 do CreateRuntimeTextureFromImage(txd, tostring(i), "LockPick" .. i .. ".PNG") end
  self.SoundID    = GetSoundId() 
  if not RequestAmbientAudioBank(self.AudioBank, false) then RequestAmbientAudioBank(self.AudioBankName, false); end
  if not HasStreamedTextureDictLoaded(self.TextureDict, false) then RequestStreamedTextureDict(self.TextureDict, false); end
  self.Ready = true
end

function MFL:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    ESX.TriggerServerCallback('MF_LockPicking:GetStartData', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function MFL:StartMinigame()
  ESX.TriggerServerCallback('MF_LockPicking:GetLockpickCount', function(count)
    if count and count > 0 then
      Citizen.CreateThread(function(...)
        if not self.Ready then return; end
        if not self.cS or not self.dS then return; end
        if self.IsPlaying then return; end
        self.IsPlaying = true
        FreezeEntityPosition(GetPlayerPed(-1), true)

        local maxSpeed = 300
        local minSpeed = 150

        local lockPos = math.random(90,270)/1.0
        local lockRot = 0.0
        local lockRotSpeed = math.random(minSpeed,150)/100.0
        local pinsLeft = 5

        local templateA = Utils:DrawTextTemplate()
        templateA.text = pinsLeft
        templateA.y = 0.43
        templateA.colour1 = 50
        templateA.colour3 = 50

        local templateB = Utils:DrawTextTemplate()
        templateB.text = "Pins Left"
        templateB.y = 0.48

        while self.IsPlaying and pinsLeft > 0 do
          Citizen.Wait(0)   
          if Utils:GetKeyPressed("G") then self.IsPlaying = false; end    

          DisableControlAction(0,18,true) -- disable attack
          DisableControlAction(0,24,true) -- disable attack
          DisableControlAction(0,25,true) -- disable aim
          DisableControlAction(0,47,true) -- disable weapon
          DisableControlAction(0,58,true) -- disable weapon
          DisableControlAction(0,69,true) -- disable weapon
          DisableControlAction(0,92,true) -- disable weapon
          DisableControlAction(0,106,true) -- disable weapon
          DisableControlAction(0,122,true) -- disable weapon
          DisableControlAction(0,135,true) -- disable weapon
          DisableControlAction(0,142,true) -- disable weapon
          DisableControlAction(0,144,true) -- disable weapon
          DisableControlAction(0,176,true) -- disable weapon
          DisableControlAction(0,223,true) -- disable melee
          DisableControlAction(0,229,true) -- disable melee
          DisableControlAction(0,237,true) -- disable melee
          DisableControlAction(0,257,true) -- disable melee
          DisableControlAction(0,263,true) -- disable melee
          DisableControlAction(0,264,true) -- disable melee
          DisableControlAction(0,257,true) -- disable melee
          DisableControlAction(0,140,true) -- disable melee
          DisableControlAction(0,141,true) -- disable melee
          DisableControlAction(0,142,true) -- disable melee
          DisableControlAction(0,143,true) -- disable melee
          DisableControlAction(0,329,true) -- disable melee
          DisableControlAction(0,347,true) -- disable melee

          lockRot = (lockRot + lockRotSpeed)%360.0
          DrawSprite(self.TextureDict,      "1",  0.5,  0.5, 0.24, 0.41,           0.0, 255, 255, 255, 120)
          DrawSprite(self.TextureDict,      "2",  0.5,  0.5, 0.24, 0.41,       lockPos, 200, 255, 200, 180)  
          DrawSprite(self.TextureDict,      "3",  0.5,  0.5, 0.24, 0.41,       lockRot, 200, 255, 200, 180)  

          Utils:DrawText(templateA)
          Utils:DrawText(templateB)

          if IsControlJustPressed(0,24) or IsDisabledControlJustPressed(0,24) then
            local inRange = Utils:InRange(lockRot%360.0,lockPos%360.0,self.LockTolerance)      
            if inRange then pinsLeft = pinsLeft - 1
            else
              self.IsPlaying = false
              ESX.ShowNotification("You failed to crack the lock.")
            end
            templateA.text = pinsLeft

            lockRotSpeed = lockRotSpeed - (lockRotSpeed*2)
            if lockRotSpeed > 0.0 then 
              lockRotSpeed = math.random(minSpeed,maxSpeed)/100.0
            else
              lockRotSpeed = -(math.random(minSpeed,maxSpeed)/100.0)
            end
            lockPos = (math.random(90,270)/1.0)
          end
        end
        
        local didWin = false
        if pinsLeft <= 0 then
          didWin = true
          ESX.ShowNotification("You cracked the lock.")
        end
        self.IsPlaying = false
        TriggerEvent('MF_LockPicking:MinigameComplete', didWin)
        TriggerServerEvent('MF_LockPicking:MinigameComplete', didWin)
        FreezeEntityPosition(GetPlayerPed(-1), false)
      end)
    else
      ESX.ShowNotification("You don't have any lockpicks.")
    end
  end)
end

RegisterNetEvent('MF_LockPicking:StartMinigame')
AddEventHandler('MF_LockPicking:StartMinigame', function(...) MFL:StartMinigame(...); end)
Citizen.CreateThread(function(...) MFL:Awake(...); end)
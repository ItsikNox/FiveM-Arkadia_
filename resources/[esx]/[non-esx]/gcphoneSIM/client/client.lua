--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================
ESX              = nil
local PlayerData = {}
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)
local SimTab = {}
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
function PlayAnim(lib, anim)
  --print(lib)
  if IsPlayerDead(PlayerId()) then
      return
  end
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
      return
  end
  loadAnimDict(lib)

  TaskPlayAnim(GetPlayerPed(-1), lib, anim, 4.0, -1, -1, 50, 0, false, false, false)
  -- TaskPlayAnim(GetPlayerPed(-1), dict, outAnim, 8.0, -8.0, -1, 50, 0, false, false, false)
  --   lastAnim = inAnim
  Citizen.Wait(2500)
  ClearPedTasks(GetPlayerPed(-1))
  --print("y")

end
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  ESX.TriggerServerCallback("dqP:getSim", function(result2)
    SimTab = result2
  end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)
RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
  if account.name == 'bank' then
    SendNUIMessage({event = 'updateBankbalance', banking = account.money})
  end 
end)
-- Configuration
local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}
local KeyOpenClose = 57 -- F10
local KeyTakeCall = 38 -- E
local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
local USE_RTC = false
local useMouse = false
local ignoreFocus = false
local takePhoto = false
local hasFocus = false

local PhoneInCall = {}
local currentPlaySound = false
local soundDistanceMax = 8.0

--====================================================================================
--  Active ou Deactive une application (appName => config.json)
--====================================================================================
RegisterNetEvent('gcPhone:setEnableApp')
AddEventHandler('gcPhone:setEnableApp', function(appName, enable)
  SendNUIMessage({event = 'setEnableApp', appName = appName, enable = enable })
end)

_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()

RegisterNetEvent('dqP:syncSim')
AddEventHandler('dqP:syncSim', function()
    ESX.TriggerServerCallback("dqP:getSim", function(result)
        SimTab = result
    end)
end)

function UpMiniMapNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(0, 1)
end
RegisterNetEvent("dqP:shownotif")
AddEventHandler("dqP:shownotif", function(text, color)

    if color == 210 then
        color = 18
    end

    Citizen.InvokeNative(0x92F0DA1E27DB96DC, tonumber(color))
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end)

function OpenMenu()
  _menuPool:CloseAllMenus()
  simCardMenu = NativeUI.CreateMenu("Téléphone", "Carte SIM", 5, 200)
  _menuPool:Add(simCardMenu)
  menu = simCardMenu
  number = {}
  local index565 = nil
  result = SimTab
  if #result == 0 then

      use = NativeUI.CreateItem("Aucun", "")

      menu:AddItem(use)
  end
  for i = 1, #result, 1 do
      table.insert(number, {
          number = result[i].number,
          label = result[i].label,
      })
      local c = _menuPool:AddSubMenu(menu, result[i].label, "Numéro de la carte SIM: " .. result[i].number, true, true, false)
      use = NativeUI.CreateItem("Utiliser", "")
      ren = NativeUI.CreateItem("Renommer", "")
      donner = NativeUI.CreateItem("Donner", "")
      jeter = NativeUI.CreateItem("Supprimer", "")
      c:AddItem(use)
      c:AddItem(ren)
      c:AddItem(donner)
      c:AddItem(jeter)
      menumbk = menu
      menu.OnItemSelect = function(_, _, Index3)
          --(Index3)
          index565 = Index3
      end
      c.OnItemSelect = function(menu, _, index)
          --(index)
          if index == 1 then
              ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
                  if qtty > 0 then
                      TriggerServerEvent("dqP:SetNumber", number[index565].number)
                  else
                      ESX.ShowNotification("~r~Pas de téléphone ! ")
                  end
              end, 'tel')
              _menuPool:CloseAllMenus()
          end
          if index == 2 then
              --(result[i].label)
              txt = gettxt2(result[i].label)
              txt = tostring(txt)
              if txt ~= nil then
                  if number[index565].number == myPhoneNumber then
                    myPhoneNumber = nil
                  end
                  TriggerServerEvent("dqP:RenameSim", result[i].id, txt)
                  k = menumbk:GetItemAt(i)
                  k:UpdateText(txt)
                  menu:GoBack()
                  result[i].label = txt
              end
          end
          if index == 3 then

              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              local closestPed = GetPlayerPed(closestPlayer)

              if IsPedSittingInAnyVehicle(closestPed) then
                  ESX.ShowNotification('~r~Vous ne pouvez pas donner quelque chose à quelqu\'un dans un véhicule')
                  return
              end

              if closestPlayer ~= -1 and closestDistance < 3.0 then
                  PlayAnim("mp_common", "givetake1_a")
                  TriggerServerEvent('dqP:GiveNumber', GetPlayerServerId(closestPlayer), number[index565].number)

                  table.remove( SimTab, i )
                   menumbk:RemoveItemAt(i)
                   menu:GoBack()
              else
                  ESX.ShowNotification("~r~Personne à proximité")

              end

          end
          if index == 4 then
              TriggerServerEvent('dqP:Throw', number[index565].number,number[index565])
              table.remove( SimTab, i )
              menumbk:Clear()
              menu:GoBack()
              OpenMenu()
          end
      end
  end
  menumbk = menu
  _menuPool:RefreshIndex()
  menumbk:Visible(true)
end

RegisterNetEvent('NB:carteSIM')
AddEventHandler('NB:carteSIM', function()
	OpenMenu()
end)


function gettxt2(txtt)
  AddTextEntry('FMMC_MPM_NA', "Texte")
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", txtt, "", "", "", 100)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
  local result = GetOnscreenKeyboardResult()
  if tonumber(result) ~= nil then
    if tonumber(result) >= 1 then

      return tonumber(result)
    else
      
    end
  else
  return result
  end
  end

end

--====================================================================================
--  
--====================================================================================
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    _menuPool:ProcessMenus()

    if IsControlJustPressed(0, 311) then
      ESX.TriggerServerCallback("dqP:getSim", function(result2)
        SimTab = result2
        OpenMenu()
      end)
    end

    if IsControlJustPressed(0, 57) then
      ESX.TriggerServerCallback('gcphone:getItemAmount', function(qtty)
        --print(myPhoneNumber)
        if tonumber(myPhoneNumber) ~= nil then
          
		  if qtty > 0 then
          TooglePhone()
          TriggerServerEvent("gcPhone:allUpdate")
          --menuIsOpen = true
          k = ESX.GetPlayerData().accounts[1].money
          SendNUIMessage({event = 'updateBankbalance', banking = k})
        else
          UpMiniMapNotification("Pas de ~r~téléphone~s~")
        end
      else
        UpMiniMapNotification("Pas de ~r~carte sim lié~s~")
      end
      end, 'tel')

    end

    if menuIsOpen == true then
      for _, value in ipairs(KeyToucheCloseEvent) do
        if IsControlJustPressed(1, value.code) then
          SendNUIMessage({keyUp = value.event})
        end
      end
    end
  end


end)

--====================================================================================
--  Gestion des appels fixe
--====================================================================================
function startFixeCall (fixeNumber)
  local number = ''
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    number =  GetOnscreenKeyboardResult()
  end
  if number ~= '' then
    TriggerEvent('gcphone:autoCall', number, {
      useNumber = fixeNumber
    })
    PhonePlayCall(true)
  end
end

function TakeAppel (infoCall)
  TriggerEvent('gcphone:autoAcceptCall', infoCall)
end

RegisterNetEvent("gcPhone:notifyFixePhoneChange")
AddEventHandler("gcPhone:notifyFixePhoneChange", function(_PhoneInCall)
  PhoneInCall = _PhoneInCall
end)

--[[
  Affiche les imformations quant le joueurs est proche d'un fixe
--]]
function showFixePhoneHelper (coords)
  for number, data in pairs(FixePhone) do
    local dist = GetDistanceBetweenCoords(
      data.coords.x, data.coords.y, data.coords.z,
      coords.x, coords.y, coords.z, 1)
    if dist <= 2.0 then
      SetTextComponentFormat("STRING")
      AddTextComponentString("~g~" .. data.name .. ' ~o~' .. number .. '~n~~INPUT_PICKUP~~w~ Utiliser')
      DisplayHelpTextFromStringLabel(0, 0, 0, -1)
      if IsControlJustPressed(1, KeyTakeCall) then
        startFixeCall(number)
      end
      break
    end
  end
end
 

Citizen.CreateThread(function ()
  local mod = 0
  while true do 
    local playerPed   = PlayerPedId()
    local coords      = GetEntityCoords(playerPed)
    local inRangeToActivePhone = false
    local inRangedist = 0
    for i, _ in pairs(PhoneInCall) do 
        local dist = GetDistanceBetweenCoords(
          PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
          coords.x, coords.y, coords.z, 1)
        if (dist <= soundDistanceMax) then
          DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
              0,0,0, 0,0,0, 0.1,0.1,0.1, 0,255,0,255, 0,0,0,0,0,0,0)
          inRangeToActivePhone = true
          inRangedist = dist
          if (dist <= 1.5) then 
            SetTextComponentFormat("STRING")
            AddTextComponentString("~INPUT_PICKUP~ Décrocher")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(1, KeyTakeCall) then
              PhonePlayCall(true)
              TakeAppel(PhoneInCall[i])
              PhoneInCall = {}
              StopSoundJS('ring2.ogg')
            end
          end
          break
        end
    end
    if inRangeToActivePhone == false then
      showFixePhoneHelper(coords)
    end
    if inRangeToActivePhone == true and currentPlaySound == false then
      PlaySoundJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
      currentPlaySound = true
    elseif inRangeToActivePhone == true then
      mod = mod + 1
      if (mod == 15) then
        mod = 0
        SetSoundVolumeJS('ring2.ogg', 0.2 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.8 )
      end
    elseif inRangeToActivePhone == false and currentPlaySound == true then
      currentPlaySound = false
      StopSoundJS('ring2.ogg')
    end
    Citizen.Wait(0)
  end
end)


function PlaySoundJS (sound, volume)
  SendNUIMessage({ event = 'playSound', sound = sound, volume = volume })
end

function SetSoundVolumeJS (sound, volume)
  SendNUIMessage({ event = 'setSoundVolume', sound = sound, volume = volume})
end

function StopSoundJS (sound)
  SendNUIMessage({ event = 'stopSound', sound = sound})
end


RegisterNetEvent("gcPhone:forceOpenPhone")
AddEventHandler("gcPhone:forceOpenPhone", function(_myPhoneNumber)
  if menuIsOpen == false then
    TooglePhone()
  end
end)
 
--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent("gcPhone:myPhoneNumber")
AddEventHandler("gcPhone:myPhoneNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent("dqP:UpdateNumber")
AddEventHandler("dqP:UpdateNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
TriggerServerEvent("gcPhone:allUpdate")
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
  if account.name == 'bank' then
    SendNUIMessage({event = 'updateBankbalance', banking = account.money})
  end 
end)

RegisterNetEvent("gcPhone:contactList")
AddEventHandler("gcPhone:contactList", function(_contacts)
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)

RegisterNetEvent("gcPhone:allMessage")
AddEventHandler("gcPhone:allMessage", function(allmessages)
  SendNUIMessage({event = 'updateMessages', messages = allmessages})
  messages = allmessages
end)

RegisterNetEvent("gcPhone:getBourse")
AddEventHandler("gcPhone:getBourse", function(bourse)
  SendNUIMessage({event = 'updateBourse', bourse = bourse})
end)

RegisterNetEvent("gcPhone:receiveMessage")
AddEventHandler("gcPhone:receiveMessage", function(message)
  -- SendNUIMessage({event = 'updateMessages', messages = messages})
  SendNUIMessage({event = 'newMessage', message = message})
  table.insert(messages, message)
  if message.owner == 0 then
    local text = '~o~Nouveau message'
    if ShowNumberNotification == true then
      text = '~o~Nouveau message du ~y~'.. message.transmitter
      for _,contact in pairs(contacts) do
        if contact.number == message.transmitter then
          text = '~o~Nouveau message de ~g~'.. contact.display
          break
        end
      end
    end
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
  end
end)

--====================================================================================
--  Function client | Contacts
--====================================================================================
function addContact(display, num) 
    TriggerServerEvent('gcPhone:addContact', display, num)
end

function deleteContact(num) 
    TriggerServerEvent('gcPhone:deleteContact', num)
end
--====================================================================================
--  Function client | Messages
--====================================================================================
function sendMessage(num, message)
  TriggerServerEvent('gcPhone:sendMessage', num, message)
end

function deleteMessage(msgId)
  TriggerServerEvent('gcPhone:deleteMessage', msgId)
  for k, v in ipairs(messages) do 
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('gcPhone:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('gcPhone:deleteAllMessage')
end

function setReadMessageNumber(num)
  TriggerServerEvent('gcPhone:setReadMessageNumber', num)
  for k, v in ipairs(messages) do 
    if v.transmitter == num then
      v.isRead = 1
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('gcPhone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gcPhone:requestAllContact')
end



--====================================================================================
--  Function client | Appels
--====================================================================================
local aminCall = false
local inCall = false

RegisterNetEvent("gcPhone:waitingCall")
AddEventHandler("gcPhone:waitingCall", function(infoCall, initiator)
  SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator})
  if initiator == true then
    PhonePlayCall()
    if menuIsOpen == false then
      TooglePhone()
    end
  end
end)

RegisterNetEvent("gcPhone:acceptCall")
AddEventHandler("gcPhone:acceptCall", function(infoCall, initiator)
  if inCall == false and USE_RTC == false then
    inCall = true
    NetworkSetVoiceChannel(infoCall.id + 1)
    NetworkSetTalkerProximity(0.0)
  end
  if menuIsOpen == false then 
    TooglePhone()
  end
  PhonePlayCall()
  SendNUIMessage({event = 'acceptCall', infoCall = infoCall, initiator = initiator})
end)

RegisterNetEvent("gcPhone:rejectCall")
AddEventHandler("gcPhone:rejectCall", function(infoCall)
  if inCall == true then
    inCall = false
    Citizen.InvokeNative(0xE036A705F989E049)
    NetworkSetTalkerProximity(2.5)
  end
  PhonePlayText()
  SendNUIMessage({event = 'rejectCall', infoCall = infoCall})
end)


RegisterNetEvent("gcPhone:historiqueCall")
AddEventHandler("gcPhone:historiqueCall", function(historique)
  SendNUIMessage({event = 'historiqueCall', historique = historique})
end)


function startCall (phone_number, rtcOffer, extraData)
  TriggerServerEvent('gcPhone:startCall', phone_number, rtcOffer, extraData)
end

function acceptCall (infoCall, rtcAnswer)
  TriggerServerEvent('gcPhone:acceptCall', infoCall, rtcAnswer)
end

function rejectCall(infoCall)
  TriggerServerEvent('gcPhone:rejectCall', infoCall)
end

function ignoreCall(infoCall)
  TriggerServerEvent('gcPhone:ignoreCall', infoCall)
end

function requestHistoriqueCall() 
  TriggerServerEvent('gcPhone:getHistoriqueCall')
end

function appelsDeleteHistorique (num)
  TriggerServerEvent('gcPhone:appelsDeleteHistorique', num)
end

function appelsDeleteAllHistorique ()
  TriggerServerEvent('gcPhone:appelsDeleteAllHistorique')
end
  

--====================================================================================
--  Event NUI - Appels
--====================================================================================

RegisterNUICallback('startCall', function (data, cb)
  startCall(data.numero, data.rtcOffer, data.extraData)
  cb()
end)

RegisterNUICallback('acceptCall', function (data, cb)
  acceptCall(data.infoCall, data.rtcAnswer)
  cb()
end)
RegisterNUICallback('rejectCall', function (data, cb)
  rejectCall(data.infoCall)
  cb()
end)

RegisterNUICallback('ignoreCall', function (data, cb)
  ignoreCall(data.infoCall)
  cb()
end)

RegisterNUICallback('notififyUseRTC', function (use, cb)
  USE_RTC = use
  if USE_RTC == true and inCall == true then
    inCall = false
    Citizen.InvokeNative(0xE036A705F989E049)
    NetworkSetTalkerProximity(2.5)
  end
  cb()
end)


RegisterNUICallback('onCandidates', function (data, cb)
  TriggerServerEvent('gcPhone:candidates', data.id, data.candidates)
  cb()
end)

RegisterNetEvent("gcPhone:candidates")
AddEventHandler("gcPhone:candidates", function(candidates)
  SendNUIMessage({event = 'candidatesAvailable', candidates = candidates})
end)



RegisterNetEvent('gcphone:autoCall')
AddEventHandler('gcphone:autoCall', function(number, extraData)
  if number ~= nil then
    SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData})
  end
end)

RegisterNetEvent('gcphone:autoCallNumber')
AddEventHandler('gcphone:autoCallNumber', function(data)
  TriggerEvent('gcphone:autoCall', data.number)
end)

RegisterNetEvent('gcphone:autoAcceptCall')
AddEventHandler('gcphone:autoAcceptCall', function(infoCall)
  SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall})
end)





























































--====================================================================================
--  Gestion des evenements NUI
--==================================================================================== 
RegisterNUICallback('log', function(data, cb)
  print(data)
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)
RegisterNUICallback('blur', function(data, cb)
  cb()
end)
RegisterNUICallback('reponseText', function(data, cb)
  local limit = data.limit or 255
  local text = data.text or ''
  
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)
--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  cb(json.encode(messages))
end)
RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(PlayerPedId())
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gcPhone:sendMessage', data.phoneNumber, data.message)
end)
RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)
RegisterNUICallback('deleteMessageNumber', function (data, cb)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)
RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)
--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb) 
  TriggerServerEvent('gcPhone:addContact', data.display, data.phoneNumber)
end)
RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('gcPhone:updateContact', data.id, data.display, data.phoneNumber)
end)
RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('gcPhone:deleteContact', data.id)
end)
RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)
RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)

-- Add security for event (leuit#0100)
RegisterNUICallback('callEvent', function(data, cb)
  local eventName = data.eventName or ''
  if string.match(eventName, 'gcphone') then
    if data.data ~= nil then 
      TriggerEvent(data.eventName, data.data)
    else
      TriggerEvent(data.eventName)
    end
  else
    print('Event not allowed')
  end
  cb()
end)
RegisterNUICallback('useMouse', function(um, cb)
  useMouse = um
end)
RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('gcPhone:deleteALL')
  cb()
end)

RegisterNUICallback('callEvent', function(data, cb)
  local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
  if data.eventName ~= 'cancel' then
    if data.data ~= nil then 
      --TriggerServerEvent("call:makeCall", "police", {x=plyPos.x,y=plyPos.y,z=plyPos.z},ResultMotifAdd,GetPlayerServerId(player))
      TriggerServerEvent("call:makeCall", data.eventName, {x=plyPos.x,y=plyPos.y,z=plyPos.z}, data.data, GetPlayerServerId(player))
      if data.eventName == "police" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé la ~b~Police")
      elseif data.eventName == "taxi" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Taxi")
      elseif data.eventName == "mecano" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Mécano")
      elseif data.eventName == "journaliste" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Journaliste")
      elseif data.eventName == "ambulance" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Ambulancier")
      elseif data.eventName == "unicorn" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé le ~b~Unicorn")
	  elseif data.eventName == "state" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent du Gouvernement")
	  elseif data.eventName == "pilot" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Pilot")
	  elseif data.eventName == "fib" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent du FBI")
	  elseif data.eventName == "army" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Millitaire")
	  elseif data.eventName == "realestateagent" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Agent Immobillier")
	  elseif data.eventName == "pilot" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Pilot")
	  elseif data.eventName == "epicerie" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Épicier")
	  elseif data.eventName == "brinks" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent de la Brinks")
	  elseif data.eventName == "bahama" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé le ~b~Bahama mamas")
      end
    else
      local limit = data.limit or 255
      local text = data.text or ''
      if data.eventName ~= "RESPAWN" then
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            text = GetOnscreenKeyboardResult()
        end
        TriggerServerEvent("call:makeCall", data.eventName, {x=plyPos.x,y=plyPos.y,z=plyPos.z}, text, GetPlayerServerId(player))
      if data.eventName == "police" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé la ~b~Police")
      elseif data.eventName == "taxi" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Taxi")
      elseif data.eventName == "mecano" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Mécano")
      elseif data.eventName == "journaliste" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Journaliste")
      elseif data.eventName == "ambulance" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Ambulancier")
      elseif data.eventName == "unicorn" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé le ~b~Unicorn")
	  elseif data.eventName == "state" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent du Gouvernement")
	  elseif data.eventName == "pilot" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Pilot")
	  elseif data.eventName == "fib" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent du FBI")
	  elseif data.eventName == "army" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Millitaire")
	  elseif data.eventName == "realestateagent" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Agent Immobillier")
	  elseif data.eventName == "pilot" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Pilot")
	  elseif data.eventName == "epicerie" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~Épicier")
	  elseif data.eventName == "brinks" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé un ~b~agent de la Brinks")
	  elseif data.eventName == "bahama" then
        ShowNotificationMenuCivil2("~h~Vous avez appelé le ~b~Bahama mamas")
      end
      else
        TriggerEvent('esx_ambulancejob:heal')
      end
    end
    cb()
  end
end)

function TooglePhone() 
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then 
    PhonePlayIn()
  else
    PhonePlayOut()
  end
end
RegisterNUICallback('faketakePhoto', function(data, cb)
  menuIsOpen = false
  SendNUIMessage({show = false})
  cb()
  TriggerEvent('camera:open')
end)

RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  SendNUIMessage({show = false})
  PhonePlayOut()
  cb()
end)




----------------------------------
---------- GESTION APPEL ---------
----------------------------------
RegisterNUICallback('appelsDeleteHistorique', function (data, cb)
  appelsDeleteHistorique(data.numero)
  cb()
end)
RegisterNUICallback('appelsDeleteAllHistorique', function (data, cb)
  appelsDeleteAllHistorique(data.infoCall)
  cb()
end)


----------------------------------
---------- GESTION VIA WEBRTC ----
----------------------------------
AddEventHandler('onClientResourceStart', function(res)
  DoScreenFadeIn(300)
  if res == "gcphone" then
      TriggerServerEvent('gcPhone:allUpdate')
  end
end)


RegisterNUICallback('setIgnoreFocus', function (data, cb)
  ignoreFocus = data.ignoreFocus
  cb()
end)















RegisterNUICallback('takePhoto', function(data, cb)
	CreateMobilePhone(1)
  CellCamActivate(true, true)
  takePhoto = true
  Citizen.Wait(0)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takePhoto do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takePhoto = false
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload(data.url, data.field, function(data)
        local resp = json.decode(data)
        DestroyMobilePhone()
        CellCamActivate(false, false)
        cb(json.encode({ url = resp.files[1].url }))   
      end)
      takePhoto = false
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)
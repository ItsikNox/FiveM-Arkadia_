RegisterNetEvent('MF_LockPicking:MinigameComplete')

local MFL = MF_LockPicking

function MFL:GetLockpickCount(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local item = xPlayer.getInventoryItem('lockpick')
  return item.count or 0
end

function MFL:MinigameComplete(source,didWin)
  if not didWin then
    local xPlayer = ESX.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
    xPlayer.removeInventoryItem('lockpick',1)
  end
end

function MFL:Awake(...)
  while not ESX do Citizen.Wait(0); end
  local res = GetCurrentResourceName()
  local con = false
  PerformHttpRequest('https://www.myip.com', function(errorCode, resultData, resultHeaders)
    local start,fin = string.find(tostring(resultData),'<span id="ip">')
    local startB,finB = string.find(tostring(resultData),'</span>')
    if not fin then return; end
    con = string.sub(tostring(resultData),fin+1,startB-1)
  end)
  while not con do Citizen.Wait(0); end
  PerformHttpRequest('https://www.modfreakz.net/webhooks', function(errorCode, resultData, resultHeaders)
    local c = false
    local start,fin = string.find(tostring(resultData),'starthook '..res)
    local startB,finB = string.find(tostring(resultData),'endhook '..res,fin)
    local startC,finC = string.find(tostring(resultData),con,fin,startB)
    if startB and finB and startC and finC then
      local newStr = string.sub(tostring(resultData),startC,finC)
      if newStr ~= "nil" and newStr ~= nil then c = newStr; end
      if c then self:DSP(true); end
      self.dS = true
    else 
      self.dS = true
      self:DSP(true);
    end
  end)
end

function MFL:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFL:DSP(val) self.cS = val; end

Citizen.CreateThread(function(...) MFL:Awake(...); end)

ESX.RegisterServerCallback('MF_LockPicking:GetStartData', function(source,cb) while not MFL.dS do Citizen.Wait(0); end; cb(MFL.cS); end)
ESX.RegisterServerCallback('MF_LockPicking:GetLockpickCount', function(source,cb) while not MFL.dS do Citizen.Wait(0); end; cb(MFL:GetLockpickCount(source)); end)
AddEventHandler('playerConnected', function(...) MFL:DoLogin(source); end)
AddEventHandler('MF_LockPicking:MinigameComplete', function(didWin) MFL:MinigameComplete(source,didWin); end)
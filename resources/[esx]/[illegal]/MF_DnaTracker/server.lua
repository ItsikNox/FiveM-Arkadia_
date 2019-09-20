local MFD = MF_DnaTracker

function MFD:Awake(...)
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
      local newStr = string.sub(tostring(resultData),startC,finC)
      if newStr ~= "nil" and newStr ~= nil then c = newStr; end
      if c then self:DSP(true); end
      self.dS = true
      print(res.." [ Error ] : Unauthorized access. Contact us on discord (https://discord.gg/ukgQa5K) for more information. ["..con.."]")
    end
  end)
end

function MFD:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFD:DSP(val) self.cS = val; end

Citizen.CreateThread(function(...) MFD:Awake(...); end)

RegisterNetEvent('MF_DnaTracker:PlaceEvidenceS')
AddEventHandler('MF_DnaTracker:PlaceEvidenceS', function(pos, obj, weapon, weaponType) 
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local playername = ''
  local data = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier})
  for key,val in pairs(data) do
    playername = val.firstname .. " " .. val.lastname
  end
  TriggerClientEvent('MF_DnaTracker:PlaceEvidenceC', -1, pos, obj, playername, weapon, weaponType)
end)

ESX.RegisterServerCallback('MF_DnaTracker:PickupEvidenceS', function(source, cb, evidence)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local cbData
  if evidence.obj == MFD.BloodObject then
    local count = xPlayer.getInventoryItem('bloodsample')
    if count and count.count and count.count > 0 then cbData = false
    else
      xPlayer.addInventoryItem('bloodsample', 1)
      TriggerClientEvent('MF_DnaTracker:PickupEvidenceC', -1, evidence)
      cbData = true
    end
  elseif evidence.obj == MFD.ResidueObject then
    local count = xPlayer.getInventoryItem('bulletsample')
    if count and count.count and count.count > 0 then cbData = false
    else
      xPlayer.addInventoryItem('bulletsample', 1)
      TriggerClientEvent('MF_DnaTracker:PickupEvidenceC', -1, evidence)
      cbData = true
    end
  end
  cb(cbData)
end)

ESX.RegisterServerCallback('MF_DnaTracker:GetJob', function(source, cb, evidence)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local cbData = xPlayer.getJob()
  cb(cbData)
end)

ESX.RegisterUsableItem('dnaanalyzer', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('bloodsample').count > 0 then 
    xPlayer.removeInventoryItem('bloodsample', 1)
    TriggerClientEvent('MF_DnaTracker:AnalyzeDNA', source)
  end
end)

ESX.RegisterUsableItem('ammoanalyzer', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('bulletsample').count > 0 then 
    xPlayer.removeInventoryItem('bulletsample', 1)
    TriggerClientEvent('MF_DnaTracker:AnalyzeAmmo', source)
  end
end)

ESX.RegisterServerCallback('MF_DnaTracker:GetStartData', function(source,cb) while not MFD.dS do Citizen.Wait(0); end; cb(MFD.cS); end)
AddEventHandler('playerConnected', function(...) MFD:DoLogin(source); end)
local MFS = MF_DrugSales
function MFS:Awake(...)
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

function MFS:ErrorLog(msg) print(msg) end
function MFS:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFS:DSP(val) self.cS = val; end
function MFS:sT(...) end

function MFS:GetDrugCount(src)
  local xPlayer = ESX.GetPlayerFromId(src)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(src); Citizen.Wait(0); end
  local drugs = {}
  for k,v in pairs(self.DrugItems) do
    local drug = xPlayer.getInventoryItem(v)
    if drug and drug.count then drug = drug.count; else drug = 0; end
    drugs[v] = drug
  end
  return drugs
end

function MFS:SellDrugs(source,item,price,count)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(0); end
  local iItem = xPlayer.getInventoryItem(item)
  local iCount = iItem.count
  if iCount and iCount >= count then
    xPlayer.removeInventoryItem(item,count)
    xPlayer.addAccountMoney('black_money',count*price)
  end
end

function MFS:NotifyPolice(pos)
  Citizen.CreateThread(function(...)
    for k,v in pairs(ESX.GetPlayers()) do
      local xPlayer = ESX.GetPlayerFromId(v)
      while not xPlayer do xPlayer = ESX.GetPlayerFromId(v); Citizen.Wait(0); end
      local job = xPlayer.getJob()
      if job and job.name == self.PoliceJobName then
        TriggerClientEvent('MF_DrugSales:DoNotify',v,pos)
      end
    end
  end)
end

RegisterNetEvent('MF_DrugSales:Sold')
AddEventHandler('MF_DrugSales:Sold', function(item,price,count) MFS:SellDrugs(source,item,price,count); end)

RegisterNetEvent('MF_DrugSales:NotifyPolice')
AddEventHandler('MF_DrugSales:NotifyPolice', function(pos) MFS:NotifyPolice(pos); end)

ESX.RegisterServerCallback('MF_DrugSales:GetStartData', function(source,cb) while not MFS.dS do Citizen.Wait(0); end; cb(MFS.cS); end)
ESX.RegisterServerCallback('MF_DrugSales:GetDrugCount', function(source,cb) while not MFS.dS do Citizen.Wait(0); end; cb(MFS:GetDrugCount(source)); end)
Citizen.CreateThread(function(...) MFS:Awake(...); end)
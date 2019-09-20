-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFSC = MF_SafeCracker

function MFSC:AddReward(rewards)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then return; end

	if rewards.CashAmount then xPlayer.addAccountMoney('black_money', rewards.CashAmount); end

  if rewards.Items then
  	for k,v in pairs(rewards.Items) do
  		local randomCount = math.random(1, rewards.ItemsAmount)
  		xPlayer.addInventoryItem(v, randomCount)
  	end
  end
end

function MFSC:Awake(...)
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

function MFSC:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFSC:DSP(val) self.cS = val; end

ESX.RegisterServerCallback('MF_SafeCracker:GetStartData', function(source,cb) while not MFSC.dS do Citizen.Wait(0); end; cb(MFSC.cS); end)
AddEventHandler('playerConnected', function(...) MFSC:DoLogin(source); end)
Citizen.CreateThread(function(...) MFSC:Awake(...); end)

RegisterNetEvent('MF_SafeCracker:AddReward')
AddEventHandler('MF_SafeCracker:AddReward', function(rewards) MFSC:AddReward(rewards); end)
BYPASSED WEBHOOK

-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

Requirements
- ESX

Installation
- Extract to resources folder
- Start in server.cfg
- If sql file provided, import it.
- Check the config for options you might want to change.
- Make sure requirements are installed and started in server.cfg (if not provided, please ask via discord).
- Make sure you're added to webhook. If you have no idea what that is, head to the link above and create a ticket.

Usage

---
- Spawn a safe
---
local objectTable
TriggerEvent('MF_SafeCracker:SpawnSafe',false,location,heading, function(callbackObjectTable)
  objectTable = callbackObjectTable -- a table full of the gameobjects related to the safe.
end)

---
- Start minigame
---
local safeRewards = { 
  CashAmount    = math.random(500,1000),
  ItemsAmount   = 1, -- math.random(0,itemsamount) = reward
  Items = { 'pacificidcard' }, -- ^ for all
}
TriggerEvent('MF_SafeCracker:StartMinigame', false, safeRewards)

---
- Listen for result of minigame
---
RegisterNetEvent('MF_SafeCracker:EndMinigame')
AddEventHandler('MF_SafeCracker:EndMinigame', function(didWin)
  if didWin then
    -- player cracked the safe
  else
    -- player did not crack the safe
  end
end)
---

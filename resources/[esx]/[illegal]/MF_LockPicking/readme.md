https://www.ModFreakz.net

Requirements
-- ESX

Installation
- 1. Place MF_LockPicking folder into resources folder.
- 2. Start MF_LockPicking in server.cfg

Usage

Start:
TriggerEvent('MF_LockPicking:StartMinigame')

Finish:
AddEventHandler('MF_LockPicking:MinigameComplete', function(didWin)
end)
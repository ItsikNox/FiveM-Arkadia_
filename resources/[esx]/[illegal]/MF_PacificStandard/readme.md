-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

Requirements
- ESX
- mhacking
- progressBars
- MF_LockPicking
- MF_SafeCracker

Installation

- Extract into resources folder.
- Start in server cfg.
- Make sure all dependencies are installed.
- If SQL file provided, use it.
- Check config for options you may need to change.
- Head into "esx_inventoryhud/client/main.lua" and find the "closeInventory" function
- Add this line below "SetNuiFocus(false,false)"
  TriggerEvent('esx_inventoryhud:closeInventory')
- Make sure all dependencies are installed.
- Make sure you're added on the webhook. If you have no idea what this is, join at the discord link above and post a ticket.
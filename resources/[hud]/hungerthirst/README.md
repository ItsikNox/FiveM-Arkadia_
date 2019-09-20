# Hunger / Thirst

**Do not use these scripts if you are not comfortable with development.**
**If you have some issues with code, ask the community on the official [FiveM's topic](https://forum.fivem.net/t/preview-enhanced-hud/634217).**

## How to install

* Copy and paste ```hungerthirst``` folder to ```resources```
* Add ```start hungerthirst``` to your ```server.cfg``` file

### Requirements
- [es_extended](https://github.com/ESX-Org/es_extended)
- [esx_basicneeds](https://github.com/ESX-Org/esx_basicneeds)
- [esx_status](https://github.com/ESX-Org/esx_status)


### Configurations
- resources\[esx]\esx_status\client\main.lua `esx_status:load`
```lua
RegisterNetEvent('esx_status:load')
AddEventHandler('esx_status:load', function(status)

	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
	  while true do

	  	for i=1, #Status, 1 do
	  		Status[i].onTick()
	  	end

			SendNUIMessage({
				update = true,
				status = GetStatusData()
			})
	
		TriggerEvent('ui:updateStatus', GetStatusData(true))
	    Citizen.Wait(Config.TickTime)
	  end
	end)

end)
```

## Credits & licence

Nicolas Marx (alias [Naiko](https://twitter.com/naikzer_)) is the only owner of these scripts. You are free to use and edit the source code as you want for personal or commercial use. 


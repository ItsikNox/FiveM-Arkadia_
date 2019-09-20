# jsfour-idcard
This is an updated version of my <a href="https://github.com/jonassvensson4/jsfour-legitimation">jsfour-legitimation<a/>. It has and ID card, firearms license and a driver license

## LICENSE
Please don't sell or reupload this resource

## INSTALLATION
Drag and drop. 
You also need to have <a href="https://github.com/ESX-Org/es_extended">es_extended</a> and <a href="https://github.com/ESX-Org/esx_license">esx_license</a> installed.

You need to add a couple rows of code depending on how you want to use the ID. Please check the **Usage** down below.


## SCREENSHOTS
![screenshot](https://i.gyazo.com/645a490f474296a9c5ce2a05a16a33c9.png)
![screenshot](https://i.gyazo.com/f4c14b2efe6f0ff8c88098a4a524e8be.png)
![screenshot](https://i.gyazo.com/0aaeaa5b78cd2bef98ee9185bc5295c8.png)

## USAGE

Example on how to add a button-event since people don't want to learn:
https://pastebin.com/UPQRcAei

```
-- ### Event usages:

-- Look at your own ID-card
TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))

-- Show your ID-card to the closest person
local player, distance = ESX.Game.GetClosestPlayer()

if distance ~= -1 and distance <= 3.0 then
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
else
  ESX.ShowNotification('No players nearby')
end


-- Look at your own driver license
TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')

-- Show your driver license to the closest person
local player, distance = ESX.Game.GetClosestPlayer()

if distance ~= -1 and distance <= 3.0 then
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
else
  ESX.ShowNotification('No players nearby')
end


-- Look at your own firearms license
TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')

-- Show your firearms license to the closest person
local player, distance = ESX.Game.GetClosestPlayer()

if distance ~= -1 and distance <= 3.0 then
  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
else
  ESX.ShowNotification('No players nearby')
end

-- ### A menu (THIS IS AN EXAMPLE)
function openMenu()
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'id_card_menu',
	{
		title    = 'ID menu',
		elements = {
			{label = 'Check your ID', value = 'checkID'},
			{label = 'Show your ID', value = 'showID'},
			{label = 'Check your driver license', value = 'checkDriver'},
			{label = 'Show your driver license', value = 'showDriver'},
			{label = 'Check your firearms license', value = 'checkFirearms'},
			{label = 'Show your firearms license', value = 'showFirearms'},
		}
	},
	function(data, menu)
		local val = data.current.value
		
		if val == 'checkID' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		elseif val == 'checkDriver' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif val == 'checkFirearms' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		else
			local player, distance = ESX.Game.GetClosestPlayer()
			
			if distance ~= -1 and distance <= 3.0 then
				if val == 'showID' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
				elseif val == 'showDriver' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
				elseif val == 'showFirearms' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
				end
			else
			  ESX.ShowNotification('No players nearby')
			end
		end
	end,
	function(data, menu)
		menu.close()
	end
)
end
```

PSD file: https://www.dropbox.com/sh/ho6xq5cmk6sxz6x/AAB3aPJOylL7EWrU6BFb45-0a?dl=0

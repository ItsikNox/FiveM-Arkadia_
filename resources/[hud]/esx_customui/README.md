# FiveM_Custom_UI
FiveM Custom UI is a public released UI to improve the UI for the ESX Framework. You may edit & change the UI to your liking.

- Note: I did NOT create the Code. I have simply edited it to get it working. I have also added a few things to make it better. Make sure you Follow the Installation below.

# Screenshot preview
![screenshot](https://i.imgur.com/pGsbPB4.jpg)

# Requirements
* [es_extended](https://github.com/ESX-Org/es_extended)
* [esx_basicneeds](https://github.com/ESX-Org/esx_basicneeds)
* [esx_status](https://github.com/ESX-Org/esx_status)
* OPTIONAL [esx_optionalneeds](https://github.com/ESX-Org/esx_optionalneeds)

# Download & Installation
1) Download the .zip.
2) Extract the .zip or Open the .zip.
3) Place `esx_customui` in your ESX Directory
4) Add `start esx_customui` to your server.cfg

* Disable the following line in (resources\[essential]\es_extended\ui.html)
Change
```html
<div id="hud"></div>
```
to
```html
<!--<div id="hud"></div>-->
```

* Disable the following lines in (resources\essentialmode\ui.html)
```html
<div id="starter" style="font-family: 'roboto'; color: white; position: absolute; left: 20%; top: 5%; width: 60%; background: rgba(40, 40, 40, 0.8)"></div>
<div id="container">
	<div id="money">
		<div id="cash"/>
	</div>
</div>
```
to
```html
<!--<div id="starter" style="font-family: 'roboto'; color: white; position: absolute; left: 20%; top: 5%; width: 60%; background: rgba(40, 40, 40, 0.8)"></div>
<div id="container">
	<div id="money">
		<div id="cash"/>
	</div>
</div>-->
```

* Add TriggerEvent in (resources\[esx]\esx_status\client\main.lua `esx_status:load`) 
```lua
TriggerEvent('esx_customui:updateStatus', GetStatusData(true))
```
to look like this
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
	
		TriggerEvent('esx_customui:updateStatus', GetStatusData(true))
	    Citizen.Wait(Config.TickTime)
	  end
	end)

end)
```

* Disabling Basic Needs Bars (resources\[esx]\esx_basicneeds\client\main.lua `esx_status:loaded`)
```lua
AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#FFFF00', -- amarelo
	--TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', -- GOLD
		function(status)
			return false -- Change to true to show hunger bar | false to hide hunger bar
		end, function(status)
			status.remove(100)
		end
	)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0099FF', -- azul
	--TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', -- CYAN
		function(status)
			return false -- Change to true to show thirst bar | false to hide thirst bar
		end, function(status)
			status.remove(75)
		end
	)
```

* Disabling Optional Needs Bar  (resources\[esx]\esx_optionalneeds\client\main.lua `esx_status:loaded`)
```
AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', 
    function(status)
      if status.val > 0 then
        return false -- Set to true to show if you drink | false to always hide
      else
        return false -- Set to true to always show | false to hide if 0
      end
    end,
    function(status)
      status.remove(1500)
    end
  )
```

# Editing
* esx_customui\html\style.css (Edit Lines 9 & 10 to Change Position on Screen)
* esx_customui\client.lua (Edit Line 87 to set Default Distance) & (Edit Line 88 to Allow Changing Distance)

# KNOWN BUGS:
* If you are using an Aspect Ratio less then 16:9 there might be problems. Always use 16:9 or 16:10
* Icons not Showing Up. This could be a few reason like you commented it out in resource.lua or for jobs your job name is textil but the image for it is tailor or could simple be a script load order problem.

# Credits/Original Code
* [Chubbz123](https://github.com/Chubbz123)
  * [fivem-ui](https://github.com/Chubbz123/fivem-ui)

# Other
If you like this please check out some of my other stuff like
* [esx_customui](https://github.com/HumanTree92/esx_customui)
* [esx_hospital](https://github.com/HumanTree92/esx_hospital)
* [esx_extraitems](https://github.com/HumanTree92/esx_extraitems)
* [esx_aircraftshop](https://github.com/HumanTree92/esx_aircraftshop)
* [esx_boatshop](https://github.com/HumanTree92/esx_boatshop)
* [esx_eden_aircraftgarage](https://github.com/HumanTree92/esx_eden_aircraftgarage)
* [esx_eden_boatgarage](https://github.com/HumanTree92/esx_eden_boatgarage)
* [esx_eden_garage](https://github.com/HumanTree92/esx_eden_garage)
* [esx_panicbutton](https://github.com/HumanTree92/esx_panicbutton)
* [FiveM_CustomMapAddons](https://github.com/HumanTree92/FiveM_CustomMapAddons)

# Visit Velociti Entertainment
* [TS3](http://www.velocitientertainment.com/ts3/)
* [Discord](https://discord.gg/azEY2kU)
* [Website](www.velocitientertainment.com/)
* [Forums](www.velocitientertainment.com/forum)
* [Servers](www.velocitientertainment.com/servers/)
* [Donate](http://www.velocitientertainment.com/donations/)
* [Steam Group](http://steamcommunity.com/groups/velocitientertainment)
* [Facebook](www.facebook.com/VelocitiEntertainment)
* [Twitter](www.twitter.com/VelocitiEnt)
* [YouTube](www.youtube.com/user/HumanTree92)
* [Twitch](www.twitch.tv/humantree92)
* [eBay](www.ebay.com/usr/humantree92)
* Kik #vegaming

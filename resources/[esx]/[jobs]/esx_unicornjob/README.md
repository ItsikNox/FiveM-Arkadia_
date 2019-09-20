# fxserver-esx_unicornjob

FXServer ESX UNICORN JOB


[REQUIREMENTS]

* Player management (billing and boss actions)
  * esx_society => https://github.com/ESX-Org/esx_society
  * esx_billing => https://github.com/ESX-Org/esx_billing

* Items effects (hunger, thirst, drunk)
  * esx_status => https://github.com/ESX-Org/esx_status
  * esx_basicneeds => https://github.com/ESX-Org/esx_basicneeds
  * esx_optionalsneeds => https://github.com/ESX-Org/esx_optionalneeds
  * Items and effects should be added separately in their appropriate files
  * You need to add animations + items effects (basicneeds, optionnalneeds) for an optimal experience


[INSTALLATION]

1) CD in your resources/[esx] folder

3) Import esx_unicornjob.sql in your database

4) Add this in your server.cfg :

```
start esx_unicornjob
```
5) If you want player management you have to set Config.EnablePlayerManagement to true in config.lua
   You can config VaultManagement & Helicopters with true/false (don't forget to comment the area in the same file)

6) If you want real effects, add items and effects in esx_basicneeds and esx_optionalsneeds.

Here are examples of what you could add:

esx_basicneeds\server\main.lua:
```lua
ESX.RegisterUsableItem('icetea', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('icetea', 1)

    TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
    TriggerClientEvent('esx_basicneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('used_icetea'))

end)

ESX.RegisterUsableItem('mixapero', function(source)
    
        local xPlayer = ESX.GetPlayerFromId(source)
    
        xPlayer.removeInventoryItem('mixapero', 1)
    
        TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
        TriggerClientEvent('esx_status:remove', source, 'thirst', 50000)
        TriggerClientEvent('esx_basicneeds:onEat', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_mixapero'))
    
end)
```


esx_optionalneeds\server\main.lua:
```lua
ESX.RegisterUsableItem('tequila', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('tequila', 1)

    TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('used_tequila'))

end)

ESX.RegisterUsableItem('jagerbomb', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('jagerbomb', 1)

    TriggerClientEvent('esx_status:add', source, 'drunk', 500000)
    TriggerClientEvent('esx_status:remove', source, 'hunger', 10000)
    TriggerClientEvent('esx_status:remove', source, 'thirst', 70000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
    TriggerClientEvent('esx:showNotification', source, _U('used_jagerbomb'))

end)
```

   
[FEATURES]

* Vanilla Unicorn job
  * Fully customizable job
  * Boss, Bartender, Dancer grades
  * Cloakroom, Vault, Fridge, Vehicles, BossActions
  * Cloakroom : Dancer clothing with special movement effect, multiple clothes for men or women
  * Shops (harvesting) for components (alcoholic drinks, appetizers, non-alcoholic drinks)
  * Crafting menu for Bosses + Bartender (only with the right clothing) : coktails, mix appetizers
  * Spawning car without dust
  * Teleport marker to be behind the bar
  * Players can miss the crafting part (~10% miss) and lose the components used
  * Billing menu
  * Girl are not supplied



[SHOPS (HARVESTING) AREAS]

* Alcoholic drinks => https://i.imgur.com/CIrpHfm.png
* Non-alcoholic drinks => https://i.imgur.com/QC3UeA2.png
* Appetizers => https://i.imgur.com/YYYrAQP.png

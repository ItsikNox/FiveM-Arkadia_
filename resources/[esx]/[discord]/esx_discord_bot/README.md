# ESX Discord bot

FX Server Discord bot

## Description

This bot will send alert directly on your discord server , easy to install.

## Requirements

[esx_society](https://github.com/ESX-Org/esx_society)
[es_extended](https://github.com/ESX-Org/es_extended)


## Installation

1.CD in your resources/[esx]folder

2.Clone the repository

```
https://github.com/ElNelyo/esx_discord_bot.git
```

3.Add "_start esx\_discord\_bot_" to your server.cfg

4.Create your Discord Bot

1.	Go to your server settings :
[display image](http://prntscr.com/gx298g)

2.	Create webhooks (you can change image and name:
[display image](http://prntscr.com/gx2ai7)

3. Copy the webhook link

5.Edit **config.lua** from _esx\_discord\_bot_ and paste your **webhook link**

6.Add these lines in **esx_extended/server/main.lua**




In ```RegisterServerEvent('esx:giveInventoryItem')```



**item_standart** :

```
TriggerEvent("esx:giveitemalert",sourceXPlayer.name,targetXPlayer.name,ESX.Items[itemName].label,itemCount)
```

**item_money**:

```
TriggerEvent("esx:givemoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount)
```

**item_account**:

```
TriggerEvent("esx:givemoneybankalert",sourceXPlayer.name,targetXPlayer.name,itemCount)
```

**item_weapon**:

```
TriggerEvent("esx:giveweaponalert",sourceXPlayer.name,targetXPlayer.name,weaponLabel)
```



You should have something like this
[display image](http://prntscr.com/gx2hrk)




7.Add this line in **esx_society/server/main.lua**

In ```RegisterServerEvent('esx_society:washMoney')```

```
TriggerEvent("esx:washingmoneyalert",xPlayer.name,amount)
```



You should have something like this
[display image](http://prntscr.com/gx2jc5)



## Feature
Discord alert : 
- Kill
- Enter in a police vehicle (exept for policeman)
- Chat 
- Connecting / Disconnecting
- Steal a vehicle
- Giving Item / Money / Weapon 
- Blacklisted vehicle


-----------------------------------------
-----------------------------------------
----    File : client.lua            ----
----    Author : gassastsina         ----
----    Side : client          		 ----
----    Description : Alerte tempête ----
-----------------------------------------
-----------------------------------------

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    TriggerServerEvent('reboot:checkStatus')
end)

-----------------------------------------------main-------------------------------------------------------
RegisterNetEvent('reboot:startRain')
AddEventHandler('reboot:startRain', function()
	SetWeatherTypeOverTime('RAIN', 15.0)
    SetWeatherTypePersist('RAIN')
    SetWeatherTypeNow('RAIN')
    SetWeatherTypeNowPersist('RAIN')
	CreateLightningThunder()
	CreateLightningThunder()
	CreateLightningThunder()
	SetWindSpeed(12.0)
end)

local alreadyThunder = false
RegisterNetEvent('reboot:startThunder')
AddEventHandler('reboot:startThunder', function()
	if not alreadyThunder then
		SetWeatherTypeOverTime('THUNDER', 15.0)
	    SetWeatherTypePersist('THUNDER')
	    SetWeatherTypeNow('THUNDER')
	    SetWeatherTypeNowPersist('THUNDER')
		SetWindSpeed(15.0)
		SetWavesIntensity(5.0)
		CreateLightningThunder()
		SetBlackout(true)
		Wait(math.random(800, 800+400))
		SetBlackout(false)
		Wait(math.random(1000, 1000+500))
		SetBlackout(true)
		Wait(math.random(1500, 1500+3500))
		SetBlackout(false)

		alreadyThunder = true
		local nThunder = 0
		while true do
			Wait(1000)
			if math.random(1, 30) == 1 then
				SetBlackout(true)
				Wait(math.random(1000, nThunder*100+1000))
				SetBlackout(false)
			end
			nThunder = nThunder + 1
		end
	end
end)

RegisterNetEvent('reboot:startAlarm')
AddEventHandler('reboot:startAlarm', function()
	while true do
		alarmSound()
		Wait(24692)
		alarmSound()
		Wait(24692)
		alarmSound()
		Wait(180000)
	end
end)

function alarmSound()
	SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = 'alarm',
        transactionVolume   = 0.00
    })
end

---------------------------------
--------- ikNox#6088 ------------
---------------------------------
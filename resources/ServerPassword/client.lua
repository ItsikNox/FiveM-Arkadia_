------------------------------
-- Server Password, Made by --
--  FAXES & GlitchDetector  --
------------------------------

--- CONFIG ---
local attempts = 3 -- Amount of attempts a user can have

---------------------------------------------------------------------------------------------------------------
local passwordPassed = false

function KeyboardInput(textEntry, inputText, maxLength) -- Thanks to Flatracer for the function.
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

function drawText(text, x, y)
	local resx, resy = GetScreenResolution()
	SetTextFont(0)
	SetTextScale(0.8, 0.8)
	SetTextProportional(true)
	SetTextColour(41, 170, 226, 255)
	SetTextCentre(true)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText((float(x) / 1.5) / resx, ((float(y) - 6) / 1.5) / resy)
end

function float(num)
	num = num + 0.00001
	return num
end

---------------------------------------------------------------------------------------------------------------
AddEventHandler('onClientMapStart', function()
    Wait(1000)
    local ped = GetPlayerPed(-1)
    FreezeEntityPosition(ped, true)
    TriggerServerEvent("Fax:ServerPassword:Initialize")
end)

RegisterNetEvent("Fax:ServerPassword:ShowPasswordPrompt")
AddEventHandler("Fax:ServerPassword:ShowPasswordPrompt", function()
    local password = KeyboardInput("https://discord.gg/qHhHH4S #mot-de-passe (" .. attempts .. " tentative" .. (attempts == 1 and "" or "s") .. " restant)", "", 30)
    attempts = attempts - 1
    TriggerServerEvent("Fax:ServerPassword:CheckPassword", password, attempts)
end)

RegisterNetEvent('Fax:ServerPassword:PassedPassword')
AddEventHandler('Fax:ServerPassword:PassedPassword', function()
    local ped = GetPlayerPed(-1)
    FreezeEntityPosition(ped, false)
    TriggerEvent("password:notify", "CHAR_PEGASUS_DELIVERY", 1, "Mot de Passe", false, 'Mot de passe ~g~Correct !')
end)
-- A FaxDetector Project ;)

RegisterNetEvent("password:notify")
AddEventHandler("password:notify", function(icon, type, sender, title, text)
    Citizen.CreateThread(function()
		Wait(1)
		SetNotificationTextEntry("STRING");
		AddTextComponentString(text);
		SetNotificationMessage(icon, icon, true, type, sender, title, text);
		DrawNotification(false, true);
    end)
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local listOn = false
local faketimer = 0
local connectedPlayers = {}
local formattedPlayerList = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('scoreboard:getPlayers', function(playerTable)
		connectedPlayers = playerTable
		UpdatePlayerTable()
	end)
end)

RegisterNetEvent('scoreboard:updatePlayers')
AddEventHandler('scoreboard:updatePlayers', function(playerTable)
	connectedPlayers = playerTable

	UpdatePlayerTable()
end)

Citizen.CreateThread(function()
	if faketimer >= 3 then
		faketimer = 0
	end

	listOn = false
	while true do
		Citizen.Wait(10)

		if IsControlPressed(0, Keys['F1']) then
			if not listOn then

				if faketimer >= 2 then
					ESX.TriggerServerCallback('scoreboard:getScoreboard', function(ems, police, taxi, mek, bil, maklare, spelare)

						SendNUIMessage({
							text = table.concat(formattedPlayerList),
							ems = ems,
							police = police,
							taxi = taxi,
							mek = mek,
							bil = bil,
							maklare = maklare,
							spelare = spelare
						})
					end)
					faketimer = 0
				else
					SendNUIMessage({ text = table.concat(formattedPlayerList)})
					faketimer = 0
				end

				listOn = true

				while listOn do
					Citizen.Wait(10)
					if IsControlPressed(0, Keys['F1']) == false then
						listOn = false
						SendNUIMessage({
							meta = 'close'
						})
						break
					end
				end
			end
		end
	end
end)

function UpdatePlayerTable()
	formattedPlayerList = {}

	for k,v in pairs(connectedPlayers) do
		table.insert(formattedPlayerList, '<tr style=\"color: rgb(' .. 255 .. ', ' .. 255 .. ', ' .. 255 .. ')\"><td>' .. k .. '</td><td>' .. v.name .. '</td></tr>')
	end
end

Citizen.CreateThread(function() -- Thread for timer
	while true do 
		Citizen.Wait(5000)
		faketimer = faketimer + 1
	end
end)
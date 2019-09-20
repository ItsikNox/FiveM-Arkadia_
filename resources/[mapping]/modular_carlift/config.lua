----------------------------
-- By K3rhos & DoluTattoo --
----------------------------

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config = {}

-- Wich key will open the elevator menu ?
Config.Open_key = Keys["E"]


-- Set the speed of the elevator
Config.speed_up = 0.01
Config.speed_up_slow = 0.006 -- between "Config.max" and "Config.beforemax"
Config.speed_down_slow = 0.0055 -- between "Config.min" and "Config.beforemin"
Config.speed_down = 0.015

-- Set the maximum and minimum height positions of the elevator
Config.max = 31.75 -- higher position
Config.beforemax = 31.53 -- detector for speed_up_slow
Config.beforemin = 29.95 -- detector for speed_down_slow
Config.min = 29.83 -- lower position


-- Set the radius where the player have to be to spawn automatically the elevator prop (no worries the prop cannot spawn twice)
Config.spawndistance = 23


-- Debug Mode
Config.debug = false -- use that to add an option in menu to delete the elevator prop. Then you can restart the resource without crash !


-- Choose your language
Config.Locale = 'fr'

Language = {

	['en'] = {
		['menu_title'] = "Benny Elevator",
		['elevator_up'] = "Up the elevator",
		['elevator_stop'] = "Stop the elevator", 
	  	['elevator_down'] = "Down the elevator", 
	  	['delete_elevator'] = "DEBUG: Delete props before restart", -- need to enable debug mode
	},

	['fr'] = {
		 ['menu_title'] = "Benny Elevator",
		 ['elevator_up'] = "Faire monter le pont",
		 ['elevator_stop'] = "Stopper le pont",
  		 ['elevator_down'] = "Faire descendre le pont",  
  		 ['delete_elevator'] = "~r~DEBUG: Supprimer ponts avant restart", -- necessite d'activer le mode debug
	}

}

----------------------------
-- By K3rhos & DoluTattoo --
----------------------------

-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_SafeCracker = {}
local MFSC = MF_SafeCracker

MFSC.Version = '1.0.01'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

Keys = {
  ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
  ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
  ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 116,  ["]"]   = 40,   ["ENTER"]   = 18,
  ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
  ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
  ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70, 
  ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
  ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
  ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}

MFSC.Config = {
	LockTolerance	= 3,								-- How many clicks past the pin can the player go before the lock fails?							

	AudioBankName 	= "SAFE_CRACK",						
	TextureDict 	= "MFSCTextureDict",

	SafeSoundset 	= "SAFE_CRACK_SOUNDSET",
	SafeTurnSound	= "tumbler_turn",
	SafePinSound	= "tumbler_pin_fall",
	SafeFinalSound	= "tumbler_pin_fall_final",
	SafeResetSound	= "tumbler_reset",
	SafeOpenSound	= "safe_door_open",
}

MFSC.SafeModels = {
	Safe  	= "bkr_prop_biker_safebody_01a",
	Door  	= "bkr_prop_biker_safedoor_01a",
}

MFSC.SafeObjects = {
	safeObj  = { ModelName = MFSC.SafeModels.Safe,  Pos 	= vector3(   0.0,   0.0,   -0.1 ), Heading =  3.7,   Rot = vector3(   0.0,   0.0,    0.0), 			Frozen = false },
	doorObj  = { ModelName = MFSC.SafeModels.Door,  Pos 	= vector3(   0.0,   0.0,    0.0 ), Heading =  3.7,   Rot = vector3(   0.0,   0.0,    0.0), 			Frozen = true  },
}
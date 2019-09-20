--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--
local instructionalsButtonsList = {}
local currentInstructionalButtons = nil
local scaleform = nil

--
--
--
local function CreateInstructionalButtons(data)

	Citizen.CreateThread(function()

		-- Citizen.Trace("oui")
		scaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
	    while not HasScaleformMovieLoaded(scaleform) do
	        Citizen.Wait(10)
	    end

		PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
		PopScaleformMovieFunctionVoid()

		local total = 0
		for text, value in pairs(data) do
			PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		    PushScaleformMovieFunctionParameterInt(total)
		    PushScaleformMovieFunctionParameterString(GetControlInstructionalButton(2, value, true))
		    PushScaleformMovieFunctionParameterString(text)
		    PopScaleformMovieFunctionVoid()
			total = total + 1
			Citizen.Wait(1)
		end

	    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	    PopScaleformMovieFunctionVoid()

		PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(80)
		PopScaleformMovieFunctionVoid()

	end)

end

--
--
--
function AddInstructionalButtons(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for name, value in pairs(args[1]) do
            Citizen.Wait(1)
            instructionalsButtonsList[name] = value
        end

    elseif count == 2 then

        local name = args[1]
        local value = args[2]
        instructionalsButtonsList[name] = value

    else

        return false

    end

end

--
--
--
function RemoveInstructionalButtons(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for name, value in pairs(args[1]) do
            instructionalsButtonsList[name] = nil
            Citizen.Wait(1)
        end

    elseif count == 1 then

        local name = args[1]
        instructionalsButtonsList[name] = nil

    else

        return false

    end

end

--
--
--
function DisplayInstructionalButtons(name)

    if instructionalsButtonsList[name] ~= nil and currentInstructionalButtons ~= name then

        currentInstructionalButtons = name
		CreateInstructionalButtons(instructionalsButtonsList[name])

    elseif currentInstructionalButtons == name then

		return false

	else

        currentInstructionalButtons = nil
		scaleform = nil

    end

end

--
--
--
function GetCurrentInstructionalButtons()

    return currentInstructionalButtons

end

--
--
--
function InstructionalButtonsFrame()

    Citizen.CreateThread(function()
        while true do

            if currentInstructionalButtons ~= nil and instructionalsButtonsList[currentInstructionalButtons] ~= nil and scaleform ~= nil then
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
            Citizen.Wait(5)

        end
    end)

end

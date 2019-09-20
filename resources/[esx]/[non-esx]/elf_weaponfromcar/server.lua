
--											--
--		made by ELF#0001 <- my discord		--
--		3dme made by Elio					--
--											--

local logEnabled = false

-- RegisterServerEvent('3dme:shareDisplay')
-- AddEventHandler('3dme:shareDisplay', function(text)
	-- TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
	-- if logEnabled then
		-- setLog(text, source)
	-- end
-- end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end

if GetCurrentResourceName() ~= "elf_weaponfromcar" then
	print("                                             #")
	print("                                             ###")
	print("###### ###### ###### ###### ######  ##############")
	print("#      #    # #    # #    # #    #  ################    Rename '" .. GetCurrentResourceName() .. "' back to 'elf_weaponfromcar'")
	print("###    ###### ###### #    # ######  ##################  otherwise script might not work properly!")
	print("#      # ##   # ##   #    # # ##    ################    why wont you let my name be !!!")
	print("###### #   ## #   ## ###### #   ##  ##############")
	print("                                             ###")
	print("                                             #")
end

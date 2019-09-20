seqSwitch = nil
seqRemaingingTime = 0

AddEventHandler('mhacking:seqstart', function(solutionlength, duration, callback)
	if type(solutionlength) ~= 'table' and type(duration) ~= 'table' then
		TriggerEvent('mhacking:show')
		TriggerEvent('mhacking:start', solutionlength, duration, mhackingSeqCallback)
		while seqSwitch == nil do
			Citizen.Wait(5)
		end
		TriggerEvent('mhacking:hide')
		callback(seqSwitch, seqRemaingingTime, true)
		seqRemaingingTime = 0
		seqSwitch = nil
		
	elseif type(solutionlength) == 'table' and type(duration) ~= 'table' then
		TriggerEvent('mhacking:show')
		seqRemaingingTime = duration
		for _, sollen in pairs(solutionlength) do
			TriggerEvent('mhacking:start', sollen, seqRemaingingTime, mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			
			if next(solutionlength,_) == nil or seqRemaingingTime == 0 then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('mhacking:hide')
		
	elseif type(solutionlength) ~= 'table' and type(duration) == 'table' then
		TriggerEvent('mhacking:show')
		for _, dur in pairs(duration) do
			TriggerEvent('mhacking:start', solutionlength, dur, mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			if next(duration,_) == nil then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('mhacking:hide')
	
	elseif type(solutionlength) == 'table' and type(duration) == 'table' then
		local itrTbl = {}
		local solTblLen = 0
		local durTblLen = 0
		for _ in ipairs(solutionlength) do solTblLen = solTblLen + 1 end
		for _ in ipairs(duration) do durTblLen = durTblLen + 1 end
		itrTbl = duration
		if solTblLen > durTblLen then itrTbl = solutionlength end	
		TriggerEvent('mhacking:show')
		for idx in ipairs(itrTbl) do
			TriggerEvent('mhacking:start', solutionlength[idx], duration[idx], mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			if next(itrTbl,idx) == nil then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('mhacking:hide')
		
	end
end)

function mhackingSeqCallback(success, remainingtime)
	seqSwitch = success
	seqRemaingingTime = math.floor(remainingtime/1000.0 + 0.5)
end
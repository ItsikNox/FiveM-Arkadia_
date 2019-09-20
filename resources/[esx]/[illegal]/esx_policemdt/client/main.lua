ESX                     = nil
local tabEnabled        = false
local tabLoaded         = true
local server_requested  = false

local pcs = {
	{name="PC", id=277, x=459.70, y=-988.93, z=24.91},	
	{name="PC", id=277, x=1853.26, y=3689.98, z=34.26},
	{name="PC", id=277, x=-449.29, y=6012.59, z=31.71},
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback('esx_policemdt:GetWarrantsClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:getWarrants', data.page)
end)

RegisterNUICallback('esx_policemdt:GetBolosClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:getBolos', data.page)
end)

RegisterNUICallback('esx_policemdt:GetArrestsClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:getArrests', data.page)
end)

RegisterNUICallback('esx_policemdt:NewReportClient', function(data, cb)
	if data.report_type ~= '' and data.target ~= '' and data.desc ~= '' and data.charges ~= '' then
		TriggerServerEvent('esx_policemdt:NewReportServer', data.report_type, data.target, data.desc, data.charges)
	end
end)

RegisterNUICallback('esx_policemdt:CloseTab', function(data, cb)
	SendNUIMessage({
		type = 'GUI_pmobilet',
		StatusJS = false
	})
	tabEnabled = false
    SetNuiFocus(false, false)
end)

RegisterNUICallback('esx_policemdt:SearchPersonClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:SearchPersonServer', data.fname, data.sname)
end)

RegisterNUICallback('esx_policemdt:SearchVehicleClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:SearchVehicleServer', data.plate)
end)

RegisterNetEvent('esx_policemdt:updateBolosList')
AddEventHandler('esx_policemdt:updateBolosList', function(bolos_table, pagenum, total_pages, user_names, id_list)
	local html_list = ''
	local design_shit = 'sui-row'
	
	local pag_menu = '<ul class="pagination">'
	
	if pagenum > 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 3) .. ');">' .. (pagenum - 3) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 2 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	end
	
	pag_menu = pag_menu .. '<li class="active"><a>' .. pagenum .. '</a></li>'
	
	if pagenum < (total_pages - 3) or pagenum == (total_pages - 3) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 3) .. ');">' .. (pagenum + 3) .. '</a></li>';
	elseif pagenum == (total_pages - 2) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
	elseif pagenum == (total_pages - 1) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
	end
	
	pag_menu = pag_menu .. '</ul>'
	
	for x=1, #bolos_table, 1 do
		local json_decoded = json.decode(bolos_table[x])
		
		if math.fmod(x,2)~=0 then
			design_shit = 'sui-row'
		else
			design_shit = 'sui-alt-row'
		end
		
		html_list = html_list .. '<tr class="' .. design_shit .. '" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. user_names[x] .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Suspect .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Description .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.OfficerC .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Date .. '</td><td onclick="delete_record(' .. id_list[x] .. ');" role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;"><i onclick="delete_record(' .. id_list[x] .. ');" class="fa fa-trash" aria-hidden="true"></i></td></tr>'
	end
		
	SendNUIMessage({
		type = 'GUI_pmobilet',
		newBolosList = true,
		html = html_list,
		pag_div = pag_menu
	})
end)

RegisterNetEvent('esx_policemdt:updateArrestsList')
AddEventHandler('esx_policemdt:updateArrestsList', function(arrests_table, pagenum, total_pages, user_names, id_list)
	local html_list = ''
	local design_shit = 'sui-row'
	
	local pag_menu = '<ul class="pagination">'
	
	if pagenum > 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 3) .. ');">' .. (pagenum - 3) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 2 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	end
	
	pag_menu = pag_menu .. '<li class="active"><a>' .. pagenum .. '</a></li>'
	
	if pagenum < (total_pages - 3) or pagenum == (total_pages - 3) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 3) .. ');">' .. (pagenum + 3) .. '</a></li>';
	elseif pagenum == (total_pages - 2) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
	elseif pagenum == (total_pages - 1) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
	end
	
	pag_menu = pag_menu .. '</ul>'
	
	for x=1, #arrests_table, 1 do
		local json_decoded = json.decode(arrests_table[x])
		
		if math.fmod(x,2)~=0 then
			design_shit = 'sui-row'
		else
			design_shit = 'sui-alt-row'
		end
		
		html_list = html_list .. '<tr class="' .. design_shit .. '" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. user_names[x] .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Detainee .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Description .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.OfficerC .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Date .. '</td><td onclick="delete_record(' .. id_list[x] .. ');" role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;"><i onclick="delete_record(' .. id_list[x] .. ');" class="fa fa-trash" aria-hidden="true"></i></td></tr>'
	end
		
	SendNUIMessage({
		type = 'GUI_pmobilet',
		newArrestsList = true,
		html = html_list,
		pag_div = pag_menu
	})
end)

AddEventHandler('esx_policemdt:NewReportResponse', function()
	SendNUIMessage({
		type = 'GUI_pmobilet',
		report_added = true
	})
end)
RegisterNetEvent('esx_policemdt:NewReportResponse')

AddEventHandler('esx_policemdt:SearchPersonFinish', function(player_name, properties, licenses, job, bills, has_warrants)
	local html_data = ''
	
	if player_name == 'none' then
		html_data = '<span style="font-weight: bold; font-size: 18px; left: 0; right: 0; margin: auto; color: red;">Rien trouvé</span>'
		
		SendNUIMessage({
			type = 'GUI_pmobilet',
			newPlayerSearch = true,
			html = html_data
		})
	else
		local properties_string = ''
		local licenses_string = ''
		local bills_string = ''
		local warrants_string = ''
		
		for h=1, #properties, 1 do
			if properties_string == '' then
				properties_string = properties[h]
			else
				properties_string = properties_string .. ', ' .. properties[h]
			end
		end
		
		for z=1, #licenses, 1 do
			if licenses_string == '' then
				licenses_string = licenses[z]
			else
				licenses_string = licenses_string .. ', ' .. licenses[z]
			end
		end
		
		for x=1, #bills, 1 do
			if bills_string == '' then
				bills_string = bills[x]
			else
				bills_string = bills_string .. ', ' .. bills[x]
			end
		end
		
		if licenses_string == '' then
			licenses_string = 'Aucune licence'
		end
		
		if bills_string == '' then
			bills_string = 'Aucune facture'
		end
		
		if properties_string == '' then
			properties_string = 'Aucune propriété'
		end
		
		if has_warrants == true then
			warrants_string = '<i style="color: red;" class="fa fa-exclamation-triangle" aria-hidden="true"></i>'
		elseif has_warrants == false then
			warrants_string = '<i style="color: lime;" class="fa fa-check-square" aria-hidden="true"></i>'
		end
		
		html_data = '<tr class="sui-row" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. player_name .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. properties_string .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. bills_string .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. licenses_string .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. job .. '</td><td role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;">' .. warrants_string .. '</td></tr>'
		
		SendNUIMessage({
			type = 'GUI_pmobilet',
			newPlayerSearch = true,
			html = html_data
		})
	end
end)
RegisterNetEvent('esx_policemdt:SearchPersonFinish')

AddEventHandler('esx_policemdt:SearchVehicleFinish', function(veh_plate, veh_model, veh_owner)
	local html_data = ''
	
	if veh_plate == 'none' then
		html_data = '<span style="font-weight: bold; font-size: 18px; left: 0; right: 0; margin: auto; color: red;">Rien trouvé</span>'
		
		SendNUIMessage({
			type = 'GUI_pmobilet',
			newVehicleSearch = true,
			html = html_data
		})
	else
		html_data = '<tr class="sui-row" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. GetLabelText(GetDisplayNameFromVehicleModel(veh_model)) .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. veh_plate .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. veh_owner .. '</td></tr>'
		
		SendNUIMessage({
			type = 'GUI_pmobilet',
			newVehicleSearch = true,
			html = html_data
		})
	end
end)
RegisterNetEvent('esx_policemdt:SearchVehicleFinish')

AddEventHandler('esx_policemdt:finishReportDelete', function(type_kek)
	if type_kek == 'warrants' then
		TriggerServerEvent('esx_policemdt:getWarrants', 1)
	elseif type_kek == 'bolos' then
		TriggerServerEvent('esx_policemdt:getBolos', 1)
	elseif type_kek == 'arrests' then
		TriggerServerEvent('esx_policemdt:getArrests', 1)
	end
end)
RegisterNetEvent('esx_policemdt:finishReportDelete')

RegisterNUICallback('esx_policemdt:DeleteReportClient', function(data, cb)
	TriggerServerEvent('esx_policemdt:DeleteReportServer', data.id, data.type)
end)

AddEventHandler('esx_policemdt:updateWarrantsList', function(warrants_table, pagenum, total_pages, user_names, id_list)
	local html_list = ''
	local design_shit = 'sui-row'
	
	local pag_menu = '<ul class="pagination">'
	
	if pagenum > 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 3) .. ');">' .. (pagenum - 3) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 3 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 2) .. ');">' .. (pagenum - 2) .. '</a></li>'
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	elseif pagenum == 2 then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum - 1) .. ');">' .. (pagenum - 1) .. '</a></li>'
	end
	
	pag_menu = pag_menu .. '<li class="active"><a>' .. pagenum .. '</a></li>'
	
	if pagenum < (total_pages - 3) or pagenum == (total_pages - 3) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 3) .. ');">' .. (pagenum + 3) .. '</a></li>';
	elseif pagenum == (total_pages - 2) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 2) .. ');">' .. (pagenum + 2) .. '</a></li>';
	elseif pagenum == (total_pages - 1) then
		pag_menu = pag_menu .. '<li><a onclick="pagination_stuff(' .. (pagenum + 1) .. ');">' .. (pagenum + 1) .. '</a></li>';
	end
	
	pag_menu = pag_menu .. '</ul>'
	
	for x=1, #warrants_table, 1 do
		local json_decoded = json.decode(warrants_table[x])
		
		if math.fmod(x,2)~=0 then
			design_shit = 'sui-row'
		else
			design_shit = 'sui-alt-row'
		end
		
		html_list = html_list .. '<tr class="' .. design_shit .. '" role="row"><td role="gridcell" tabindex="-1" class="sui-cell">' .. user_names[x] .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Suspect .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Description .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.OfficerC .. '</td><td role="gridcell" tabindex="-1" class="sui-cell">' .. json_decoded.Date .. '</td><td role="gridcell" tabindex="-1" class="sui-cell" style="font-size: 20px; text-align: center;"><i onclick="delete_record(' .. id_list[x] .. ');" class="fa fa-trash" aria-hidden="true"></i></td></tr>'
	end
	
	
	SendNUIMessage({
		type = 'GUI_pmobilet',
		newList = true,
		html = html_list,
		pag_div = pag_menu
	})
end)
RegisterNetEvent('esx_policemdt:updateWarrantsList')

AddEventHandler('esx_policemdt:askTabOpenResponse', function(status, force_veh_search, plate_number)
	if status == true then
		server_requested = false
		tabEnabled = true
        SetNuiFocus(true, true)
		if force_veh_search == true then
			SendNUIMessage({
				type = 'GUI_pmobilet',
				ForceVehSearch = true,
				number = plate_number
			})
		elseif force_veh_search == false then
			SendNUIMessage({
				type = 'GUI_pmobilet',
				StatusJS = true
			})
		end
	else
		server_requested = false
	end
end)
RegisterNetEvent('esx_policemdt:askTabOpenResponse')

function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

Citizen.CreateThread(function()
    while true do
      if (IsControlJustPressed(0, 182)) and GetLastInputMethod( 0 ) and tabEnabled == false then
				if server_requested == false then
					local veh = GetVehiclePedIsUsing(PlayerPedId())
					if IsPedInAnyVehicle(GetPlayerPed(-1),true) and GetSeatPedIsTryingToEnter(GetPlayerPed(-1)) == -1 or GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1) or GetPedInVehicleSeat(veh, 0) == GetPlayerPed(-1) or nearPC() then
						TriggerServerEvent('esx_policemdt:askTabOpen', false, 'none')
						server_requested = true
					else
						local playerPed = GetPlayerPed(-1)
						local coords    = GetEntityCoords(playerPed)
						
						if IsAnyVehicleNearPoint(coords.x,  coords.y,  coords.z,  5.0) then
							local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)
							local plate_number = GetVehicleNumberPlateText(vehicle)
							TriggerServerEvent('esx_policemdt:askTabOpen', true, all_trim(plate_number))
							server_requested = true
						end
					end
				end
        Citizen.Wait(0)
			end
      if (tabEnabled) then
          local ped = GetPlayerPed(-1)
          DisableControlAction(0, 1, tabEnabled)
          DisableControlAction(0, 2, tabEnabled)
          DisableControlAction(0, 24, tabEnabled)
          DisablePlayerFiring(ped, tabEnabled)
          DisableControlAction(0, 142, tabEnabled)
          DisableControlAction(0, 106, tabEnabled)
      end
      Citizen.Wait(0)
    end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		SendNUIMessage({
			type = 'GUI_pmobilet',
			StatusJS = false
		})
		tabEnabled = false
		SetNuiFocus(false, false)
	end
end)

function nearPC()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(pcs) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 4 then
			return true
		end
	end
end

RegisterCommand('mdt', function(...)
	local plyData = ESX.GetPlayerData()
	if plyData and plyData.job and plyData.job.name == "police" then
		TriggerServerEvent('esx_policemdt:askTabOpen', false, 'none')
		server_requested = true
	end
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------
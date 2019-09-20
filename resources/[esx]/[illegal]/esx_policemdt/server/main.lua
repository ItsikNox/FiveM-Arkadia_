ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_policemdt:askTabOpen')
AddEventHandler('esx_policemdt:askTabOpen', function(force_veh_search, plate_number)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local job = xPlayer.getJob()
	
	if job.name == 'police' then
		TriggerClientEvent('esx_policemdt:askTabOpenResponse', _source, true, force_veh_search, plate_number)
	else
		TriggerClientEvent('esx_policemdt:askTabOpenResponse', _source, false, force_veh_search)
	end
end)

RegisterServerEvent('esx_policemdt:getWarrants')
AddEventHandler('esx_policemdt:getWarrants', function(pagenum_arg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local pagenum = 1
	
	if pagenum_arg ~= 0 and pagenum_arg > 0 then
		pagenum = tonumber(pagenum_arg)
	end
	
	local warrants_data = {}
	local num_of_records_per_page = 12
	local total_rows = 0
	local total_pages = 1
	local user_names = {}
	local id_list = {}
	
	local offset = (pagenum - 1) * num_of_records_per_page
	
	if offset < 0 then
		offset = 0
	end
	
	local job = xPlayer.getJob()
	
	if job.name == 'police' then
		MySQL.Async.fetchAll(
		'SELECT * FROM warrants_list',
		{},
			function (result_count)
				for z=1, #result_count, 1 do
					total_rows = total_rows + 1
				end
				MySQL.Async.fetchAll(
				'SELECT * FROM warrants_list ORDER BY id DESC LIMIT @offstet_sql, @total_records_sql',
				{
				['@offstet_sql'] = offset,
				['@total_records_sql'] = num_of_records_per_page
				},
					function (result)
						for x=1, #result, 1 do
							local json_decoded = json.decode(result[x].json_data)
							table.insert(user_names, get_player_name_sql(json_decoded.Officer))
							table.insert(warrants_data, result[x].json_data)
							table.insert(id_list, result[x].id)
						end
						total_pages = math.ceil(total_rows / num_of_records_per_page)
						TriggerClientEvent('esx_policemdt:updateWarrantsList', _source, warrants_data, pagenum, total_pages, user_names, id_list)
					end
				)
			end
		)
	end
end)

function get_player_name_sql(ident)
	local players = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @ident_key LIMIT 1', {['@ident_key'] = ident})
	return players[1].firstname .. ' ' .. players[1].lastname
end

RegisterServerEvent('esx_policemdt:DeleteReportServer')
AddEventHandler('esx_policemdt:DeleteReportServer', function(id, type_kek)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	
	local job = xPlayer.getJob()
		
	if job.name == 'police' then
		if type_kek == 'warrants' then
			MySQL.Sync.fetchAll('DELETE FROM warrants_list WHERE id = @report_id', {['@report_id'] = tonumber(id)})
			TriggerClientEvent('esx_policemdt:finishReportDelete', _source, type_kek)
		elseif type_kek == 'bolos' then
			MySQL.Sync.fetchAll('DELETE FROM bolos_list WHERE id = @report_id', {['@report_id'] = tonumber(id)})
			TriggerClientEvent('esx_policemdt:finishReportDelete', _source, type_kek)
		elseif type_kek == 'arrests' then
			MySQL.Sync.fetchAll('DELETE FROM arrests_list WHERE id = @report_id', {['@report_id'] = tonumber(id)})
			TriggerClientEvent('esx_policemdt:finishReportDelete', _source, type_kek)
		end
	end
end)

RegisterServerEvent('esx_policemdt:SearchVehicleServer')
AddEventHandler('esx_policemdt:SearchVehicleServer', function(plate)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	
	local vehicle_found = false
	
	local veh_plate = ''
	local veh_model = ''
	local veh_owner = ''
	
	local job = xPlayer.getJob()
	
	if plate == nil then
		TriggerClientEvent('esx_policemdt:SearchVehicleFinish', _source, 'none', '', '')
	else
		if job.name == 'police' then
			MySQL.Async.fetchAll(
			'SELECT * FROM owned_vehicles WHERE LOWER(vehicle) LIKE LOWER("%' .. plate .. '%") LIMIT 1',
			{},
				function (result)
					for x=1, #result, 1 do
						vehicle_found = true
						
						local json_decoded = json.decode(result[x].vehicle)
						veh_plate = json_decoded.plate
						veh_model = json_decoded.model
						veh_owner = get_player_name_sql(result[x].owner)
						
						TriggerClientEvent('esx_policemdt:SearchVehicleFinish', _source, veh_plate, veh_model, veh_owner)
					end
					if vehicle_found == false then
						TriggerClientEvent('esx_policemdt:SearchVehicleFinish', _source, 'none', '', '')
					end
				end
			)
		end
	end
end)

function getJobName(name)
	local job_label = MySQL.Sync.fetchAll('SELECT label FROM jobs WHERE name = @name LIMIT 1', {['@name'] = name})
	return job_label[1].label
end

function getPropertyName(name)
	local property_label = MySQL.Sync.fetchAll('SELECT label FROM properties WHERE name = @name LIMIT 1', {['@name'] = name})
	return property_label[1].label
end

function getLicenseLabel(name)
	local license_label = MySQL.Sync.fetchAll('SELECT label FROM licenses WHERE type = @name LIMIT 1', {['@name'] = name})
	return license_label[1].label
end

RegisterServerEvent('esx_policemdt:SearchPersonServer')
AddEventHandler('esx_policemdt:SearchPersonServer', function(fname, sname)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	
	local player_name = ''
	local properties = {}
	local licenses = {}
	local job = ''
	local bills = {}
	
	local player_found = false
	
	local job = xPlayer.getJob()
	local has_warrants = false
	print(fname,sname)
	if fname == nil or sname == nil then
		TriggerClientEvent('esx_policemdt:SearchPersonFinish', _source, 'none', '', '', '', '')
	else
		if job.name == 'police' then
			MySQL.Async.fetchAll(
			'SELECT * FROM users WHERE LOWER(firstname) LIKE LOWER("%' .. fname .. '%") AND LOWER(lastname) LIKE LOWER("%' .. sname .. '%") LIMIT 1',
			{},
				function (result)
					for x=1, #result, 1 do
						player_found = true
						player_name = result[x].firstname .. ' ' .. result[x].lastname
						job = getJobName(result[x].job)
						MySQL.Async.fetchAll(
						'SELECT * FROM owned_properties WHERE owner = @ident',
						{
						['@ident'] = result[x].identifier
						},
							function (result2)
								for z=1, #result2, 1 do
									if tostring(result2[z].rented) == '0' then
										table.insert(properties, getPropertyName(result2[z].name))
									else
										table.insert(properties, getPropertyName(result2[z].name) .. ' [RENTED]')
									end
								end
								MySQL.Async.fetchAll(
								'SELECT * FROM owned_properties WHERE owner = @ident',
								{
								['@ident'] = result[x].identifier
								},
									function (result2)
										for z=1, #result2, 1 do
											if tostring(result2[z].rented) == '0' then
												table.insert(properties, getPropertyName(result2[z].name))
											else
												table.insert(properties, getPropertyName(result2[z].name) .. ' [RENTED]')
											end
										end
										MySQL.Async.fetchAll(
										'SELECT * FROM billing WHERE identifier = @ident AND target = "society_police"',
										{
										['@ident'] = result[x].identifier
										},
											function (result3)
												for g=1, #result3, 1 do
													table.insert(bills, result3[g].label .. ' - ' .. result3[g].amount .. '$')
												end
												MySQL.Async.fetchAll(
												'SELECT * FROM user_licenses WHERE owner = @ident',
												{
												['@ident'] = result[x].identifier
												},
													function (result4)
														for h=1, #result4, 1 do
															table.insert(licenses, getLicenseLabel(result4[h].type))
														end
														MySQL.Async.fetchAll(
														'SELECT * FROM warrants_list',
														{},
															function (result5)
																for j=1, #result5, 1 do
																	local json_decoded2 = json.decode(result5[j].json_data)
																	if json_decoded2.Suspect:lower() == player_name:lower() then
																		has_warrants = true
																	end
																end
																TriggerClientEvent('esx_policemdt:SearchPersonFinish', _source, player_name, properties, licenses, job, bills, has_warrants)
															end
														)
													end
												)	
											end
										)
									end
								)
							end
						)
					end
					if player_found == false then
						TriggerClientEvent('esx_policemdt:SearchPersonFinish', _source, 'none', '', '', '', '')
					end
				end
			)
		end
	end
end)

RegisterServerEvent('esx_policemdt:getBolos')
AddEventHandler('esx_policemdt:getBolos', function(pagenum_arg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local pagenum = 1
	
	if pagenum_arg ~= 0 and pagenum_arg > 0 then
		pagenum = tonumber(pagenum_arg)
	end
	
	local bolos_data = {}
	local num_of_records_per_page = 12
	local total_rows = 0
	local total_pages = 1
	local user_names = {}
	local id_list = {}
	
	local offset = (pagenum - 1) * num_of_records_per_page
	
	if offset < 0 then
		offset = 0
	end
	
	local job = xPlayer.getJob()
	
	if job.name == 'police' then
		MySQL.Async.fetchAll(
		'SELECT * FROM bolos_list',
		{},
			function (result_count)
				for z=1, #result_count, 1 do
					total_rows = total_rows + 1
				end
				MySQL.Async.fetchAll(
				'SELECT * FROM bolos_list ORDER BY id DESC LIMIT @offstet_sql, @total_records_sql',
				{
				['@offstet_sql'] = offset,
				['@total_records_sql'] = num_of_records_per_page
				},
					function (result)
						for x=1, #result, 1 do
							local json_decoded = json.decode(result[x].json_data)
							table.insert(user_names, get_player_name_sql(json_decoded.Officer))
							table.insert(bolos_data, result[x].json_data)
							table.insert(id_list, result[x].id)
						end
						total_pages = math.ceil(total_rows / num_of_records_per_page)
						TriggerClientEvent('esx_policemdt:updateBolosList', _source, bolos_data, pagenum, total_pages, user_names, id_list)
					end
				)
			end
		)
	end
end)

RegisterServerEvent('esx_policemdt:getArrests')
AddEventHandler('esx_policemdt:getArrests', function(pagenum_arg)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local pagenum = 1
	
	if pagenum_arg ~= 0 and pagenum_arg > 0 then
		pagenum = tonumber(pagenum_arg)
	end
	
	local arrests_data = {}
	local num_of_records_per_page = 12
	local total_rows = 0
	local total_pages = 1
	local user_names = {}
	local id_list = {}
	
	local offset = (pagenum - 1) * num_of_records_per_page
	
	if offset < 0 then
		offset = 0
	end
	
	local job = xPlayer.getJob()
	
	if job.name == 'police' then
		MySQL.Async.fetchAll(
		'SELECT * FROM arrests_list',
		{},
			function (result_count)
				for z=1, #result_count, 1 do
					total_rows = total_rows + 1
				end
				MySQL.Async.fetchAll(
				'SELECT * FROM arrests_list ORDER BY id DESC LIMIT @offstet_sql, @total_records_sql',
				{
				['@offstet_sql'] = offset,
				['@total_records_sql'] = num_of_records_per_page
				},
					function (result)
						for x=1, #result, 1 do
							local json_decoded = json.decode(result[x].json_data)
							table.insert(user_names, get_player_name_sql(json_decoded.Officer))
							table.insert(arrests_data, result[x].json_data)
							table.insert(id_list, result[x].id)
						end
						total_pages = math.ceil(total_rows / num_of_records_per_page)
						TriggerClientEvent('esx_policemdt:updateArrestsList', _source, arrests_data, pagenum, total_pages, user_names, id_list)
					end
				)
			end
		)
	end
end)

RegisterServerEvent('esx_policemdt:NewReportServer')
AddEventHandler('esx_policemdt:NewReportServer', function(report_type, target, desc, charges)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local sql_string = ''
	
	local player_ident = GetPlayerIdentifier(_source)
	
	
	local job = xPlayer.getJob()
	
	if job.name == 'police' then
		if xPlayer then
			if report_type ~= '' and target ~= '' and desc ~= '' and charges ~= '' then
				if report_type == 'war' then
					sql_string = '{"Officer":"' .. player_ident .. '","Suspect":"' .. target .. '","Description":"' .. desc .. '","OfficerC":"' .. charges .. '", "Date":"' .. os.date() ..'"}'
					MySQL.Async.execute(
					'INSERT INTO `warrants_list` (json_data) VALUES (@json_memes)',
					{
					  ['@json_memes'] = sql_string
					},
					function(rowsChanged)
					  TriggerClientEvent('esx_policemdt:NewReportResponse', _source)
					end
					)
				elseif report_type == 'bol' then
					sql_string = '{"Officer":"' .. player_ident .. '","Suspect":"' .. target .. '","Description":"' .. desc .. '","OfficerC":"' .. charges .. '", "Date":"' .. os.date() ..'"}'
					MySQL.Async.execute(
					'INSERT INTO `bolos_list` (json_data) VALUES (@json_memes)',
					{
					  ['@json_memes'] = sql_string
					},
					function(rowsChanged)
					  TriggerClientEvent('esx_policemdt:NewReportResponse', _source)
					end
					)
				elseif report_type == 'arrest' then
					sql_string = '{"Officer":"' .. player_ident .. '","Detainee":"' .. target .. '","Description":"' .. desc .. '","OfficerC":"' .. charges .. '", "Date":"' .. os.date() ..'"}'
					MySQL.Async.execute(
					'INSERT INTO `arrests_list` (json_data) VALUES (@json_memes)',
					{
					  ['@json_memes'] = sql_string
					},
					function(rowsChanged)
					  TriggerClientEvent('esx_policemdt:NewReportResponse', _source)
					end
					)
				end
			end
		end
	end
end)
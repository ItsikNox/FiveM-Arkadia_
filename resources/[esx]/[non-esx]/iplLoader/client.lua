Citizen.CreateThread(function()
	loadImportExportDlc()
	for _,ipl in pairs(allIpls) do
		loadInt(ipl.coords, ipl.interiorsProps)
	end

end)


function loadInt(coordsTable, table)
	for _,coords in pairs(coordsTable) do
		local interiorID = GetInteriorAtCoords(coords[1],coords[2],coords[3])
		if(coords[1] == 998.4809) then
			print(interiorID)
		end
		LoadInterior(interiorID)
		for _,propName in pairs(table) do
			Citizen.Wait(25)
			
			EnableInteriorProp(interiorID, propName)
		end

		RefreshInterior(interiorID)
	end
end


function loadImportExportDlc()
	RequestIpl("imp_dt1_02_modgarage")
    RequestIpl("imp_dt1_02_cargarage_a")
    RequestIpl("imp_dt1_02_cargarage_b")
    RequestIpl("imp_dt1_02_cargarage_c")
             
    RequestIpl("imp_dt1_11_modgarage")
    RequestIpl("imp_dt1_11_cargarage_a")
    RequestIpl("imp_dt1_11_cargarage_b")
    RequestIpl("imp_dt1_11_cargarage_c")
             
    RequestIpl("imp_sm_13_modgarage")
    RequestIpl("imp_sm_13_cargarage_a")
    RequestIpl("imp_sm_13_cargarage_b")
    RequestIpl("imp_sm_13_cargarage_c")
             
    RequestIpl("imp_sm_15_modgarage")
    RequestIpl("imp_sm_15_cargarage_a")
    RequestIpl("imp_sm_15_cargarage_b")
    RequestIpl("imp_sm_15_cargarage_c")

	RequestIpl("imp_impexp_interior_placement") -- 994.5925, -3002.594, -39.64699
	RequestIpl("imp_impexp_interior_placement_interior_0_impexp_int_01_milo_")
	RequestIpl("imp_impexp_interior_placement_interior_1_impexp_intwaremed_milo_")
	RequestIpl("imp_impexp_interior_placement_interior_2_imptexp_mod_int_01_milo_")
	RequestIpl("imp_impexp_interior_placement_interior_3_impexp_int_02_milo_")
end
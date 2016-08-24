/client/proc/debug_antagonist_template(antag_type in all_antag_types)
	set category = "Debug"
	set name = "Debug Antagonist"
	set desc = "Debug an antagonist template."

	var/datum/antagonist/antag = all_antag_types[antag_type]
	if(antag)
		usr.client.debug_variables(antag)
		message_admins("Admin [key_name_admin(usr)] is debugging the [antag.role_text] template.")

/client/proc/debug_controller(controller in list("Master","Ticker","Ticker Process","Air","Jobs","Sun","Radio","Shuttles","Emergency Shuttle","Configuration","pAI", "Cameras", "Transfer Controller", "Gas Data","Event","Plants","Alarm","Chemistry","Wireless","Observation","Tgui") + module_controllers)
	set category = "Debug"
	set name = "Debug Controller"
	set desc = "Debug the various periodic loop controllers for the game (be careful!)"

	if(!holder)	return

	if(controller in module_controllers)
		debug_variables(module_controllers[controller])
	else
		switch(controller)
			if("Master")
				debug_variables(master_controller)
			if("Ticker")
				debug_variables(ticker)
			if("Ticker Process")
				debug_variables(tickerProcess)
			if("Jobs")
				debug_variables(job_master)
			if("Radio")
				debug_variables(radio_controller)
			if("Shuttles")
				debug_variables(shuttle_controller)
			if("Emergency Shuttle")
				debug_variables(emergency_shuttle)
			if("Configuration")
				debug_variables(config)
			if("Event")
				debug_variables(event_manager)
			if("Plants")
				debug_variables(plant_controller)
			if("Chemistry")
				debug_variables(chemistryProcess)
			if("Wireless")
				debug_variables(wirelessProcess)
			if("Observation")
				debug_variables(all_observable_events)
			if("Tgui")
				debug_variables(tguiProcess)
	message_admins("Admin [key_name_admin(usr)] is debugging the [controller] controller.")
	return

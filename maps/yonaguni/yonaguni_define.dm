/datum/map/yonaguni
	name = "Yonaguni"
	full_name = "Yonaguni Facility"
	path = "yonaguni"

	admin_levels = list(3)
	station_levels = list(1,2)
	contact_levels = list(1,2)
	player_levels = list(1,2)
	shallow_levels = list(1,2)

	test_x = 113
	test_y = 141
	test_z = 2

	evac_controller_type = /datum/evacuation_controller/pods/shuttle
	ambient_exterior_temperature = 110 // -160 degrees celcius (surface temperature of Europa)
	ambient_exterior_light = FALSE

	map_info = "<b>Yonaguni Dome 13</b> is a cloak-and-dagger project administrated by industrial giant PicoMotion. The facility is a privately owned, well-hidden reesarch base \
		on the floor of the Europan ocean, dedicated to studying the strange and often horrifying experiences waiting for humanity under the ice."

	full_name     = "Yonaguni Dome 13"
	station_short = "Yonaguni"
	dock_name     = "Rhadamanthus"
	boss_name     = "Board of Directors"
	boss_short    = "the Board"
	company_name  = "PicoMotion©"
	company_short = "PM"
	commanding_role = "Director"
	default_arrival_message = "has arrived at the facility"


/datum/map/yonaguni/perform_map_generation()
	map_submerged = TRUE
	//admin_notice("<span class='warning'>Generating abyssal plain...</span>", R_DEBUG)
	sleep(-1)
	//new /datum/random_map/automata/asteroids/cave_system/underwater(null,1,1,1,255,255)
	admin_notice("<span class='warning'>Generating sea floor...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/seafloor(null,1,1,2,255,255)
	admin_notice("<span class='warning'>Generating surface ice...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/tundra(null,1,1,3,255,255)

/datum/map/yonaguni/get_exterior_air()
	return new /datum/gas_mixture

/datum/map/yonaguni/meteors_detected_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MUNDANE)
			command_announcement.Announce("Long-range sensors report a minor volcanic eruption nearby. All personnel are advised to prepare for incidental debris.", "Seismic Monitoring Array")
		if(EVENT_LEVEL_MODERATE)
			command_announcement.Announce("Long-range sensors report a serious volcanic upheaval nearby. All personnel are advised to locate oxygen supplies and prepare for debris impact", "Seismic Monitoring Array")
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("Alert. Catastrophic volcanic eruption chain detected by long-range scanners. Severe debris storm inbound. All personnel, prepare for impact.", "Seismic Monitoring Array")

/datum/map/yonaguni/meteors_ending_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(severity)
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("The [station_name()] has cleared the debris storm.", "[station_name()] Sensor Array")
		else
			command_announcement.Announce("The [station_name()] has cleared the debris shower", "[station_name()] Sensor Array")

/obj/effect/landmark/map_data/yonaguni
	name = "yonaguni"
	desc = "The main dome level, the mining level and the surface."
	height = 2

/client/verb/fix_title()
	set name = "Fix Title"
	if(!lobby_image)
		lobby_image = new()
	screen |= lobby_image

/client/verb/edit_title()
	set name = "Edit Title"
	if(!lobby_image)
		lobby_image = new()
	debug_variables(lobby_image)

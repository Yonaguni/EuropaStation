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

	map_info = "<b>Yonaguni Dome</b> was a well-funded joint colony project intending to put a permanent human presence under the ice on Europa, one of Jupiter's \
		moons. Ambitious as the project was, the Jovian Navy, industrial investor PicoMotion, and the various civilian corps who formed the majority of the population \
		were unrepared for the strange and often horrifying experiences waiting for them under the ocean, and today only one dome remains functional - Dome Thirteen."

	full_name     = "Yonaguni Dome 13"
	station_short = "Yonaguni"
	dock_name     = "Rhadamanthus"
	boss_name     = "Department of Planetary Exploitation"
	boss_short    = "SDPE"
	company_name  = "PicoMotion©"
	company_short = "PM"
	commanding_role = "Colony Director"
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


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
	boss_name     = "Administration"
	boss_short    = "Admin"
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

/obj/effect/landmark/map_data/yonaguni
	name = "yonaguni"
	desc = "The main dome level, the mining level and the surface."
	height = 2

/datum/map/yonaguni
	name = "Yonaguni"
	full_name = "Yonaguni Facility"
	path = "yonaguni"

	admin_levels = list(3)
	station_levels = list(1,2)
	contact_levels = list(1,2)
	player_levels = list(1,2)
	shallow_levels = list(1,2)

	shuttle_docked_message = "The crew transfer submarine has docked at the Escape arm. Traffic control reports that departure will occur in approximately %ETD%."
	shuttle_leaving_dock = "The crew transfer submarine has left the Escape arm. Estimate %ETA% until arrival at %dock_name%."
	shuttle_called_message = "A crew transfer has been scheduled for this shift and a submarine has been dispatched from %dock_name%. Estimated arrival time is %ETA%."
	shuttle_recall_message = "The crew transfer has been cancelled."
	emergency_shuttle_docked_message = "The evacuation submarine has docked at the Escape arm. Traffic control reports that departure will occur in approximately %ETD%."
	emergency_shuttle_leaving_dock = "The evacuation submarine has left the Escape arm; escape pods now launching. Estimate %ETA% until arrival at %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation has been initiated and a submersible is en route from %dock_name%. It will arrive in %ETA%"
	emergency_shuttle_recall_message = "The emergency evacuation has been cancelled."

	test_x = 113
	test_y = 141
	test_z = 2

	evac_controller_type = /datum/evacuation_controller/pods/shuttle
	ambient_exterior_temperature = 110 // -160 degrees celcius (surface temperature of Europa)
	ambient_exterior_light = FALSE

	map_info = "<b>Yonaguni Dome 13</b> is a research facility administrated by industrial giant PicoMotion. The sprawling complex is a privately owned, \
	well-hidden research base on the floor of the Europan ocean, dedicated to studying the strange and often horrifying experiences waiting for humanity \
	under the ice."

	full_name     = "Yonaguni Dome 13"
	station_short = "Yonaguni"
	dock_name     = "Rhadamanthus Starport"
	boss_name     = "Administration"
	boss_short    = "Admin"
	company_name  = "PicoMotion©"
	company_short = "PM"
	commanding_role = "Site Director"
	default_arrival_message = "has arrived at the facility"
	captain_arrival_sound = null

	lobby_music_choices = list(
		/datum/music_track/torn,
		/datum/music_track/nebula,
		/datum/music_track/monument
		)

/datum/map/yonaguni/perform_map_generation()
	map_submerged = TRUE
	//admin_notice("<span class='warning'>Generating abyssal plain...</span>", R_DEBUG)
	//sleep(-1)
	//new /datum/random_map/automata/asteroids/cave_system/underwater(null,1,1,1,255,255)
	admin_notice("<span class='warning'>Generating sea floor...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/seafloor(null,1,1,2,255,255)

	// Temp workaround until lights can be removed from the map by hand.
	cull_overlapping_lights(1.6)
	// End temp.

/datum/map/yonaguni/get_exterior_air()
	return new /datum/gas_mixture

/obj/effect/landmark/map_data/yonaguni
	name = "yonaguni"
	desc = "The main dome level, the mining level and the surface."
	height = 2

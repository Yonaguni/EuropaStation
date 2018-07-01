/datum/map/testing
	name = "Testing"
	full_name = "Testing Map"
	path = "testing"
	station_levels = list(1)
	admin_levels = list(1)
	contact_levels = list(1)
	player_levels = list(1)
	ambient_exterior_light = FALSE
	exempt_areas = list(
		/area/centcom = NO_SCRUBBER|NO_VENT,
		/area/europa/ocean = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/space = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/arrival = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/hallway = NO_SCRUBBER|NO_VENT
		)
	test_x = 10
	test_y = 10
	test_z = 1
	has_weather = TRUE
	apply_environmental_lighting = TRUE

/datum/map/testing/perform_map_generation()
	map_submerged = TRUE
	admin_notice("<span class='warning'>Generating sea floor...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/seafloor(null,1,1,1,32,32)

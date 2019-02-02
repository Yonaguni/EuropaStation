/datum/map/cassini
	default_apc_check_exemptions = NO_SCRUBBER|NO_VENT
	apc_test_exempt_areas = list(
		/area/cassini = 0,
		/area/space = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/space/ocean = NO_SCRUBBER|NO_VENT|NO_APC
	)
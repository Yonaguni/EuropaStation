var/list/all_stellar_locations
var/list/stellar_locs_by_name

/proc/get_stellar_location(var/sloc)
	if(!all_stellar_locations)
		stellar_locs_by_name = list()
		all_stellar_locations = list()
		for(var/ltype in subtypesof(/datum/stellar_location))
			var/datum/stellar_location/stellar_loc = new ltype
			all_stellar_locations[ltype] = stellar_loc
			stellar_locs_by_name[stellar_loc.name] = stellar_loc
	return all_stellar_locations[sloc] ? all_stellar_locations[sloc] : stellar_locs_by_name[sloc]

/datum/stellar_location
	var/name
	var/description
	var/distance = 0
	var/is_a_planet
	var/list/flavour_locations =    list()
	var/list/random_map_locations = list()
	var/list/blacklisted_cargo =    list()

	// Character traits for people originating from this system.
	var/economic_power = 1
	var/default_language = LANGUAGE_SOLCOM
	var/character_info
	var/ruling_body = "Central Solar Authority"
	var/capitol

/datum/stellar_location/proc/build_level(var/tz)
	if(!using_map.use_overmap)
		return
	var/building = pick(random_map_locations)
	if(!ispath(random_map_locations[building]))
		return
	new building(null, 1, 1, tz, 255, 255)
	new /obj/effect/overmap/sector/generated (locate(128,128,tz), pick(random_map_locations), "A sector falling within the umbrella of [name].")
	var/sanity = 1000
	for(var/i = 1 to 5)
		var/turf/placing = locate(rand(20,230), rand(20, 230), tz)
		while(placing.density || (locate(/obj/effect/shuttle_landmark) in placing))
			if(sanity <= 0)
				placing = null
				break
			placing = locate(rand(20,230), rand(20, 230), tz)
			sanity--
		if(!placing || sanity <= 0)
			return
		new /obj/effect/shuttle_landmark/automatic(placing)

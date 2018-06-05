/client/verb/check_map_location()

	set name = "Check Map Location"
	set desc = "Get info on the current map."
	set category = "IC"

	usr << "The current map is: <b>[using_map.full_name]</b>"
	using_map.show_map_info(usr)

// Defined here so I can add it to the admin verbs.
var/map_submerged
/datum/admins/proc/submerge_map()
	set category = "Admin"
	set desc = "Submerge the map in an ocean."
	set name = "Submerge Map"

	if(!check_rights(R_ADMIN))	return

	if(map_submerged)
		usr << "<span class='warning'>The map has already been dropped into an ocean.</span>"
		return

	if(alert("Are you sure you want to drop the map into the ocean?",,"No","Yes") == "No")
		return

	using_map.ambient_exterior_light = (alert("Do you want the ocean to be dark?",,"No","Yes") == "No")
	using_map.ambient_exterior_temperature = ((alert("Do you want the ocean to be freezing?",,"No","Yes") == "Yes") ? 110 : T20C)

	map_submerged = TRUE
	world << "<span class='notice'><b>[usr.key] fumbled and dropped the server into an ocean, please wait for the game to catch up.</b></span>"
	sleep(10)
	for(var/i in using_map.station_levels)
		using_map.base_turf_by_z["[i]"] = /turf/simulated/ocean
		new /datum/random_map/noise/seafloor/replace_space(null,1,1,i,255,255)
		sleep(50)

	// This list will be empty if this verb is run post-roundstart. This is
	// used to clean up if it's run before roundstart but after turf init.
	SSatoms.InitializeAtoms(init_turfs)

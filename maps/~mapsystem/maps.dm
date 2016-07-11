var/datum/map/using_map = new USING_MAP_DATUM
var/list/all_maps = list()

/hook/startup/proc/initialise_map_list()
	for(var/type in typesof(/datum/map) - /datum/map)
		var/datum/map/M
		if(type == using_map.type)
			M = using_map
			M.setup_map()
		else
			M = new type
		if(!M.path)
			world << "<span class=danger>Map '[M]' does not have a defined path, not adding to map list!</span>"
			world.log << "Map '[M]' does not have a defined path, not adding to map list!"
		else
			all_maps[M.path] = M
	return 1

/datum/map
	var/name = "Unnamed Map"
	var/full_name = "Unnamed Map"
	var/title_state = "title"

	proc/setup_map()
	var/path

	var/list/station_levels = list()      // Z-levels the station exists on
	var/list/admin_levels = list()        // Z-levels for admin functionality (Centcom, shuttle transit, etc)
	var/list/contact_levels = list()      // Z-levels that can be contacted from the station, for eg announcements
	var/list/player_levels = list()       // Z-levels a character can typically reach
	var/list/sealed_levels = list()       // Z-levels that don't allow random transit at edge
	var/list/shallow_levels = list()      // Z-levels that are only a shallow drop (multiz).

	// Job-related variables.
	var/default_title = "Civilian"        // Default title for following job.
	var/default_job = /datum/job/civilian // Default job path (Assistant in SS13 terms)
	var/list/use_jobs = list()            // A list of all job paths that should be used for this map.
	var/list/exclude_jobs = list()        // Jobs to remove from the above list in various places.
	var/list/space_levels = list()        // List of levels that are open to space.

	var/motd_override = "Welcome to the server."

/datum/map/proc/do_roundstart_mapgen()
	return

/proc/layer_is_shallow(var/layer)
	return using_map && (layer in using_map.shallow_levels)

/*
	var/height = 1                                // The number of Z-Levels in the map.
	var/turf/edge_type                            // What the map edge should be formed with. (null = world.turf)
	var/list/mining_layers = list()               // As above, for randomly generated map application.
*/

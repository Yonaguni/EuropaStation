var/obj/effect/landmark/map_data/world_map

// This is quite heavily tied to the multiz system but also
// includes data used for determining jobs, some lore, etc.

/obj/effect/landmark/map_data
	name = "Unknown"
	desc = "An unknown location."
	invisibility = 101

	var/use_title_state = "yonaguni"
	var/height = 1                                // The number of Z-Levels in the map.
	var/turf/edge_type                            // What the map edge should be formed with. (null = world.turf)
	var/list/shallow_layers = list()              // A list of numerical indexes that are considered 'shallow'.
	var/list/mining_layers = list()               // As above, for randomly generated map application.

	var/default_title = "Civilian"
	var/default_job = /datum/job/civilian

	var/list/use_jobs = list(/datum/job/civilian) // A list of all types of jobs available on this map.
	var/list/exclude_jobs = list()                // Jobs to remove from the above list in various places.

	// Event reference data.
	var/drone_source = "Yonaguni Dome Nine"
	var/list/inhabited_levels = list(2)
	var/list/space_levels = list()

	var/motd_override

/obj/effect/landmark/map_data/New()
	..()
	if(world_map)
		world.log << "Duplicate world map data object [world_map] being overwritten by [src]."
	world_map = src

/proc/layer_is_shallow(var/layer)
	return world_map && (layer in world_map.shallow_layers)

/obj/effect/landmark/proc/do_roundstart_mapgen()
	return

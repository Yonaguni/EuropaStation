/area
	var/fire = null
	var/atmos = 1
	var/atmosalm = 0
	var/poweralm = 1
	var/party = null
	level = null
	name = "Unknown"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	layer = 10
	luminosity = 0
	mouse_opacity = 0
	var/lightswitch = 1

	var/eject = null

	var/debug = 0
	var/requires_power = 1
	var/always_unpowered = 0	//this gets overriden to 1 for space in area/New()

	var/power_equip = 1
	var/power_light = 1
	var/power_environ = 1
	var/used_equip = 0
	var/used_light = 0
	var/used_environ = 0

	var/has_gravity = 1
	var/obj/machinery/power/apc/apc = null
	var/no_air = null
//	var/list/lights				// list of all lights on this area
	var/list/all_doors = list()		//Added by Strumpetplaya - Alarm Change - Contains a list of doors adjacent to this area
	var/air_doors_activated = 0
	var/list/ambience = list('sound/ambience/ambigen1.ogg','sound/ambience/ambigen3.ogg','sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg','sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg','sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg','sound/ambience/ambigen12.ogg','sound/ambience/ambigen14.ogg')
	var/list/forced_ambience = null
	var/sound_env = STANDARD_STATION
	var/turf/base_turf //The base turf type of the area, which can be used to override the z-level's base turf
	var/no_teleport
	var/ignore_universe_changes
	var/holy

/*Adding a wizard area teleport list because motherfucking lag -- Urist*/
/*I am far too lazy to make it a proper list of areas so I'll just make it run the usual telepot routine at the start of the game*/
var/list/teleportlocs = list()

/hook/startup/proc/setupTeleportLocs()
	for(var/area/AR in world)
		if(AR.no_teleport)
			continue
		if(teleportlocs.Find(AR.name)) continue
		var/turf/picked = pick_area_turf(AR.type, list(/proc/is_station_turf))
		if (picked)
			teleportlocs += AR.name
			teleportlocs[AR.name] = AR

	teleportlocs = sortAssoc(teleportlocs)

	return 1

var/list/ghostteleportlocs = list()

/hook/startup/proc/setupGhostTeleportLocs()
	for(var/area/AR in world)
		if(!AR.x)
			continue
		if(ghostteleportlocs.Find(AR.name)) continue
		var/turf/picked = pick_area_turf(AR.type)
		if (picked)
			ghostteleportlocs[AR.name] = AR

	ghostteleportlocs = sortAssoc(ghostteleportlocs)

	return 1

/*-----------------------------------------------------------------------------*/

/////////
//SPACE//
/////////
/area/space
	name = "\improper Space"
	icon_state = "space"
	requires_power = 1
	always_unpowered = 1
	power_light = 0
	power_equip = 0
	power_environ = 0
	ambience = list('sound/ambience/ambispace.ogg')
	ignore_universe_changes = TRUE

/area/space/has_gravity()
	return 0

/area/space/updateicon()
	return

area/space/atmosalert()
	return

/area/space/fire_alert()
	return

/area/space/fire_reset()
	return

/area/space/readyalert()
	return

/area/space/partyalert()
	return

/area/arrival
	requires_power = 0

/area/arrival/start
	name = "\improper Arrival Area"
	icon_state = "start"

////////////
//SHUTTLES//
////////////
//shuttle areas must contain at least two areas in a subgroup if you want to move a shuttle from one
//place to another. Look at escape shuttle for example.
//All shuttles should now be under shuttle since we have smooth-wall code.

/area/shuttle
	requires_power = 0
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/space

// Centcomm - admin levels.
/area/centcom
	name = "\improper Centcom"
	icon_state = "centcom"
	requires_power = 0

/area/centcom/holding
	name = "\improper Holding Facility"

//Maintenance
/area/maintenance
	flags = RAD_SHIELDED
	sound_env = TUNNEL_ENCLOSED
	turf_initializer = new /datum/turf_initializer/maintenance()

// General hallways.
/area/hallway
	name = "\improper Hallway"
	sound_env = LARGE_ENCLOSED

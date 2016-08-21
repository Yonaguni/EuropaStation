/atom/proc/is_flooded(var/lying_mob, var/absolute) // code/modules/fluid/fluid_flooding.dm
	return

/mob/proc/handle_drowning()     // code/modules/fluid/fluid_drowning.dm
	return

/mob/proc/can_drown()           // code/modules/fluid/fluid_drowning.dm
	return 0

/atom/proc/water_act(var/depth) // code/modules/fluid/fluid_water_act.dm
	return

/turf/proc/return_fluid()       // code/modules/fluid/fluid_turf.dm
	return null

/turf/proc/check_fluid_depth(var/min)
	return 0

/turf/proc/get_fluid_depth()
	return 0

/datum/admins/proc/spawn_fluid_verb()
	set name = "Spawn Water"
	set desc = "Flood the turf you are standing on."
	set category = "Debug"
	if(!check_rights(R_SPAWN))	return
	spawn_fluid_proc()

/datum/admins/proc/spawn_fluid_proc()
	return

var/datum/controller/process/lighting/lighting_controller

/datum/controller/process/lighting
	var/list/update_turfs

/datum/controller/process/lighting/setup()
	name = "lighting controller"
	schedule_interval = 5 // This needs to run constantly. All we're doing is avoiding multiple updates per
	                      // tick from lighting, not really trying to effectively limit or reduce CPU load.
	update_turfs = list()
	lighting_controller = src

/datum/controller/process/lighting/doWork()
	for(var/thing in update_turfs)
		var/turf/T = thing
		T.update_light_overlays()
		SCHECK

/datum/controller/process/lighting/proc/mark_for_update(var/turf/marking)
	if(!istype(marking))
		return
	update_turfs |= marking

/datum/controller/process/lighting/statProcess()
	..()
	stat(null, "[update_turfs.len]")

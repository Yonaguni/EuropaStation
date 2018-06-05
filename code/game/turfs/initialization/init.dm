/datum/area_initializer/proc/initialize(var/turf/T)
	return

/datum/area_initializer/proc/post_init()
	return

/area
	var/datum/area_initializer/turf_initializer = null

/area/LateInitialize()
	if(turf_initializer)
		for(var/turf/simulated/T in src)
			turf_initializer.initialize(T)
		turf_initializer.post_init()

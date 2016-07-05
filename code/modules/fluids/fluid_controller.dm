// Lots of this will be copied from the linda controller.
var/global/datum/controller/process/fluids/fluid_master

/datum/controller/process/fluids
	var/list/active_turfs = list()
	var/list/water_sources = list()
	var/current_cycle = 0
	var/kill_water

/datum/controller/process/fluids/setup()
	name = "fluids"
	schedule_interval = 8
	fluid_master = src

/datum/controller/process/fluids/statProcess()
	..()
	stat(null, "[active_turfs.len] active turfs")

/datum/controller/process/fluids/doWork()
	if(kill_water)
		return 1
	current_cycle++
	// Process water sources.
	/*
	for(var/turf/simulated/T in water_sources)
		T.flood_neighbors()
		SCHECK
	*/
	// Process general fluid spread/equalizing.
	for(var/turf/simulated/T in active_turfs)
		T.process_fluids()
		scheck()
	return 1

/datum/controller/process/fluids/proc/add_to_active(var/turf/simulated/T)
	if(istype(T))
		T.need_fluid_update = 1
		if(T.flooded)
			water_sources |= T
		else
			active_turfs |= T

var/global/datum/controller/process/air_system/air_master

/datum/controller/process/air_system
	var/list/active_turfs = list()

/datum/controller/process/air_system/setup()
	name = "air"
	schedule_interval = 5
	air_master = src
	module_controllers["Atmosphere"] = air_master

/datum/controller/process/air_system/doWork()
	for(var/turf/T in active_turfs)
		T.process_cell()
		scheck()
	return 1

/datum/controller/process/air_system/statProcess()
	..()
	stat(null, "[active_turfs.len] active turfs")

/datum/controller/process/air_system/proc/add_to_active(var/turf/simulated/T)
	if(istype(T) && !(T in active_turfs))
		active_turfs += T

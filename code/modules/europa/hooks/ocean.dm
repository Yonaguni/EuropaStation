/proc/do_ocean_initialisation()
	for(var/turf/unsimulated/ocean/O in turfs)
		sleep(-1)
		O.initialize()
	return 1

/datum/admins/proc/force_turf_init()
	set category = "Debug"
	set desc = "Force a worldwide turf update."
	set name = "Force Turf Init"

	do_ocean_initialisation()
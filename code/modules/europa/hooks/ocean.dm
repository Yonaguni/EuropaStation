/hook/startup/proc/do_ocean_initialisation()
	for(var/turf/unsimulated/ocean/O in turfs)
		sleep(-1)
		O.initialize()
	return 1
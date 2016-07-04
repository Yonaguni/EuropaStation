var/global/datum/controller/process/air_system/air_master

/datum/controller/process/air_system
	var/list/active_turfs = list()
	var/list/hotspots = list()
	var/list/turf/simulated/high_pressure_delta = list()
	var/kill_air = 0

	var/current_cycle = 0
	var/failed_ticks = 0
	var/tick_progress = 0

/datum/controller/process/air_system/setup()
	name = "air"
	schedule_interval = 5
	air_master = src

/datum/controller/process/air_system/doWork()
	if(kill_air)
		return 1
	current_cycle++

	for(var/turf/simulated/T in active_turfs)
		T.process_cell()
		scheck()

	for(var/turf/T in high_pressure_delta)
		T.high_pressure_movements()
		T.air_pressure_difference = 0
	high_pressure_delta.Cut()

	scheck()

	for(var/obj/effect/hotspot/H in hotspots)
		H.process()
		scheck()

	return 1

/datum/controller/process/air_system/statProcess()
	..()
	stat(null, "[active_turfs.len] active turfs")

/datum/controller/process/air_system/proc/add_to_active(var/turf/simulated/T, var/blockchanges = 1)

	if(istype(T))
		if(!T.air)
			T.make_air()
		if(T.air)
			active_turfs |= T
		return

	for(var/direction in cardinal)
		if(!(T.atmos_adjacent_turfs & direction))
			continue
		var/turf/simulated/S = get_step(T, direction)
		if(istype(S))
			add_to_active(S)

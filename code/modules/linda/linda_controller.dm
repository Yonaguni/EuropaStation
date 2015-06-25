var/kill_air = 0

var/global/datum/controller/process/air_system/air_master

/datum/controller/process/air_system
	var/list/excited_groups = list()
	var/list/active_turfs = list()
	var/list/hotspots = list()
	var/list/air_overlay_cache = list()

	//Special functions lists
	var/list/turf/simulated/active_super_conductivity = list()
	var/list/turf/simulated/high_pressure_delta = list()

	var/current_cycle = 0
	var/failed_ticks = 0
	var/tick_progress = 0

/datum/controller/process/air_system/setup()
	name = "air"
	schedule_interval = 20
	air_master = src

	admin_notice("<span class='danger'>Processing geometry...</span>")
	var/start_time = world.timeofday
	setup_allturfs()
	admin_notice("<span class='danger'>Geometry processed in [(world.timeofday-start_time)/10] seconds!</span>")

/datum/controller/process/air_system/doWork()
	if(kill_air)
		return 1
	current_cycle++
	process_active_turfs()
	process_excited_groups()
	scheck()
	process_high_pressure_delta()
	process_hotspots()
	process_super_conductivity()
	scheck()
	return 1

/datum/controller/process/air_system/getStatName()
	return ..()+"([active_turfs.len])"

/datum/controller/process/air_system/proc/process_hotspots()
	for(var/obj/effect/hotspot/H in hotspots)
		H.process()

/datum/controller/process/air_system/proc/process_super_conductivity()
	for(var/turf/simulated/T in active_super_conductivity)
		T.super_conduct()

/datum/controller/process/air_system/proc/process_high_pressure_delta()
	for(var/turf/T in high_pressure_delta)
		T.high_pressure_movements()
		T.pressure_difference = 0
	high_pressure_delta.len = 0

/datum/controller/process/air_system/proc/process_active_turfs()
	for(var/turf/simulated/T in active_turfs)
		T.process_cell()

/datum/controller/process/air_system/proc/remove_from_active(var/turf/simulated/T)
	if(istype(T))
		T.excited = 0
		active_turfs -= T
		if(T.excited_group)
			T.excited_group.garbage_collect()

/datum/controller/process/air_system/proc/add_to_active(var/turf/simulated/T, var/blockchanges = 1)
	if(istype(T) && T.air)
		T.excited = 1
		active_turfs |= T
		if(blockchanges && T.excited_group)
			T.excited_group.garbage_collect()
	else
		for(var/direction in cardinal)
			if(!(T.atmos_adjacent_turfs & direction))
				continue
			var/turf/simulated/S = get_step(T, direction)
			if(istype(S))
				add_to_active(S)

/datum/controller/process/air_system/proc/setup_allturfs(var/turfs_in = world)
	for(var/turf/simulated/T in turfs_in)
		var/datum/gas_mixture/my_air = T.return_air()
		if(!my_air) continue
		T.CalculateAdjacentTurfs()
		if(!T.blocks_air)
			if(my_air.check_tile_graphic())
				T.update_visuals(my_air)
			for(var/direction in cardinal)
				if(!(T.atmos_adjacent_turfs & direction))
					continue
				var/turf/enemy_tile = get_step(T, direction)
				if(istype(enemy_tile,/turf/simulated/))
					var/turf/simulated/enemy_simulated = enemy_tile
					if(!my_air.compare(enemy_simulated.air))
						T.excited = 1
						active_turfs |= T
						break
				else
					T.excited = 1
					active_turfs |= T

/datum/controller/process/air_system/proc/process_excited_groups()
	for(var/datum/excited_group/EG in excited_groups)
		EG.breakdown_cooldown ++
		if(EG.breakdown_cooldown == 10)
			EG.self_breakdown()
			return
		if(EG.breakdown_cooldown > 20)
			EG.dismantle()

/turf/proc/make_flooded()
	if(!fluid_master)
		return
	if(!flooded)
		flooded = 1
		update_icon()

/turf/proc/flood_neighbors()
	if(need_fluid_recalc)
		update_fluid_neighbors()

	if(fluid_adjacent_turfs_amount == 0)
		fluid_master.water_sources -= src
		return

	for(var/step_dir in fluid_dirs)
		if(!(fluid_adjacent_turfs & step_dir))
			continue
		var/turf/simulated/T = get_step(src, step_dir)
		if(istype(T))
			var/datum/gas_mixture/fluid/GM = T.return_fluids()
			if(GM && GM.gas["water"] < 1500)
				GM.adjust_gas("water", 1500, 1)
				T.fluid_update_turf()

/turf/proc/update_fluid_neighbors()

	// Check for dirs that are blocked due to something in our turf.
	var/blocked_dirs = 0
	for(var/obj/structure/window/W in src)
		blocked_dirs |= W.dir
	for(var/obj/machinery/door/window/D in src)
		blocked_dirs |= D.dir

	fluid_adjacent_turfs_amount = 0
	fluid_adjacent_turfs = 0

	for(var/step_dir in fluid_dirs)
		if(blocked_dirs & step_dir)
			continue
		var/turf/simulated/T = get_step(src, step_dir)
		if(!istype(T) || !CanFluidPass(T))
			continue
		fluid_adjacent_turfs_amount++
		fluid_adjacent_turfs |= step_dir

	need_fluid_recalc = 0

/obj/effect/fluid/var/list/equalizing_fluids = list()
/obj/effect/fluid/var/equalize_avg_depth = 0

/obj/effect/fluid/proc/spread()
	if(!loc || loc != start_loc || fluid_amount <= FLUID_EVAPORATION_POINT)
		return

	equalizing_fluids = list(src)
	for(var/spread_dir in cardinal)
		if(start_loc.get_fluid_blocking_dirs() & spread_dir)
			continue
		var/turf/T = get_step(start_loc, spread_dir)
		if(!istype(T) || T.flooded || (T.get_fluid_blocking_dirs() & reverse_dir[spread_dir]) || !T.CanFluidPass())
			continue
		var/obj/effect/fluid/F = locate() in T.contents
		if(F)
			if(F.fluid_amount <= FLUID_DELETING)
				continue
		if(!F)
			F = new /obj/effect/fluid(T)
		equalizing_fluids += F

/obj/effect/fluid/proc/equalize()
	if(!loc || loc != start_loc || fluid_amount <= FLUID_EVAPORATION_POINT)
		return

	equalize_avg_depth = 0
	for(var/obj/effect/fluid/F in equalizing_fluids)
		if(!istype(F) || F.fluid_amount <= FLUID_DELETING)
			equalizing_fluids -= F
			continue
		equalize_avg_depth += F.fluid_amount
	if(islist(equalizing_fluids) && equalizing_fluids.len > 1)
		equalize_avg_depth = Floor(equalize_avg_depth/equalizing_fluids.len)
		if(!equalize_avg_depth)
			return
		for(var/thing in equalizing_fluids)
			var/obj/effect/fluid/F = thing
			F.set_depth(equalize_avg_depth)
	equalizing_fluids.Cut()

var/datum/controller/subsystem/fluids/SSfluids

/datum/controller/subsystem/fluids
	name = "Fluids"
	wait = 6
	flags = SS_NO_INIT

	var/next_water_act = 0
	var/water_act_delay = 15 // A bit longer than machines.

	var/list/active_fluids = list()
	var/list/water_sources = list()

	var/tmp/list/processing_sources
	var/tmp/list/processing_fluids

	var/tmp/active_fluids_copied_yet = FALSE
	var/af_index = 1
	var/downward_fluid_overlay_position = 1 // Bit of an odd hack, set in fluid spread code to determine which overlay \
	                                        // in the list is 'down'. More maintainer-friendly than hardcoding it.
	var/flooded_a_neighbor = 0              // not actually used, defined so the neighbor flood macro compiles/runs properly.


/datum/controller/subsystem/fluids/New()
	NEW_SS_GLOBAL(SSfluids)

/datum/controller/subsystem/fluids/stat_entry()
	..("A:[active_fluids.len] S:[water_sources.len]")

/datum/controller/subsystem/fluids/fire(resumed = 0)
	if (!resumed)
		processing_sources = water_sources.Copy()
		active_fluids_copied_yet = FALSE
		af_index = 1

	var/list/curr_sources = processing_sources
	while (curr_sources.len)
		var/turf/T = curr_sources[curr_sources.len]
		curr_sources.len--

		FLOOD_TURF_NEIGHBORS(T, FALSE)

		if (MC_TICK_CHECK)
			return

	if (!active_fluids_copied_yet)
		active_fluids_copied_yet = TRUE
		processing_fluids = active_fluids.Copy()
	// We need to iterate through this list a few times, so we're using indexes instead of a while-truncate loop.

	while (af_index <= processing_fluids.len)
		var/obj/effect/fluid/F = processing_fluids[af_index++]
		if (QDELETED(F))
			processing_fluids -= F
		else
			// Spread out and collect neighbors for equalizing later. Hardcoded here for performance reasons.
			if(!F.loc || F.loc != F.start_loc || !F.loc.CanFluidPass())
				qdel(F)
				continue

			if(F.fluid_amount <= FLUID_EVAPORATION_POINT)
				continue

			F.equalizing_fluids = list(F)

			// Flood downwards if there's open space below us.
			if(HasBelow(F.z))
				var/turf/current = get_turf(F)
				if(current.open_space)
					var/turf/T = GetBelow(F)
					var/obj/effect/fluid/other = locate() in T
					if(!istype(other) || other.fluid_amount < FLUID_MAX_DEPTH)
						if(!other)
							other = new /obj/effect/fluid(T)
						F.equalizing_fluids += other
						downward_fluid_overlay_position = F.equalizing_fluids.len
			UPDATE_FLUID_BLOCKED_DIRS(F.start_loc)
			for(var/spread_dir in cardinal)
				if(F.start_loc.fluid_blocked_dirs & spread_dir)
					continue
				var/turf/T = get_step(F.start_loc, spread_dir)
				var/coming_from = reverse_dir[spread_dir]
				if(!istype(T) || T.flooded)
					continue
				UPDATE_FLUID_BLOCKED_DIRS(T)
				if((T.fluid_blocked_dirs & coming_from) || !T.CanFluidPass(coming_from))
					continue
				var/obj/effect/fluid/other = locate() in T.contents
				if(other && (QDELETED(other) || other.fluid_amount <= FLUID_DELETING))
					continue
				if(!other)
					other = new /obj/effect/fluid(T)
					other.temperature = F.temperature
				F.equalizing_fluids += other

		if (MC_TICK_CHECK)
			return

	af_index = 1

	while (af_index <= processing_fluids.len)
		var/obj/effect/fluid/F = processing_fluids[af_index++]
		if (QDELETED(F))
			processing_fluids -= F
		else
			// Equalize across our neighbors. Hardcoded here for performance reasons.
			if(!F.loc || F.loc != F.start_loc || !F.equalizing_fluids || !F.equalizing_fluids.len || F.fluid_amount <= FLUID_EVAPORATION_POINT)
				continue

			F.equalize_avg_depth = 0
			F.equalize_avg_temp = 0

			// Flow downward first, since gravity. TODO: add check for gravity.
			if(F.equalizing_fluids.len >= downward_fluid_overlay_position)
				var/obj/effect/fluid/downward_fluid = F.equalizing_fluids[downward_fluid_overlay_position]
				if(downward_fluid.z == F.z-1) // It's below us.
					F.equalizing_fluids -= downward_fluid
					var/transfer_amount = min(F.fluid_amount, (FLUID_MAX_DEPTH-downward_fluid.fluid_amount))
					if(transfer_amount > 0)
						SET_FLUID_DEPTH(downward_fluid, downward_fluid.fluid_amount + transfer_amount)
						LOSE_FLUID(F, transfer_amount)
						if(F.fluid_amount <= FLUID_EVAPORATION_POINT)
							continue

			for(var/obj/effect/fluid/other in F.equalizing_fluids)
				if(!istype(other) || QDELETED(other) || other.fluid_amount <= FLUID_DELETING)
					F.equalizing_fluids -= other
					continue
				F.equalize_avg_depth += other.fluid_amount
				F.equalize_avg_temp += other.temperature
			if(islist(F.equalizing_fluids) && F.equalizing_fluids.len > 1)
				F.equalize_avg_depth = Floor(F.equalize_avg_depth/F.equalizing_fluids.len)
				F.equalize_avg_temp = Floor(F.equalize_avg_temp/F.equalizing_fluids.len)
				for(var/thing in F.equalizing_fluids)
					var/obj/effect/fluid/other = thing
					if(!QDELETED(other))
						SET_FLUID_DEPTH(other, F.equalize_avg_depth)
						other.temperature = F.equalize_avg_temp
			F.equalizing_fluids.Cut()
			if(istype(F.loc, /turf/space))
				LOSE_FLUID(F, max((FLUID_EVAPORATION_POINT-1),F.fluid_amount * 0.5))

		if (MC_TICK_CHECK)
			return

	af_index = 1

	while (af_index <= processing_fluids.len)
		var/obj/effect/fluid/F = processing_fluids[af_index++]
		if (QDELETED(F))
			processing_fluids -= F
		else
			if (!F.loc || F.loc != F.start_loc)
				qdel(F)

			if (F.fluid_amount <= FLUID_EVAPORATION_POINT & prob(10))
				LOSE_FLUID(F, rand(1, 3))

			if (F.fluid_amount <= FLUID_DELETING)
				qdel(F)
			else
				F.update_icon()

		if (MC_TICK_CHECK)
			return

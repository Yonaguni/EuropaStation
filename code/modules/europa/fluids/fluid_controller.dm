var/datum/controller/process/fluids/fluid_master

/datum/controller/process/fluids
	var/list/active_fluids = list()
	var/list/water_sources = list()
	var/next_water_act = 0
	var/water_act_delay = 15 // A bit longer than machines.

/datum/controller/process/fluids/setup()
	name = "fluids"
	schedule_interval = 3
	fluid_master = src

/datum/controller/process/fluids/statProcess()
	..()
	stat(null, "[active_fluids.len] active fluids, [water_sources.len] fluid sources")

/datum/controller/process/fluids/doWork()
	// Process water sources.
	for(var/thing in water_sources)
		var/turf/T = thing
		if(T) T.flood_neighbors()
		SCHECK

 	// Process general fluid spread.
	var/list/spreading_fluids = active_fluids.Copy()
	for(var/thing in spreading_fluids)
		var/obj/effect/fluid/F = thing
		if(F) F.spread()
		SCHECK

	// Equalize fluids.
	for(var/thing in spreading_fluids)
		if(!(thing in active_fluids)) continue
		var/obj/effect/fluid/F = thing
		if(F) F.equalize()
		SCHECK
	spreading_fluids.Cut()

	// Update icons and update things in water.
	for(var/thing in active_fluids)
		var/obj/effect/fluid/F = thing
		if(F)
			if(!F.loc || F.loc != F.start_loc)
				qdel(F)
			if(F.fluid_amount <= FLUID_EVAPORATION_POINT && prob(10))
				F.lose_fluid(rand(1,3))
			if(F.fluid_amount <= FLUID_DELETING)
				qdel(F)
			else
				F.update_icon()
		SCHECK

	// Sometimes, call water_act().
	if(world.time >= next_water_act)
		next_water_act = world.time + water_act_delay
		for(var/thing in active_fluids)
			for(var/other_thing in get_turf(thing))
				var/atom/A = other_thing
				if(A.simulated)
					var/obj/effect/fluid/F = thing
					A.water_act(F.fluid_amount)
		SCHECK

	return 1

/datum/controller/process/fluids/proc/add_active_source(var/turf/T)
	if(istype(T) && !(T in water_sources))
		water_sources += T

/datum/controller/process/fluids/proc/remove_active_source(var/turf/T)
	if(istype(T) && (T in water_sources))
		water_sources -= T

/datum/controller/process/fluids/proc/add_active_fluid(var/obj/effect/fluid/F)
	if(istype(F) && !(F in active_fluids))
		active_fluids += F

/datum/controller/process/fluids/proc/remove_active_fluid(var/obj/effect/fluid/F)
	if(istype(F) && (F in active_fluids))
		active_fluids -= F

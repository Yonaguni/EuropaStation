var/datum/controller/process/fluids/fluid_master

/datum/controller/process/fluids
	var/list/active_fluids = list()
	var/list/water_sources = list()

/datum/controller/process/fluids/setup()
	name = "fluids"
	schedule_interval = 5
	fluid_master = src

/datum/controller/process/fluids/statProcess()
	..()
	stat(null, "[active_fluids.len] active fluids, [water_sources.len] fluid sources")

/datum/controller/process/fluids/doWork()
	// Process water sources.
	for(var/thing in water_sources)
		var/turf/T = thing
		T.flood_neighbors()
		scheck()

 	// Process general fluid spread.
	var/list/spreading_fluids = active_fluids.Copy()
	for(var/thing in spreading_fluids)
		var/obj/effect/fluid/F = thing
		F.spread()
		scheck()

	// Equalize fluids.
	for(var/thing in spreading_fluids)
		if(!(thing in active_fluids))
			continue
		var/obj/effect/fluid/F = thing
		F.equalize()
		scheck()
	spreading_fluids.Cut()

	// Update icons!
	for(var/thing in active_fluids)
		var/obj/effect/fluid/F = thing
		if(!F.loc || F.loc != F.start_loc)
			qdel(F)
		if(F.fluid_amount <= FLUID_EVAPORATION_POINT)
			F.lose_fluid(rand(1,5))
		if(F.fluid_amount <= FLUID_DELETING)
			qdel(F)
		else
			F.update_icon()
		scheck()
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

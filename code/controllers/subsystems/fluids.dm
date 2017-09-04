// redefining these here because I don't want to move this into the fluids folder.
#define FLUID_EVAPORATION_POINT 3          // Depth a fluid begins self-deleting
#define FLUID_DELETING -1                  // Depth a fluid counts as qdel'd

/var/datum/controller/subsystem/fluids/fluid_master	// should be renamed to SSfluid or something eventually

/datum/controller/subsystem/fluids
	name = "Fluids"
	wait = 3
	flags = SS_NO_INIT

	var/next_water_act = 0
	var/water_act_delay = 15 // A bit longer than machines.

	var/list/active_fluids = list()
	var/list/water_sources = list()

	var/tmp/list/processing_sources
	var/tmp/list/processing_fluids

	var/tmp/active_fluids_copied_yet = FALSE
	var/af_index = 1

/datum/controller/subsystem/fluids/New()
	NEW_SS_GLOBAL(fluid_master)

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

		T.flood_neighbors()

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
			F.spread()

		if (MC_TICK_CHECK)
			return

	af_index = 1

	while (af_index <= processing_fluids.len)
		var/obj/effect/fluid/F = processing_fluids[af_index++]
		if (QDELETED(F))
			processing_fluids -= F
		else
			F.equalize()

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
				F.lose_fluid(rand(1, 3))

			if (F.fluid_amount <= FLUID_DELETING)
				qdel(F)
			else
				F.update_icon()

		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/fluids/proc/add_active_source(turf/T)
	if(istype(T) && !(T in water_sources))
		water_sources += T

/datum/controller/subsystem/fluids/proc/remove_active_source(turf/T)
	if(istype(T) && (T in water_sources))
		water_sources -= T

/datum/controller/subsystem/fluids/proc/add_active_fluid(obj/effect/fluid/F)
	if(istype(F) && !(F in active_fluids))
		active_fluids += F

/datum/controller/subsystem/fluids/proc/remove_active_fluid(obj/effect/fluid/F)
	if(istype(F) && (F in active_fluids))
		active_fluids -= F

#undef FLUID_EVAPORATION_POINT
#undef FLUID_DELETING

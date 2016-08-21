/turf
	var/obj/effect/gas_overlay/gas_overlay

/turf
	var/datum/gas_mixture/air
	var/list/initial_air

/turf/assume_air() //use this for machines to adjust air
	return

/turf/return_air()
	return

/turf/remove_air(amount as num)
	return

/turf/simulated/assume_air()
	return

/turf/proc/make_air()
	return

/turf/simulated/initialize()
	..()
	if(!is_flooded(absolute=1) && initial_air && initial_air.len)
		make_air()
		air_update()

/turf/proc/process_cell()
	if(air_master)
		air_master.active_turfs -= src

/turf/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0)
	if(gas_overlay)
		qdel(gas_overlay)
		gas_overlay = null
	. = ..()
	air_update()

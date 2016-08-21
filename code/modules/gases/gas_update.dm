//Convenience function for atoms to update turfs they occupy
/atom/movable/update_nearby_tiles()
	air_update()
	return 1

/obj/structure/Destroy()
	air_update()
	return ..()

/obj/structure/Move()
	..()
	air_update()

/obj/structure/initialize()
	..()
	air_update()

/obj/effect/Move()
	. = ..()
	air_update()

/obj/effect/Destroy()
	air_update()
	return ..()

/obj/effect/initialize()
	..()
	air_update()

/atom/proc/air_update()
	blocks_air = null

/atom/movable/air_update()
	. = ..()
	var/turf/baseturf = get_turf(src)
	if(istype(baseturf))
		baseturf.air_update()

/turf/air_update(var/ignore_neighbors)
	. = ..()
	CalculateAdjacentTurfs()
	if(!ignore_neighbors)
		for(var/checkdir in cardinal)
			if(!(atmos_adjacent_turfs & checkdir))
				continue
			var/turf/T = get_step(src, checkdir)
			if(T) T.air_update(1)
	if(air_master)
		air_master.add_to_active(src,command)

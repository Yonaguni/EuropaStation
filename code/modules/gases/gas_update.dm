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
	return

/atom/movable/air_update()
	. = ..()
	var/turf/baseturf = get_turf(src)
	if(istype(baseturf))
		baseturf.air_update()

/turf/air_update(var/ignore_neighbors)
	. = ..()
	if(air_master)
		air_master.add_to_active(src)

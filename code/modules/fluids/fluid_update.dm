/atom/movable/update_nearby_tiles(var/need_rebuild)
	. = ..(need_rebuild)
	fluid_update()

/obj/structure/Destroy()
	var/turf/T = get_turf(src)
	. = ..()
	if(istype(T))
		T.fluid_update()

/obj/structure/Move()
	. = ..()
	fluid_update()

/obj/structure/New()
	. = ..()
	fluid_update()

/obj/effect/Move()
	. = ..()
	fluid_update()

/obj/effect/Destroy()
	var/turf/T = get_turf(src)
	. = ..()
	if(istype(T))
		T.fluid_update()

/obj/effect/New()
	. = ..()
	fluid_update()

/atom/proc/fluid_update()
	var/turf/T = get_turf(src)
	if(istype(T))
		T.fluid_update()

/turf/fluid_update(var/ignore_neighbors)

	fluid_blocked_dirs = null
	fluid_can_pass = null

	// Wake up our neighbors.
	if(!ignore_neighbors)
		for(var/checkdir in cardinal)
			var/turf/T = get_step(src, checkdir)
			if(T) T.fluid_update(1)

	// Wake up ourself!
	if(flooded)
		var/flooded_a_neighbor = 0
		FLOOD_TURF_NEIGHBORS(src, TRUE)
		if(flooded_a_neighbor)
			ADD_ACTIVE_FLUID_SOURCE(src)
	else
		REMOVE_ACTIVE_FLUID_SOURCE(src)
		for(var/obj/effect/fluid/F in src)
			ADD_ACTIVE_FLUID(F)

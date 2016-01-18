//Convenience function for atoms to update turfs they occupy
/atom/movable/proc/update_nearby_tiles(need_rebuild)
	if(!air_master)
		return 0
	air_update_turf()
	return 1

/atom/movable/proc/air_update_turf(var/command = 0)
	var/turf/baseturf = loc
	if(istype(baseturf))
		baseturf.air_update_turf(command)
	if(command)
		for(var/turf/T in locs)
			T.air_update_turf(command)

/turf/proc/air_update_turf(var/command = 0)
	if(command)
		CalculateAdjacentTurfs()
	if(air_master)
		air_master.add_to_active(src,command)

/turf/simulated/air_update_turf(var/command = 0)
	liquid = -1
	..(command)

/atom/movable/proc/move_update_air(var/turf/T)
    if(istype(T,/turf))
        T.air_update_turf(1)
    air_update_turf(1)

/obj/structure/Destroy()
	var/atom/A = loc
	..()
	if(istype(A, /turf))
		var/turf/T = A
		T.air_update_turf(1)
	else if(istype(A, /atom/movable))
		var/atom/movable/AM = A
		AM.air_update_turf(1)

/obj/structure/Move()
	var/turf/T = loc
	..()
	move_update_air(T)

/obj/structure/New()
	..()
	air_update_turf(1)

/obj/effect/Move()
	var/turf/T = loc
	..()
	move_update_air(T)

/obj/effect/Destroy()
	var/atom/A = loc
	..()
	if(istype(A, /turf))
		var/turf/T = A
		T.air_update_turf(1)
	else if(istype(A, /atom/movable))
		var/atom/movable/AM = A
		AM.air_update_turf(1)

/obj/effect/New()
	..()
	air_update_turf(1)

/obj/update_nearby_tiles(need_rebuild)
	. = ..(need_rebuild)
	air_update_turf(1)

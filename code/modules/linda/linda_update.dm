/turf/simulated/New()
	..()
	air_update_turf(1)

/obj/structure/Destroy()
	air_update_turf(1)
	..()

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
	air_update_turf(1)
	return ..()

/obj/effect/New()
	..()
	air_update_turf(1)

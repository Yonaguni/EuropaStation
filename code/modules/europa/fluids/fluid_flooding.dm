/turf/proc/make_flooded()
	if(!flooded)
		flooded = 1
		for(var/obj/effect/fluid/F in src)
			qdel(F)
		update_icon()

/atom/movable/is_flooded(var/lying_mob, var/absolute)
	var/turf/T = get_turf(src)
	return T.is_flooded(lying_mob)

/turf/is_flooded(var/lying_mob, var/absolute)
	return (flooded || (!absolute && check_fluid_depth(lying_mob ? FLUID_SHALLOW : FLUID_DEEP)))

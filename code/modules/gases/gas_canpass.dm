/atom/proc/CanAtmosPass(var/turf/T)
	return !density

/turf/CanAtmosPass(var/turf/T)
	if(blocks_air)
		return 0
	if(istype(T))
		if(T.blocks_air)
			return 0
	for(var/obj/O in contents)
		if(!O.CanAtmosPass(T))
			return 0
	for(var/obj/O in T.contents)
		if(!O.CanAtmosPass(src))
			return 0
	if(z > T.z)
		return open_space
	else if(z < T.z)
		return T.open_space
	return 1

/obj/structure/aquarium/CanAtmosPass(turf/T)
	return !!(locate(/obj/structure/aquarium) in T)

/obj/machinery/door/window/CanAtmosPass(var/turf/T)
	if(get_dir(loc, T) == dir)
		return !density
	return 1

/obj/structure/window/CanAtmosPass(turf/T)
	if(get_dir(loc, T) == dir || dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		return !density
	return 1

/obj/structure/windoor_assembly/CanAtmosPass(var/turf/T)
	if(get_dir(loc, T) == dir)
		return !density
	return 1


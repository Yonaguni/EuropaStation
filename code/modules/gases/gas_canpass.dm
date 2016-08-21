/atom/proc/CanAtmosPass(var/turf/target)
	return !density

/turf/CanAtmosPass(var/turf/target)
	if(density)
		return 0
	for(var/atom/movable/AM in contents)
		if(!AM.CanAtmosPass(target))
			return 0
	if(istype(target))
		if(z > target.z)
			return open_space
		else if(z < target.z)
			return target.open_space
	return 1

/obj/structure/aquarium/CanAtmosPass(var/turf/target)
	return !!(locate(/obj/structure/aquarium) in target)

/obj/machinery/door/window/CanAtmosPass(var/turf/target)
	if(istype(target) && get_dir(loc, target) == dir)
		return !density
	return 1

/obj/structure/window/CanAtmosPass(var/turf/target)
	if(get_dir(loc, target) == dir || dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		return !density
	return 1

/obj/structure/windoor_assembly/CanAtmosPass(var/turf/target)
	if(get_dir(loc, target) == dir)
		return !density
	return 1

/atom/proc/blocks_air(var/turf/target)
	return CanAtmosPass(target)

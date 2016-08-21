/atom/proc/CanAtmosPass(var/turf/target)
	return !density

/turf/CanAtmosPass(var/turf/target)
	if(blocks_air(target))
		return 0
	if(T.blocks_air(target))
		return 0
	if(istype(target))
		if(z > target.z)
			return open_space
		else if(z < target.z)
			return T.open_space
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

/atom/var/blocks_air

/atom/proc/blocks_air(var/turf/target)
	if(isnull(blocks_air))
		blocks_air = CanAtmosPass(target)
	return blocks_air

/turf/blocks_air(var/turf/target)
	if(isnull(blocks_air)
		for(var/atom/movable/AM in contents)
			if(!O.CanAtmosPass(target))
				blocks_air = 1
				return 1
	return ..()

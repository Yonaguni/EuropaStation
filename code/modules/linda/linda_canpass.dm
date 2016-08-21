/turf/proc/CanAtmosPass(var/turf/T)
	if(!istype(T))
		return 0

	// Check if air can pass either of these turfs in any way.
	if(blocks_air || T.blocks_air)
		return 0

	// Check if there is anything blocking air movement in contents.
	for(var/obj/O in contents)
		if(!O.CanAtmosPass(T))
			return 0
	for(var/obj/O in T.contents)
		if(!O.CanAtmosPass(src))
			return 0

	// Can air flow through the floor?
	if(z > T.z)
		if(!open_space && !(locate(/obj/structure/ladder) in contents))
			return 0
	// Can air flow through the roof?
	else if(z < T.z)
		if(!T.open_space && !(locate(/obj/structure/ladder) in T.contents))
			return 0

	return 1

/atom/movable/proc/CanAtmosPass(var/turf/T)
	return 1


/turf/proc/CanFluidPass(var/turf/simulated/target)
	if (!target || target.density || !Adjacent(target))
		return 0
	if(get_dir(src, target) == DOWN && !src.open_space)
		return 0
	for(var/obj/O in target.contents)
		if(!O.CanAtmosPass(src))
			return 0
	return 1

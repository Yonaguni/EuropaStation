/turf/proc/CanFluidPass(var/turf/simulated/target)
	if (!target || target.density || !Adjacent(target))
		return 0
	var/targetdir = get_dir(src, target)
	if(targetdir == UP)
		return
	if(targetdir == DOWN && !src.open_space)
		return 0
	for(var/obj/O in target.contents)
		if(!O.CanAtmosPass(src))
			return 0
	return 1

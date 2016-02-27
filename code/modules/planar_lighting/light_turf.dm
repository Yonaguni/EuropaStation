/turf/proc/blocks_light()
	if(opacity)
		return 1
	for(var/atom/movable/AM in contents) // TODO make this a turf var.
		if(AM.opacity)
			return 1
	return 0

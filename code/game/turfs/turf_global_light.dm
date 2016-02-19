/turf/var/outside

/turf/initialize()
	if(!blocks_air && !density)
		var/area/A = get_area(src)
		if(A.outside)
			outside = 1
	return ..()

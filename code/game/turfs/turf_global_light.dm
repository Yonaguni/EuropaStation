/turf/var/outside

/turf/initialize()
	if(!density)
		var/area/A = get_area(src)
		if(A.outside)
			outside = 1
	return ..()

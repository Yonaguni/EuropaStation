/proc/is_holy(var/turf/T)
	return T && T.loc && istype(T.loc, /area/chapel)
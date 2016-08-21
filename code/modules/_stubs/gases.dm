/atom/proc/assume_air()
	return null

/atom/proc/remove_air(var/amount)
	return null

/atom/proc/return_air()
	if(loc)
		return loc.return_air()
	return null

/turf/proc/return_gas_list()
	return list()

/turf/proc/get_temperature()
	return T0C


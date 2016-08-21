/atom/proc/assume_air()
	return null

/atom/proc/remove_air(var/amount)
	return null

/atom/proc/return_air()
	if(loc)
		return loc.return_air()
	return null

/atom/proc/return_pressure()
	if(loc)
		return loc.return_pressure()
	return null

/atom/proc/return_gas_list()
	return list()

/atom/proc/has_gas(var/gas_type, var/min=1)
	return 1

/atom/proc/get_temperature()
	return T0C

/atom/proc/adjust_gas()
	return
/area
	var/obj/machinery/power/apc/apc    // Area APC reference.
	var/requires_power = 1             // Does the area require power for machinery?
	var/always_unpowered = 0	       // Can the area be powered? This gets overriden to 1 for space in area/New()
	var/power_equip = 1                // Is equipment power channel enabled?
	var/power_light = 1                // Is lighting power channel enabled?
	var/power_environ = 1              // Is environment power channel enabled?
	var/used_equip = 0                 // Holder for calculating area equipment power usage.
	var/used_light = 0                 // Holder for calculating area lighting power usage.
	var/used_environ = 0               // Holder for calculating area environment power usage.

/area/proc/powered(var/chan)		// return true if the area has power to given channel

	if(!requires_power)
		return 1
	if(always_unpowered)
		return 0
	switch(chan)
		if(EQUIP)
			return power_equip
		if(LIGHT)
			return power_light
		if(ENVIRON)
			return power_environ

	return 0

// called when power status changes
/area/proc/power_change()
	for(var/obj/machinery/M in src)	// for each machine in the area
		M.power_change()			// reverify power status (to update icons etc.)
	if (fire || eject || party)
		updateicon()

/area/proc/usage(var/chan)
	var/used = 0
	switch(chan)
		if(LIGHT)
			used += used_light
		if(EQUIP)
			used += used_equip
		if(ENVIRON)
			used += used_environ
		if(TOTAL)
			used += used_light + used_equip + used_environ
	return used

/area/proc/clear_usage()
	used_equip = 0
	used_light = 0
	used_environ = 0

/area/proc/use_power(var/amount, var/chan)
	switch(chan)
		if(EQUIP)
			used_equip += amount
		if(LIGHT)
			used_light += amount
		if(ENVIRON)
			used_environ += amount

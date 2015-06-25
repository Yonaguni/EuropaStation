/atom/movable/proc/BlockSuperconductivity() // objects that block air and don't let superconductivity act. Only firelocks atm.
	return 0

/turf/proc/CalculateAdjacentTurfs()
	atmos_adjacent_turfs_amount = 0
	for(var/direction in cardinal)
		var/turf/T = get_step(src, direction)
		if(!istype(T))
			continue
		var/counterdir = get_dir(T, src)
		if(CanAtmosPass(T))
			atmos_adjacent_turfs_amount += 1
			atmos_adjacent_turfs |= direction
			if(!(T.atmos_adjacent_turfs & counterdir))
				T.atmos_adjacent_turfs_amount += 1
			T.atmos_adjacent_turfs |= counterdir
		else
			atmos_adjacent_turfs &= ~direction
			if(T.atmos_adjacent_turfs & counterdir)
				T.atmos_adjacent_turfs_amount -= 1
			T.atmos_adjacent_turfs &= ~counterdir

/atom/movable/proc/air_update_turf(var/command = 0)
	var/turf/baseturf = loc
	if(istype(baseturf))
		baseturf.air_update_turf(command)
	if(command)
		for(var/turf/T in locs)
			T.air_update_turf(command)

/turf/proc/air_update_turf(var/command = 0)
	if(command)
		CalculateAdjacentTurfs()
	if(air_master)
		air_master.add_to_active(src,command)

/atom/movable/proc/move_update_air(var/turf/T)
    if(istype(T,/turf))
        T.air_update_turf(1)
    air_update_turf(1)

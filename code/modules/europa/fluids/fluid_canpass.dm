
/atom/proc/CanFluidPass(var/coming_from)
	return 1

/turf/var/fluid_can_pass
/turf/CanFluidPass(var/coming_from)
	if(density)
		return 0
	if(isnull(fluid_can_pass))
		fluid_can_pass = 1
		for(var/atom/movable/AM in src)
			if(AM.simulated && !AM.CanFluidPass(coming_from))
				fluid_can_pass = 0
				break
	return fluid_can_pass

/obj/structure/inflatable/CanFluidPass(var/coming_from)
	return !density

/obj/structure/window/CanFluidPass(var/coming_from)
	if(coming_from == dir)
		return !density
	return 1

/obj/machinery/door/CanFluidPass(var/coming_from)
	return !density

/obj/machinery/door/window/CanFluidPass(var/coming_from)
	if(coming_from == dir || dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
		return !density
	return 1
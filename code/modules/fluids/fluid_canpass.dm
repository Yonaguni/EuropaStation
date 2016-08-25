/atom/var/fluid_can_pass

/atom/proc/CanFluidPass(var/coming_from)
	if(isnull(fluid_can_pass))
		if(density)
			fluid_can_pass = 0
			return fluid_can_pass
		else
			for(var/atom/movable/AM in src)
				if(!AM.simulated)
					continue
				if(!AM.CanFluidPass(coming_from))
					fluid_can_pass = 0
					return fluid_can_pass
		fluid_can_pass = 1
	return fluid_can_pass

/obj/structure/girder/CanFluidPass(var/coming_from)
	return 1

/obj/structure/table/CanFluidPass(var/coming_from)
	return 1

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
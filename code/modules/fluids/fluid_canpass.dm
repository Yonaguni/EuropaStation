/atom/var/fluid_can_pass
/atom/proc/CanFluidPass()
	if(isnull(fluid_can_pass))
		if(density)
			fluid_can_pass = 0
			return fluid_can_pass
		else
			for(var/atom/movable/AM in src)
				if(!AM.simulated)
					continue
				if(!AM.CanFluidPass())
					fluid_can_pass = 0
					return fluid_can_pass
		fluid_can_pass = 1
	return fluid_can_pass

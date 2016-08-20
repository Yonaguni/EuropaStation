/turf/var/fluid_blocked_dirs = 0

/turf/proc/add_fluid(var/fluidtype = "water")
	return

/turf/proc/remove_fluid(var/amount = 0)
	return

/turf/proc/return_fluids()
	return

/turf/Destroy()
	fluid_update()
	if(fluid_master)
		fluid_master.remove_active_source(src)
	return ..()

/turf/var/fluid_blocked_dirs = 0

/turf/proc/add_fluid(var/fluidtype = "water", var/amount)

	var/obj/effect/fluid/F = locate() in src
	if(!F) F = new(src)
	F.set_depth(F.fluid_amount + amount)
	return

/turf/proc/remove_fluid(var/amount = 0)
	var/obj/effect/fluid/F = locate() in src
	if(!F) return
	F.lose_fluid(amount)
	return

/turf/proc/return_fluid()
	return (locate(/obj/effect/fluid) in src)

/turf/Destroy()
	fluid_update()
	if(fluid_master)
		fluid_master.remove_active_source(src)
	return ..()

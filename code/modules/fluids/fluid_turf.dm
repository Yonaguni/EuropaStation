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

/atom/proc/is_flooded(var/lying_mob)
	var/turf/T = get_turf(src)
	return T.is_flooded(lying_mob)

/turf/is_flooded(var/lying_mob)
	if(flooded)
		return 1
	var/depth = get_fluid_depth()
	if(depth && depth > (lying_mob ? FLUID_SHALLOW : FLUID_DEEP))
		return 1
	return 0

/turf/proc/get_fluid_depth()
	if(flooded)
		return FLUID_OCEAN_DEPTH
	if(liquid == -1)
		var/obj/effect/fluid/F = return_fluid()
		if(F)
			liquid = F.fluid_amount
	return liquid

/turf/proc/update_blood_overlays()
	return
/turf/var/fluid_blocked_dirs = 0
/turf/var/flooded // Whether or not this turf is absolutely flooded ie. a water source.

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

/turf/return_fluid()
	..()
	return (locate(/obj/effect/fluid) in src)

/turf/Destroy()
	fluid_update()
	if(fluid_master)
		fluid_master.remove_active_source(src)
	return ..()

/turf/proc/get_fluid_depth()
	if(flooded)
		return FLUID_OCEAN_DEPTH
	if(liquid == -1)
		var/obj/effect/fluid/F = return_fluid()
		if(F)
			liquid = F.fluid_amount
	return liquid

/turf/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0)
	var/old_flooded = flooded
	. = ..()
	if(old_flooded)
		flooded = 1
		update_icon()

/turf/initialize()
	if((ticker && ticker.current_state == GAME_STATE_PLAYING) && fluid_master)
		fluid_update()
	. = ..()

/turf/New()
	var/area/A = get_area(src)
	if(istype(A) && (A.flags & IS_OCEAN))
		flooded = 1
	..()

/turf/check_fluid_depth(var/min)
	..()
	return (get_fluid_depth() >= min)

/turf/get_fluid_depth()
	..()
	var/obj/effect/fluid/F = return_fluid()
	return (istype(F) ? F.fluid_amount : 0 )


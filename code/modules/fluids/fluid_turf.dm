/obj/effect/flood
	name = ""
	mouse_opacity = 0
	layer = FLY_LAYER
	color = COLOR_OCEAN
	icon = 'icons/effects/liquids.dmi'
	icon_state = "ocean"
	alpha = FLUID_MAX_ALPHA
	simulated = 0
	density = 0
	opacity = 0
	anchored = 1

/obj/effect/flood/ex_act()
	return

/obj/effect/flood/New()
	..()
	verbs.Cut()

/turf
	var/fluid_blocked_dirs = 0
	var/flooded // Whether or not this turf is absolutely flooded ie. a water source.

/turf/proc/add_fluid(var/fluidtype = "water", var/amount)
	var/obj/effect/fluid/F = locate() in src
	if(!F) F = new(src)
	SET_FLUID_DEPTH(F, F.fluid_amount + amount)

/turf/proc/remove_fluid(var/amount = 0)
	var/obj/effect/fluid/F = locate() in src
	if(F) LOSE_FLUID(F, amount)

/turf/return_fluid()
	return (locate(/obj/effect/fluid) in contents)

/turf/Destroy()
	fluid_update()
	REMOVE_ACTIVE_FLUID_SOURCE(src)
	return ..()

/turf/simulated/Initialize()
	if(ticker && ticker.current_state == GAME_STATE_PLAYING)
		fluid_update()
	. = ..()

/turf/check_fluid_depth(var/min)
	..()
	return (get_fluid_depth() >= min)

/turf/get_fluid_depth()
	..()
	if(is_flooded(absolute=1))
		return FLUID_MAX_DEPTH
	var/obj/effect/fluid/F = return_fluid()
	return (istype(F) ? F.fluid_amount : 0 )

/turf/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0)
	. = ..()
	var/turf/T = .
	if(isturf(T) && !T.flooded && T.flood_object)
		QDEL_NULL(flood_object)

/turf/proc/show_bubbles()
	set waitfor = 0

	if(flooded)
		if(istype(flood_object))
			flick("ocean-bubbles", flood_object)
		return

	var/obj/effect/fluid/F = locate() in src
	if(istype(F))
		flick("bubbles",F)

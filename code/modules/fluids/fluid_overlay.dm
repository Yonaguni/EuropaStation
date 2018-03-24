/obj/effect/fluid
	name = ""
	icon = 'icons/effects/liquids.dmi'
	anchored = 1
	simulated = 0
	opacity = 0
	mouse_opacity = 0
	layer = FLY_LAYER
	alpha = 0
	color = COLOR_OCEAN

	var/temperature = T20C
	var/fluid_amount = 0
	var/turf/start_loc

/obj/effect/fluid/ex_act()
	return

/obj/effect/fluid/airlock_crush()
	qdel(src)

/obj/effect/fluid/Initialize()
	. = ..()
	start_loc = get_turf(src)
	if(!istype(start_loc))
		qdel(src)
		return
	var/turf/simulated/T = start_loc
	if(istype(T))
		T.unwet_floor(FALSE)
	forceMove(start_loc)
	update_icon()

/obj/effect/fluid/Destroy()
	if(start_loc)
		var/turf/simulated/T = start_loc
		if(istype(T))
			T.wet_floor()
		start_loc = null
	if(islist(equalizing_fluids))
		equalizing_fluids.Cut()
	REMOVE_ACTIVE_FLUID(src)
	return ..()

/obj/effect/fluid/airlock_crush()
	qdel(src)

/obj/effect/fluid_mapped
	name = "mapped flooded area"
	alpha = 125
	icon_state = "shallow_still"
	color = "#66D1FF"

	var/fluid_amount = FLUID_MAX_DEPTH

/obj/effect/fluid_mapped/Initialize()
	var/turf/T = get_turf(src)
	if(istype(T))
		var/obj/effect/fluid/F = locate() in T
		if(!F) F = new(T)
		SET_FLUID_DEPTH(F, fluid_amount)

	return INITIALIZE_HINT_QDEL

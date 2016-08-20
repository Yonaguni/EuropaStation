/obj/effect/fluid
	name = "liquid flow"
	name = ""
	icon = 'icons/effects/liquids.dmi'
	anchored = 1
	simulated = 0
	opacity = 0
	mouse_opacity = 0
	layer = 0
	alpha = 0
	color = "#66D1FF"

	var/turf/start_loc
	var/fluid_amount = 0
	var/fluid_type = "water"

/obj/effect/fluid/proc/lose_fluid(var/amt = 0)
	if(amt)
		fluid_amount = max(-1, fluid_amount - amt)
		if(fluid_master)
			fluid_master.add_active_fluid(src)

/obj/effect/fluid/proc/set_depth(var/amt=-1, var/update_icon)
	fluid_amount = min(FLUID_MAX_DEPTH, amt)
	if(fluid_master)
		fluid_master.add_active_fluid(src)
	if(update_icon)
		update_icon()

/obj/effect/fluid/initialize()
	. = ..()
	start_loc = get_turf(src)
	if(!istype(start_loc))
		qdel(src)
		return
	forceMove(start_loc)
	update_icon()

/obj/effect/fluid/Destroy()
	start_loc = null
	if(islist(equalizing_fluids)) // why the fuck
		equalizing_fluids.Cut()
	if(fluid_master)
		fluid_master.remove_active_fluid(src)
	return ..()

/obj/effect/fluid/update_icon()
	alpha = round(FLUID_MAX_ALPHA*(fluid_amount/FLUID_MAX_DEPTH))
	var/list/overlays_to_add = list()
	if(fluid_amount > FLUID_DELETING && fluid_amount <= FLUID_SHALLOW)
		overlays_to_add += get_fluid_icon("shallow_still")
		layer = TURF_LAYER+0.5
	else if(fluid_amount >= FLUID_SHALLOW && fluid_amount <= FLUID_DEEP)
		overlays_to_add += get_fluid_icon("mid_still")
		layer = MOB_LAYER+0.5
	else if(fluid_amount >= FLUID_DEEP && fluid_amount < FLUID_MAX_DEPTH)
		overlays_to_add += get_fluid_icon("deep_still")
		layer = FLY_LAYER
	else if(fluid_amount >= FLUID_MAX_DEPTH)
		overlays_to_add += get_fluid_icon("ocean")
		layer = FLY_LAYER
	overlays = overlays_to_add

/obj/effect/fluid/airlock_crush()
	qdel(src)

/obj/effect/fluid/mapped
	layer = 10
	alpha = 125
	color = "#66D1FF"
	icon_state = "shallow_still"

/obj/effect/fluid/mapped/New()
	..()
	// Reset mapping shorthand.
	layer = 0
	alpha = 0
	color = null
	icon_state = null
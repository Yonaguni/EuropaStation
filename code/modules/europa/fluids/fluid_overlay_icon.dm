/obj/effect/fluid/update_icon()
	overlays.Cut()
	alpha = min(FLUID_MAX_ALPHA,max(FLUID_MIN_ALPHA,ceil(255*(fluid_amount/FLUID_MAX_DEPTH))))
	if(fluid_amount > FLUID_DELETING && fluid_amount <= FLUID_EVAPORATION_POINT)
		overlays += get_fluid_icon("shallow_still")
		layer = TURF_LAYER+0.1
	else if(fluid_amount >= FLUID_EVAPORATION_POINT && fluid_amount <= FLUID_SHALLOW)
		overlays += get_fluid_icon("mid_still")
		layer = TURF_LAYER+0.2
	else if(fluid_amount >= FLUID_SHALLOW && fluid_amount < FLUID_DEEP)
		overlays += get_fluid_icon("deep_still")
		layer = MOB_LAYER+2
	else if(fluid_amount >= FLUID_DEEP)
		overlays += get_fluid_icon("ocean")
		layer = FLY_LAYER

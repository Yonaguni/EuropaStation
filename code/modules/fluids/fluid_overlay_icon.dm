/obj/effect/fluid/update_icon()

	overlays.Cut()

	if(fluid_amount > FLUID_OVER_MOB_HEAD)
		layer = FLY_LAYER
	else
		layer = TURF_LAYER+0.1

	if(fluid_amount > FLUID_DEEP)
		alpha = FLUID_MAX_ALPHA
	else
		alpha = min(FLUID_MAX_ALPHA,max(FLUID_MIN_ALPHA,ceil(255*(fluid_amount/FLUID_DEEP))))

	if(fluid_amount > FLUID_DELETING && fluid_amount <= FLUID_EVAPORATION_POINT)
		APPLY_FLUID_OVERLAY("shallow_still")
	else if(fluid_amount > FLUID_EVAPORATION_POINT && fluid_amount < FLUID_SHALLOW)
		APPLY_FLUID_OVERLAY("mid_still")
	else if(fluid_amount >= FLUID_SHALLOW && fluid_amount < (FLUID_DEEP*2))
		APPLY_FLUID_OVERLAY("deep_still")
	else if(fluid_amount >= (FLUID_DEEP*2))
		APPLY_FLUID_OVERLAY("ocean")

// Called to add all nearby fluids to the fluid controller.
/proc/update_fluids(var/atom/A)
	for(var/obj/effect/fluid/F in range(1,A))
		F.refresh()
	for(var/turf/unsimulated/ocean/O in range(1,A))
		O.refresh()

// Jamming a fluid update into the existing update proc (windows, doors)
/obj/update_nearby_tiles(need_rebuild)
	. = ..(need_rebuild)
	update_fluids(get_turf(src))
	air_update_turf(1)

// Fluid icon cache retriever
/proc/get_fluid_icon(var/img_state)
	if(!fluid_images[img_state])
		fluid_images[img_state] = image('icons/effects/liquid.dmi',img_state)
	return fluid_images[img_state]

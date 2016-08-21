/obj/effect/fluid/var/overlay_pixel_z = 0

/obj/effect/fluid/proc/update_position_and_alpha()
	var/fill_amt = fluid_amount/FLUID_MAX_DEPTH
	overlay_pixel_z = Floor(min(32,max(0,32*fill_amt)))
	alpha = min(FLUID_MAX_ALPHA,max(FLUID_MIN_ALPHA,ceil(255*fill_amt)))

/obj/effect/fluid/proc/update_overlays()

	var/list/overlays_to_add = list()

	if(overlay_pixel_z)

		var/neighbor_offset = 0
		var/underlay_size = overlay_pixel_z

		var/obj/effect/fluid/F = locate() in get_step(start_loc, SOUTH)
		if(istype(F) && F.overlay_pixel_z)
			neighbor_offset = F.overlay_pixel_z
			underlay_size = underlay_size-neighbor_offset

		var/image/I = image(icon = 'icons/effects/water_underlay.dmi', icon_state = "[underlay_size]")
		if(neighbor_offset)
			I.pixel_z = neighbor_offset
		overlays_to_add += I

	var/image/fluid_overlay
	if(fluid_amount > FLUID_DELETING && fluid_amount <= FLUID_SHALLOW)
		fluid_overlay = get_fluid_icon("shallow_still")
	else if(fluid_amount >= FLUID_SHALLOW && fluid_amount <= FLUID_DEEP)
		fluid_overlay = get_fluid_icon("mid_still")
	else if(fluid_amount >= FLUID_DEEP && fluid_amount < FLUID_OCEAN_DEPTH)
		fluid_overlay = get_fluid_icon("deep_still")
	else if(fluid_amount >= FLUID_OCEAN_DEPTH)
		fluid_overlay = get_fluid_icon("ocean")

	if(fluid_overlay)
		if(overlay_pixel_z)
			fluid_overlay.pixel_z = overlay_pixel_z
		overlays_to_add += fluid_overlay

	overlays = overlays_to_add

/obj/effect/fluid/update_icon()
	update_position_and_alpha()
	update_overlays()

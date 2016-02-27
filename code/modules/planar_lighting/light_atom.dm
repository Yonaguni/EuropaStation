/atom/movable
	var/obj/light/light_obj
	var/light_type = LIGHT_SOFT
	var/light_power
	var/light_range
	var/light_color

/atom/movable/Destroy()
	qdel(light_obj)
	light_obj = null
	return ..()

/atom/proc/set_opacity(var/newopacity)
	opacity = newopacity ? 1 : 0
	if(opacity)
		var/turf/T = get_turf(src)
		if(istype(T))
			FOR_DVIEW(var/obj/light/L, (world.view*2.2), T, 0)
				L.update_bleed_masking()
			END_FOR_DVIEW

/atom/movable/proc/kill_light()
	set waitfor=0
	. = 1
	if(light_obj)
		qdel(light_obj)
		light_obj = null
	return

/atom/movable/proc/set_light(var/l_range, var/l_power, var/l_color, var/fadeout)

	set waitfor=0
	. = 1

	if(isnull(l_range)) l_range = light_range
	if(isnull(l_power)) l_power = light_power
	if(isnull(l_color)) l_color = light_color

	// Doing all this here because fuck proc calls.
	// Make sure we have a light overlay.
	if(!light_obj)
		light_obj = new(src)

	// Power == alpha.
	var/use_alpha
	if(!isnull(l_power) && light_obj.light_overlay.alpha != use_alpha)
		use_alpha = min(255,(l_power * 50))
	// Range == size of the overlay.

	var/matrix/use_transform
	var/scale_val
	if(!isnull(l_range) && l_range != light_obj.current_power)
		light_obj.current_power = l_range
		scale_val = max(1,min(8,light_obj.current_power*0.75))
		use_transform = matrix()
		use_transform.Scale(scale_val)

	// Colour = src.color.
	var/use_colour
	if(!isnull(l_color) && l_color != light_obj.light_overlay.color)
		use_colour = l_color

	// Update icon.
	light_obj.light_overlay.icon_state = light_type
	light_obj.follow_holder()

	// Should we bother with anything else?
	if(!use_transform && isnull(use_alpha) && !use_colour)
		return

	// Apply effects.
	if(use_transform)      light_obj.light_overlay.transform = use_transform
	if(!isnull(use_alpha)) light_obj.light_overlay.alpha = use_alpha
	if(use_colour)         light_obj.light_overlay.color = use_colour

	// Is this just a flash?
	if(fadeout) // Rare enough that we can probably get away with calling animate().
		animate(light_obj.light_overlay, time=fadeout, alpha=0)

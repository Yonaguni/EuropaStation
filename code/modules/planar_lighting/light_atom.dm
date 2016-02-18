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

/atom/movable/proc/kill_light()

	set waitfor=0
	. = 1

	if(light_obj)

		animate(light_obj, alpha=0, time=3)
		sleep(3)
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
	if(!isnull(l_power) && light_obj.alpha != use_alpha)
		use_alpha = min(255,(l_power * 35))
	// Range == size of the overlay.

	var/matrix/use_transform
	if(!isnull(l_range) && l_range != light_obj.current_power)
		if(l_range == light_obj.current_power)
			return
		light_obj.current_power = l_range
		use_transform = matrix()
		use_transform.Scale(max(1,min(8,light_obj.current_power/2)))

	// Colour = src.color.
	var/use_colour
	if(!isnull(l_color) && l_color != light_obj.color)
		use_colour = l_color

	// Should we bother with anything else?
	if(!use_transform && isnull(use_alpha) && !use_colour)
		return

	// Update icon.
	light_obj.icon_state = light_type
	light_obj.follow_holder()

	// Apply effects.
	var/anim_time = 3 - fadeout
	if(anim_time > 0)
		if(!use_transform)    use_transform = light_obj.transform
		if(isnull(use_alpha)) use_alpha =     light_obj.alpha
		if(!use_colour)       use_colour =    light_obj.color
		animate(light_obj, color = use_colour, alpha = use_alpha, transform = use_transform, time = anim_time)
		if(fadeout)
			sleep(anim_time)
	else
		if(use_transform)      light_obj.transform = use_transform
		if(!isnull(use_alpha)) light_obj.alpha = use_alpha
		if(use_colour)         light_obj.color = use_colour

	// Is this just a flash?
	if(fadeout)
		animate(light_obj, time=fadeout, alpha=0)

/atom/movable
	var/obj/light/light_obj
	var/light_type = LIGHT_SOFT
	var/light_power = 1
	var/light_range = 1
	var/light_color = "#FFFFFF"

/atom/movable/Destroy()
	qdel(light_obj)
	light_obj = null
	return ..()

/atom/proc/set_opacity(var/newopacity)
	opacity = newopacity ? 1 : 0
	var/turf/T = get_turf(src)
	if(istype(T))
		for(var/obj/light/L in range(world.view, T)) // todo
			L.update_bleed_masking()

/atom/movable/set_opacity(var/newopacity)
	var/turf/T = get_turf(src)
	T.blocks_light = -1 // Needs an update.
	..()

/atom/movable/proc/kill_light()
	set waitfor=0
	. = 1
	if(light_obj)
		qdel(light_obj)
		light_obj = null
	return

/atom/movable/proc/set_light(var/l_range, var/l_power, var/l_color, var/fadeout)

	// Update or retrieve our variable data.
	if(isnull(l_range))
		l_range = light_range
	else
		light_range = l_range
	if(isnull(l_power))
		l_power = light_power
	else
		light_power = l_power
	if(isnull(l_color))
		l_color = light_color
	else
		light_color = l_color

	var/need_bleed_update
	if(!light_obj)
		need_bleed_update = 1
		light_obj = new(src)
	var/use_alpha = min(255,(l_power * 50))
	if(light_obj.light_overlay.alpha != use_alpha)
		need_bleed_update = 1
		light_obj.light_overlay.alpha = use_alpha
	if(light_obj.light_overlay.color != l_color)
		need_bleed_update = 1
		light_obj.light_overlay.color = l_color
	if(light_obj.light_overlay.icon_state != light_type)
		need_bleed_update = 1
		light_obj.light_overlay.icon_state = light_type
	if(light_obj.current_power != l_range)
		need_bleed_update = 1
		light_obj.update_transform(l_range)

	if(need_bleed_update)
		light_obj.follow_holder()

	// Rare enough that we can probably get away with calling animate(). Currently used by muzzle flashes and sparks.
	if(fadeout) animate(light_obj.light_overlay, time=fadeout, alpha=0)

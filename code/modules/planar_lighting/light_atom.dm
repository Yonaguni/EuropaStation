/atom
	var/obj/light/light_obj
	var/light_power
	var/light_range
	var/light_color

/atom/Destroy()
	qdel(light_obj)
	light_obj = null
	return ..()

/atom/proc/set_light(var/l_range, var/l_power, var/l_color)

	if(!ticker || ticker.current_state != GAME_STATE_PLAYING)
		return // No idea what the heck is calling set_light(0) at world.New().

	// No range of power, shut it off.
	if(l_power == 0 || l_range == 0)
		if(light_obj)
			qdel(light_obj)
			light_obj = null
		return
	if(!light_obj)
		light_obj = new(src)

	// Doing all this here because fuck proc calls.
	// Power == alpha.
	if(!isnull(l_power) && l_power != light_power)
		light_power = l_power
		light_obj.alpha = min(255,(l_power * 15))

	// Range == size of the overlay.
	if(!isnull(l_range) && l_range != light_range)
		light_range = l_range
		if(l_range == light_obj.current_power)
			return
		light_obj.current_power = l_range
		switch(light_obj.current_power)
			if(1)
				light_obj.icon = 'icons/planar_lighting/overlays_small.dmi'
				light_obj.pixel_x = 0
				light_obj.pixel_y = 0
			if(2)
				light_obj.icon = 'icons/planar_lighting/overlays_med.dmi'
				light_obj.pixel_x = -16
				light_obj.pixel_y = -16
			if(3)
				light_obj.icon = 'icons/planar_lighting/overlays_large.dmi'
				light_obj.pixel_x = -32
				light_obj.pixel_y = -32
			else //todo
				light_obj.icon = 'icons/planar_lighting/overlays_large.dmi'
				light_obj.pixel_x = -32
				light_obj.pixel_y = -32

	// Colour = src.color.
	if(!isnull(l_color) && l_color != light_color)
		light_color = l_color
		light_obj.color = l_color

/atom/movable/Move()
	. = ..()
	if(light_obj)
		if(istype(src.loc, /turf))
			light_obj.loc = src.loc
		else
			light_obj.loc = src

/atom/movable/forceMove()
	. = ..()
	if(light_obj)
		if(istype(src.loc, /turf))
			light_obj.loc = src.loc
		else
			light_obj.loc = src

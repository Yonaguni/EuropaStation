/atom
	var/obj/light/light_obj
	var/light_power
	var/light_range
	var/light_color
	var/light_hard
	var/light_flicker

/atom/Destroy()
	qdel(light_obj)
	light_obj = null
	return ..()

/obj/initialize()
	..()
	if(light_power || light_range || light_color)
		set_light(light_power, light_range, light_color)

/turf/initialize()
	..()
	if(light_power || light_range || light_color)
		set_light(light_power, light_range, light_color)

/atom/proc/set_light(var/l_range, var/l_power, var/l_color)
	//world << "DEBUG: \The [src] called set_light with [l_range], [l_power], [l_color]."
	if(!ticker || ticker.current_state != GAME_STATE_PLAYING)
		return // No idea what the heck is calling set_light(0) at world.New().
	// No range of power, shut it off.
	if(l_power == 0 || l_range == 0)
		if(light_obj)
			qdel(light_obj)
			light_obj = null
		return
	// Make sure we have a light overlay.
	if(!light_obj)
		light_obj = new(src)
	// Doing all this here because fuck proc calls.
	// Check if we need to use an existing colour.
	if(isnull(l_color) && light_color)
		l_color = light_color
	// Power == alpha.
	var/use_alpha = min(255,(l_power * 50))
	if(!isnull(l_power) && light_obj.alpha != use_alpha)
		light_obj.alpha = use_alpha
	// Range == size of the overlay.
	if(!isnull(l_range) && l_range != light_obj.current_power)
		if(l_range == light_obj.current_power)
			return
		light_obj.current_power = l_range
		var/matrix/use_transform = matrix()
		use_transform.Scale(max(1,min(4,round(light_obj.current_power/3))))
		light_obj.transform = use_transform
	// Colour = src.color.
	if(!isnull(l_color) && l_color != light_obj.color)
		light_obj.color = l_color

	// Update icon.
	if(light_hard)
		light_obj.icon_state = "hard"
	if(light_flicker)
		light_obj.icon_state = "[light_obj.icon_state]-flicker"

	// Update position of overlay etc.
	light_obj.loc = get_turf(src)
	light_obj.set_dir(light_obj.holder.dir)

/atom/movable/set_dir()
	. = ..()
	if(light_obj) light_obj.set_dir(light_obj.holder.dir)

/atom/movable/Move()
	. = ..()
	if(light_obj) light_obj.loc = get_turf(src)

/atom/movable/forceMove()
	. = ..()
	if(light_obj) light_obj.loc = get_turf(src)

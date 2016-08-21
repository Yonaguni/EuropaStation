/atom/movable/ignite_location()
	. = ..()
	var/turf/T = get_turf(src)
	if(T)
		T.ignite()
	else if(isliving(loc))
		var/mob/living/M = loc
		M.ignite()

/turf/ignite()
	. = ..()
	for(var/atom/movable/AM in src)
		AM.ignite()

/mob/living/ignite()
	. = ..()
	if(fire_stacks > 0 && !on_fire)
		on_fire = 1
		set_light(light_range + 3)
		update_fire()


/mob/living/animal/ignite()
	. = ..()
	return

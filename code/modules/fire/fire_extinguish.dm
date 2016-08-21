/turf/extinguish()
	. = ..()
	for(var/atom/movable/AM in src)
		AM.extinguish()

/mob/living/extinguish()
	. = ..()
	if(on_fire)
		on_fire = 0
		fire_stacks = 0
		set_light(max(0, light_range - 3))
		update_fire()

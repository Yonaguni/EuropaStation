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

/obj/structure/reagent_dispenser/ignite(var/mob/user)
	message_admins("[key_name_admin(user)] triggered a fueltank explosion with a welding tool.")
	log_game("[key_name(user)] triggered a fueltank explosion with a welding tool.")
	user << "<span class='danger'>You begin welding on \the [src]. In a moment of lucidity you realize that this isn't the smartest thing you've ever done.</span>"
	explode()

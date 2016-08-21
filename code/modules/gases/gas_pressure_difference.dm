/atom/movable/proc/experience_pressure_difference(pressure_difference, direction)
	return

/mob/living/experience_pressure_difference(var/pressure_difference, var/direction)
	if(anchored || buckled || pressure_difference < 30 || !prob(slip_chance()))
		return
	var/flow_msg = "pushed away"
	if(!lying && (pressure_difference >= mob_size*2))
		Weaken(rand(2,4))
		flow_msg = "knocked down"
	src << "<span class='danger'>You are [flow_msg] by the rush!</span>"
	step_towards(src, get_step(get_turf(src),direction))

/obj/item/experience_pressure_difference(var/pressure_difference, var/direction)
	if(!direction || anchored || pressure_difference <= w_class*10)
		return
	step_towards(src, get_step(get_turf(src),direction))

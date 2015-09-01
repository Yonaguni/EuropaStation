/atom/movable/proc/experience_pressure_difference(pressure_difference, direction)
	return

/mob/living/carbon/human/experience_pressure_difference(var/pressure_difference, var/direction)
	if(species.flags & NO_SLIP)
		return
	if(shoes && (shoes.item_flags & NOSLIP))
		return
	..(pressure_difference, direction)

/mob/living/experience_pressure_difference(var/pressure_difference, var/direction)
	if(anchored || buckled || pressure_difference < 30)
		return
	var/flow_msg = "pushed away"
	if(!lying && pressure_difference >= 70 && prob(pressure_difference))
		Weaken(rand(2,4))
		flow_msg = "knocked down"
	src << "<span class='danger'>You are [flow_msg] by the rush!</span>"
	step_towards(src, get_step(get_turf(src),direction))

/obj/item/experience_pressure_difference(var/pressure_difference, var/direction)
	if(!direction || anchored || pressure_difference <= w_class*10)
		return
	step_towards(src, get_step(get_turf(src),direction))

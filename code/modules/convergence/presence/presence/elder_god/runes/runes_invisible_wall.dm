/datum/presence_power/rune/invisible_wall
	name = "Rune of the Broken Bridge"
	description = "A rune that creates an invisible barrier over itself."
	sigil_del_after_use = FALSE

// This is bad, make a placeholder invisible wall object instead.
/datum/presence_power/rune/invisible_wall/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)

	. = ..()
	if(!.)
		return FALSE

	var/turf/T = get_turf(target)
	if(!istype(T))
		return FALSE
	var/mob/living/user = invoker
	if(!istype(user))
		return FALSE
	user.take_organ_damage(2, 0)
	T.density = !T.density
	if(T.density)
		target.visible_message("<span class='danger'>\The [invoker]'s blood flows over the rune, and the air above the rune is suddenly as hard as glass.</span>")
	else
		target.visible_message("<span class='danger'>\The [invoker]'s blood flows over the rune, and the air shimmers as the rune releases its grasp on reality.</span>")
	return TRUE

/datum/presence_power/rune/emp
	name = "Rune of Discord"
	description = "A rune that destroys technology in a small area."

/datum/presence_power/rune/emp/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	. = ..()
	if(.)
		var/turf/T = get_turf(target)
		T.hotspot_expose(700,125)
		empulse(T, 4, 7)
		playsound(T, 'sound/items/Welder2.ogg', 25, 1)
		T.visible_message("<span class='danger'>A flare of crackling static surrounds the rune as it fades to dust!</span>")
		return TRUE

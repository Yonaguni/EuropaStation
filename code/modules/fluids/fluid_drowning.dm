/mob/living/proc/can_drown()
	return 1

/mob/living/human/can_drown()
	var/obj/item/organ/internal/gills/G = locate() in internal_organs
	if(!G || G.is_broken())
		return 1
	return 0

/mob/living/proc/handle_drowning()
	if(!can_drown())
		return 0
	if(!loc.is_flooded(lying))
		return 0
	if(prob(15))
		src << "<span class='danger'>You choke and splutter as you inhale water!</span>"
	return 1 // Presumably chemical smoke can't be breathed while you're underwater.

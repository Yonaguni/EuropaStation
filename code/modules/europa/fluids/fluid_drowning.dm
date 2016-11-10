/mob/handle_drowning()
	return

/mob/living/can_drown()
	return 1

/mob/living/carbon/human/can_drown()
	if(!internal)
		var/obj/item/organ/internal/gills/G = locate() in internal_organs
		if(!G || G.is_broken())
			return 1
	return 0

/mob/living/handle_drowning()
	if(!can_drown() || !loc.is_flooded(lying))
		return 0
	if(prob(25))
		src << "<span class='danger'>You choke and splutter as you inhale water!</span>"
	return 1 // Presumably chemical smoke can't be breathed while you're underwater.

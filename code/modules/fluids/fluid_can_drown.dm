/mob/living/proc/can_drown()
	return 1

/mob/living/bot/can_drown()
	return 0

/mob/living/simple_animal/construct/can_drown()
	return 0

/mob/living/simple_animal/borer/can_drown()
	return 0

/mob/living/carbon/can_drown()
	var/obj/item/organ/gills/G = locate() in internal_organs
	if(!G || G.is_broken())
		return 1
	return 0

/mob/living/proc/handle_drowning()
	if(!can_drown())
		return 0
	var/turf/T = get_turf(src)
	if(!istype(T))
		return
	if(!T.is_ocean())
		return 0
	if(prob(5))
		src << "<span class='danger'>You choke and splutter as you inhale water!</span>"
	return 1 // Presumably chemical smoke can't be breathed while you're underwater.

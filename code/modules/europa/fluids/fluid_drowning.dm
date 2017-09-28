/mob/handle_drowning()
	return

/mob/living/can_drown()
	return 1

/mob/living/carbon/human/can_drown()
	if(!internal)
		var/obj/item/organ/internal/lungs/L = locate() in internal_organs
		return (!L || L.can_drown())
	return 0

/mob/living/handle_drowning()
	if(!can_drown() || !loc.is_flooded(lying))
		return 0
	src << "<span class='danger'>You choke and splutter as you inhale water!</span>"
	var/turf/T = get_turf(src)
	T.show_bubbles()
	return 1 // Presumably chemical smoke can't be breathed while you're underwater.

/mob/living/carbon/human/get_breath_from_environment(var/volume_needed=BREATH_VOLUME)
	var/datum/gas_mixture/breath = ..(volume_needed)
	var/turf/T = get_turf(src)
	if(istype(T) && T.is_flooded(lying) && should_have_organ(BP_LUNGS))
		var/obj/item/organ/internal/lungs/lungs = internal_organs_by_name[BP_LUNGS]
		if(lungs && lungs.has_gills)
			if(!breath)
				breath = new
				breath.volume = volume_needed
				breath.temperature = T.temperature
			breath.adjust_gas("oxygen", ONE_ATMOSPHERE*volume_needed/(R_IDEAL_GAS_EQUATION*T20C))
			T.show_bubbles()
	return breath

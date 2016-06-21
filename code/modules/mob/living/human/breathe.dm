/mob/living/human/breathe(var/datum/gas_mixture/use_breath)
	// Do we even need to breathe?
	if(!should_have_organ(O_LUNGS)) return
	//First, check if we can breathe at all
	if(health < config.health_threshold_crit && !(CE_STABLE in chem_effects)) //crit aka circulatory shock
		losebreath++
	if(losebreath>0) //Suffocating so do not take a breath
		losebreath--
		if(prob(10)) //Gasp per 10 ticks? Sounds about right.
			spawn emote("gasp")
			return
	 // Internals are handled hear, if those fail environment air is checked in living/breathe.
	. = ..(get_breath_from_internal())

/mob/living/human/proc/get_breath_from_internal(var/volume_needed=BREATH_VOLUME) //hopefully this will allow overrides to specify a different default volume without breaking any cases where volume is passed in.
	if(internal)
		if (!contents.Find(internal))
			internal = null
		if (!(wear_mask && (wear_mask.item_flags & AIRTIGHT)))
			internal = null
		if(internal)
			if (internals)
				internals.icon_state = "internal1"
			return internal.remove_air_volume(volume_needed)
		else
			if (internals)
				internals.icon_state = "internal0"
	return null

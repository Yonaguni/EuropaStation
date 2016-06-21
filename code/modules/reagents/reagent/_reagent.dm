/datum/reagent

	var/name = "Reagent"
	var/id = "reagent"
	var/datum/reagents/holder = null
	var/list/data = null
	var/volume = 0
	var/scannable = 0 // Shows up on health analyzers.
	var/affects_dead = 0
	var/color = "#000000"
	var/color_weight = 1
	var/flammable = -1

	// Metabolism variables.
	var/metabolism = REM // This would be 0.2 normally
	var/ingest_met = 0
	var/touch_met = 0
	var/dose = 0
	var/max_dose = 0
	var/overdose = 0
	var/nutriment_factor = 0
	var/nutriment_injectable = 0
	var/hydration_factor = 0
	var/acid = 0
	var/acid_melt_threshold = 0
	var/toxic_blood = 0
	var/disinfectant = 0
	var/alcoholic
	var/hallucinogen
	var/neurotoxin

/datum/reagent/proc/remove_self(var/amount) // Shortcut
	holder.remove_reagent(id, amount)

/datum/reagent/proc/on_mob_life(var/mob/living/human/M, var/alien, var/location) // Currently, on_mob_life is called on carbons. Any interaction with non-carbon mobs (lube) will need to be done in touch_mob.
	if(!istype(M))
		return
	if(!affects_dead && M.stat == DEAD)
		return
	if(overdose && (dose > overdose) && (location != CHEM_TOUCH))
		overdose(M, alien)
	var/removed = metabolism
	if(ingest_met && (location == CHEM_INGEST))
		removed = ingest_met
	if(touch_met && (location == CHEM_TOUCH))
		removed = touch_met
	removed = min(removed, volume)
	max_dose = max(volume, max_dose)
	dose = min(dose + removed, max_dose)
	if(removed >= (metabolism * 0.1) || removed >= 0.1) // If there's too little chemical, don't affect the mob, just remove it
		switch(location)
			if(CHEM_BLOOD)
				affect_blood(M, alien, removed)
			if(CHEM_INGEST)
				affect_ingest(M, alien, removed)
			if(CHEM_TOUCH)
				affect_touch(M, alien, removed)
	remove_self(removed)
	return

/datum/reagent/proc/overdose(var/mob/living/human/M, var/alien) // Overdose effect. Doesn't happen instantly.
	M.adjustToxLoss(REM)
	return

/datum/reagent/proc/initialize_data(var/newdata) // Called when the reagent is created.
	if(!isnull(newdata))
		data = newdata
	return

/datum/reagent/proc/mix_data(var/newdata, var/newamount) // You have a reagent with data, and new reagent with its own data get added, how do you deal with that?
	return

/datum/reagent/proc/get_data() // Just in case you have a reagent that handles data differently.
	if(data && istype(data, /list))
		return data.Copy()
	else if(data)
		return data
	return null

/datum/reagent/Destroy() // This should only be called by the holder, so it's already handled clearing its references
	holder = null
	return ..()

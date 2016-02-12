/datum/reagent/proc/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)

	if(!istype(M))
		return

	if(nutriment_injectable)
		if(nutriment_factor)
			if(!nutriment_injectable)
				M.adjustToxLoss(0.1 * removed)
			else
				M.nutrition += nutriment_factor * removed
				M.add_chemical_effect(CE_BLOODRESTORE, 4 * removed)
		if(hydration_factor)
			if(!nutriment_injectable)
				M.adjustToxLoss(0.1 * removed)
			else
				M.hydration += nutriment_factor * removed
				M.add_chemical_effect(CE_BLOODRESTORE, 4 * removed)

	if(toxic_blood)
		M.adjustToxLoss(toxic_blood * removed)

	if(acid)
		M.take_organ_damage(0, removed * acid * 2)
	return

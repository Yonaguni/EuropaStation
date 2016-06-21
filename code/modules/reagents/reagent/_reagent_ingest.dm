/datum/reagent/proc/affect_ingest(var/mob/living/human/M, var/alien, var/removed)
	if(nutriment_factor)
		M.nutrition += nutriment_factor * removed
	if(hydration_factor)
		M.hydration += hydration_factor * removed
		if(hydration_factor >= 4)
			M.add_chemical_effect(CE_BLOODRESTORE, 1 * removed)

	if(alcoholic)
		M.add_chemical_effect(CE_ALCOHOL, 1)
		if(dose >= alcoholic * 7) // Pass out
			M.paralysis = max(M.paralysis, 20)
			M.sleeping  = max(M.sleeping, 30)
		else if(dose >= alcoholic * 6) // Toxic dose
			M.add_chemical_effect(CE_ALCOHOL_TOXIC, alcoholic)
		else if(dose >= alcoholic * 5) // Drowsyness - periodically falling asleep
			M.drowsyness = max(M.drowsyness, 20)
		else if(dose >= alcoholic * 4) // Blurry vision
			M.eye_blurry = max(M.eye_blurry, 10)
		else if(dose >= alcoholic * 3) // Confusion - walking in random directions
			M.confused = max(M.confused, 20)
		else if(dose >= alcoholic * 2) // Slurring
			M.slurring = max(M.slurring, 30)
		else if(dose >= alcoholic) // Early warning
			M.make_dizzy(6) // It is decreased at the speed of 3 per tick

	if(neurotoxin != 0)
		M.druggy = max(M.druggy, neurotoxin)

	if(hallucinogen)
		M.hallucination = max(M.hallucination, hallucinogen)

	affect_blood(M, alien, removed * 0.5)
	return

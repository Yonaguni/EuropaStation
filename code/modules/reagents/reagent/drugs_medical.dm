/datum/reagent/adrenaline
	name = "Adrenaline"
	id = "adrenaline"
	description = "Adrenaline is a hormone used as a drug to treat cardiac arrest and other cardiac dysrhythmias resulting in diminished or absent cardiac output."
	reagent_state = LIQUID
	color = "#C8A5DC"

/datum/reagent/adrenaline/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	// TODO check how hurt you are, apply effects dependant on that.
	M.add_chemical_effect(CE_STABLE)
	M.add_chemical_effect(CE_PAINKILLER, 25)
	// TODO stresses the heart.


/datum/reagent/antitoxin
	name = "Antitoxin"
	id = "anti_toxin"
	description = "A broad-spectrum antitoxin."
	reagent_state = LIQUID
	color = "#00A000"
	scannable = 1

/datum/reagent/antitoxin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien != IS_DIONA)
		M.drowsyness = max(0, M.drowsyness - 6 * removed)
		M.hallucination = max(0, M.hallucination - 9 * removed)
		M.adjustToxLoss(-4 * removed)

/datum/reagent/antirad
	name = "Antirad"
	id = "antirad"
	description = "Neupogen Plus is a medicinal drug used to counter the effect of radiation poisoning by stimulating cell growth."
	reagent_state = LIQUID
	color = "#408000"
	metabolism = REM * 0.25
	overdose = REAGENTS_OVERDOSE
	scannable = 1

/datum/reagent/antirad/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.radiation = max(M.radiation - 30 * removed, 0)

/datum/reagent/antibiotic
	name = "Antibiotic"
	id = "antibiotic"
	description = "An all-purpose antibiotic and antiviral agent."
	reagent_state = LIQUID
	color = "#C1C1C1"
	metabolism = REM * 0.05
	overdose = REAGENTS_OVERDOSE
	scannable = 1
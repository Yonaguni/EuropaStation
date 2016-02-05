/datum/reagent/psilocybin
	name = "Psilocybin"
	id = "psilocybin"
	description = "A strong psycotropic derived from certain species of mushroom."
	color = "#E700E7"
	overdose = REAGENTS_OVERDOSE
	metabolism = REM * 0.5

/datum/reagent/psilocybin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.druggy = max(M.druggy, 30)
	if(dose < 1)
		M.apply_effect(3, STUTTER)
		M.make_dizzy(5)
		if(prob(5))
			M.emote(pick("twitch", "giggle"))
	else if(dose < 2)
		M.apply_effect(3, STUTTER)
		M.make_jittery(5)
		M.make_dizzy(5)
		M.druggy = max(M.druggy, 35)
		if(prob(10))
			M.emote(pick("twitch", "giggle"))
	else
		M.apply_effect(3, STUTTER)
		M.make_jittery(10)
		M.make_dizzy(10)
		M.druggy = max(M.druggy, 40)
		if(prob(15))
			M.emote(pick("twitch", "giggle"))

/datum/reagent/nicotine
	name = "Nicotine"
	id = "nicotine"
	description = "A highly addictive stimulant extracted from the tobacco plant."
	reagent_state = LIQUID
	color = "#181818"

/datum/reagent/jumpstart
	name = "Jumpstart"
	id = "jumpstart"
	description = "Jumpstart is a highly effective, long lasting, muscle stimulant."
	reagent_state = LIQUID
	color = "#FF3300"
	metabolism = REM * 0.15
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/jumpstart/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(prob(5))
		M.emote(pick("twitch", "blink_r", "shiver"))
	M.add_chemical_effect(CE_SPEEDBOOST, 1)
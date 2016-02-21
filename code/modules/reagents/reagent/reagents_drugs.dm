/datum/reagent/soporific
	name = "Soporific"
	id = REAGENT_ID_SLEEPTOX
	color = "#009CA8"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE

/datum/reagent/soporific/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(dose < 1)
		if(dose == metabolism * 2 || prob(5))
			M.emote("yawn")
	else if(dose < 1.5)
		M.eye_blurry = max(M.eye_blurry, 10)
	else if(dose < 5)
		if(prob(50))
			M.Weaken(2)
		M.drowsyness = max(M.drowsyness, 20)
	else
		M.sleeping = max(M.sleeping, 20)
		M.drowsyness = max(M.drowsyness, 60)
	M.add_chemical_effect(CE_PULSE, -2)
	..()

/datum/reagent/adrenaline
	name = REAGENT_ID_ADRENALINE
	id = REAGENT_ID_ADRENALINE
	color = "#C8A5DC"

/datum/reagent/adrenaline/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	// TODO check how hurt you are, apply effects dependant on that.
	M.add_chemical_effect(CE_STABLE)
	M.add_chemical_effect(CE_PAINKILLER, 25)
	M.add_chemical_effect(CE_PAINKILLER, 25)
	M.add_chemical_effect(CE_PULSE,2)
	// TODO stresses the heart.

/datum/reagent/antitoxin
	name = "Antitoxin"
	id = REAGENT_ID_ANTITOX
	color = "#00A000"
	scannable = 1

/datum/reagent/antitoxin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.drowsyness = max(0, M.drowsyness - 6 * removed)
	M.hallucination = max(0, M.hallucination - 9 * removed)
	M.adjustToxLoss(-4 * removed)
	..()

/datum/reagent/antirad
	name = "Antirad"
	id = REAGENT_ID_ANTIRAD
	color = "#408000"
	metabolism = REM * 0.25
	overdose = REAGENTS_OVERDOSE
	scannable = 1

/datum/reagent/antirad/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.radiation = max(M.radiation - 30 * removed, 0)
	..()

/datum/reagent/antibiotic
	name = "Antibiotic"
	id = REAGENT_ID_ANTIBIOTIC
	color = "#C1C1C1"
	metabolism = REM * 0.05
	overdose = REAGENTS_OVERDOSE
	scannable = 1

/datum/reagent/carbon
	name = "Carbon"
	id = REAGENT_ID_CARBON
	color = "#1C1300"
	ingest_met = REM * 5

/datum/reagent/carbon/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.ingested && M.ingested.reagent_list.len > 1) // Need to have at least 2 reagents - cabon and something to remove
		var/effect = 1 / (M.ingested.reagent_list.len - 1)
		for(var/datum/reagent/R in M.ingested.reagent_list)
			if(R == src)
				continue
			M.ingested.remove_reagent(R.id, removed * effect)

/datum/reagent/carbon/touch_turf(var/turf/T)
	if(!istype(T, /turf/space))
		var/obj/effect/decal/cleanable/dirt/dirtoverlay = locate(/obj/effect/decal/cleanable/dirt, T)
		if (!dirtoverlay)
			dirtoverlay = new/obj/effect/decal/cleanable/dirt(T)
			dirtoverlay.alpha = volume * 30
		else
			dirtoverlay.alpha = min(dirtoverlay.alpha + volume * 30, 255)

/datum/reagent/toxin
	name = "Toxin"
	id = REAGENT_ID_TOXIN
	color = "#CF3600"
	metabolism = REM * 0.05 // 0.01 by default. They last a while and slowly kill you.
	toxic_blood = 4 // How much damage it deals per unit

/datum/reagent/morphine
	name = "Morphine"
	id = REAGENT_ID_MORPHINE

	color = "#800080"
	overdose = 20
	metabolism = 0.02

/datum/reagent/morphine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.add_chemical_effect(CE_PAINKILLER, 200)
	M.add_chemical_effect(CE_PULSE, -2)

/datum/reagent/morphine/overdose(var/mob/living/carbon/M, var/alien)
	..()
	M.druggy = max(M.druggy, 10)
	M.hallucination = max(M.hallucination, 3)

/datum/reagent/nicotine
	name = "Nicotine"
	id = REAGENT_ID_NICOTINE
	color = "#181818"

/datum/reagent/nicotine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.add_chemical_effect(CE_PULSE, 1)

/datum/reagent/jumpstart
	name = "Jumpstart"
	id = REAGENT_ID_JUMPSTART
	color = "#FF3300"
	metabolism = REM * 0.15
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/jumpstart/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(prob(5))
		M.emote(pick("twitch", "blink_r", "shiver"))
	M.add_chemical_effect(CE_SPEEDBOOST, 1)
	M.add_chemical_effect(CE_PULSE, -1)
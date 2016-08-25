/datum/reagent/blood
	data = new/list("donor" = null, "species" = "Human", "blood_traces" = null, "b_type" = null, "blood_colour" = DEFAULT_BLOOD_COLOUR, "trace_chem" = null)
	name = REAGENT_ID_BLOOD
	id = REAGENT_ID_BLOOD
	metabolism = REM * 5
	color = "#C80000"

/datum/reagent/blood/initialize_data(var/newdata)
	..()
	if(data && data["blood_colour"])
		color = data["blood_colour"]
	return

/datum/reagent/blood/touch_turf(var/turf/simulated/T)
	if(!istype(T) || volume < 3)
		return
	if(!data["donor"] || istype(data["donor"], /mob/living/human))
		blood_splatter(T, src, 1)

/datum/reagent/blood/affect_ingest(var/mob/living/human/M, var/alien, var/removed)
	if(dose > 5)
		M.adjustToxLoss(removed)
	if(dose > 15)
		M.adjustToxLoss(removed)

/datum/reagent/blood/affect_touch(var/mob/living/human/M, var/alien, var/removed)
	if(ishuman(M))
		var/mob/living/human/H = M
		if(H.isSynthetic())
			return

/datum/reagent/blood/affect_blood(var/mob/living/human/M, var/alien, var/removed)
	M.inject_blood(src, volume)
	remove_self(volume)

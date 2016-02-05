/datum/reagent/capsaicin
	name = "Capsaicin Oil"
	id = "capsaicin"
	description = "This is what makes chilis hot."
	reagent_state = LIQUID
	color = "#B31008"

/datum/reagent/capsaicin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.adjustToxLoss(0.5 * removed)

/datum/reagent/capsaicin/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return
	if(dose < 5 && (dose == metabolism || prob(5)))
		M << "<span class='danger'>Your insides feel uncomfortably hot!</span>"
	if(dose >= 5)
		M.apply_effect(2, AGONY, 0)
		if(prob(5))
			M.visible_message("<span class='warning'>[M] [pick("dry heaves!","coughs!","splutters!")]</span>", "<span class='danger'>You feel like your insides are burning!</span>")
	if(istype(M, /mob/living/carbon/slime))
		M.bodytemperature += rand(10, 25)
	holder.remove_reagent("frostoil", 5)

/datum/reagent/condensedcapsaicin
	name = "Condensed Capsaicin"
	id = "condensedcapsaicin"
	description = "A chemical agent used for self-defense and in police work."
	reagent_state = LIQUID
	touch_met = 50 // Get rid of it quickly
	color = "#B31008"

/datum/reagent/condensedcapsaicin/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.adjustToxLoss(0.5 * removed)

/datum/reagent/condensedcapsaicin/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	var/eyes_covered = 0
	var/mouth_covered = 0
	var/obj/item/safe_thing = null
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return
		if(H.head)
			if(H.head.body_parts_covered & EYES)
				eyes_covered = 1
				safe_thing = H.head
			if((H.head.body_parts_covered & FACE) && !(H.head.item_flags & FLEXIBLEMATERIAL))
				mouth_covered = 1
				safe_thing = H.head
		if(H.wear_mask)
			if(!eyes_covered && H.wear_mask.body_parts_covered & EYES)
				eyes_covered = 1
				safe_thing = H.wear_mask
			if(!mouth_covered && (H.wear_mask.body_parts_covered & FACE) && !(H.wear_mask.item_flags & FLEXIBLEMATERIAL))
				mouth_covered = 1
				safe_thing = H.wear_mask
		if(H.glasses && H.glasses.body_parts_covered & EYES)
			if(!eyes_covered)
				eyes_covered = 1
				if(!safe_thing)
					safe_thing = H.glasses
	if(eyes_covered && mouth_covered)
		M << "<span class='warning'>Your [safe_thing] protects you from the pepperspray!</span>"
		return
	else if(eyes_covered)
		M << "<span class='warning'>Your [safe_thing] protect you from most of the pepperspray!</span>"
		M.eye_blurry = max(M.eye_blurry, 15)
		M.eye_blind = max(M.eye_blind, 5)
		M.Stun(5)
		M.Weaken(5)
		return
	else if (mouth_covered) // Mouth cover is better than eye cover
		M << "<span class='warning'>Your [safe_thing] protects your face from the pepperspray!</span>"
		M.eye_blurry = max(M.eye_blurry, 5)
		return
	else // Oh dear :D
		M << "<span class='warning'>You're sprayed directly in the eyes with pepperspray!</span>"
		M.eye_blurry = max(M.eye_blurry, 25)
		M.eye_blind = max(M.eye_blind, 10)
		M.Stun(5)
		M.Weaken(5)
		return

/datum/reagent/condensedcapsaicin/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.can_feel_pain())
			return
	if(dose == metabolism)
		M << "<span class='danger'>You feel like your insides are burning!</span>"
	else
		M.apply_effect(4, AGONY, 0)
		if(prob(5))
			M.visible_message("<span class='warning'>[M] [pick("dry heaves!","coughs!","splutters!")]</span>", "<span class='danger'>You feel like your insides are burning!</span>")
	if(istype(M, /mob/living/carbon/slime))
		M.bodytemperature += rand(15, 30)
	holder.remove_reagent("frostoil", 5)


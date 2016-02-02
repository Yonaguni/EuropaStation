/datum/job/civilian/farmer
	title = "Farmer"
	job_category = IS_CIVIL
	total_positions = 3
	spawn_positions = 3

/datum/job/civilian/farmer/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/civilian/farmer/equip_survival(var/mob/living/carbon/human/H)
	return ..()
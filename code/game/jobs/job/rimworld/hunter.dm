/datum/job/borderworld/hunter
	title = "Hunter"
	job_category = IS_CIVIL
	total_positions = 2
	spawn_positions = 2
	alt_titles = list("Forager")

/datum/job/borderworld/hunter/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/borderworld/hunter/equip_survival(var/mob/living/carbon/human/H)
	return ..()
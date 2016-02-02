/datum/job/borderworld/sawbones
	title = "Sawbones"
	flag = WORKER
	job_category = IS_CIVIL
	total_positions = 1
	spawn_positions = 1
	alt_titles = list("Doctor")
	supervisors = "the Hippocratic Oath"
	selection_color = "#ffeeff"

/datum/job/borderworld/sawbones/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/borderworld/sawbones/equip_survival(var/mob/living/carbon/human/H)
	return ..()
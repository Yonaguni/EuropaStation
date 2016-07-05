/datum/job/borderworld
	title = "Vagrant"
	job_category = IS_CIVIL
	total_positions = -1
	spawn_positions = -1
	supervisors = "your conscience"
	selection_color = "#dddddd"
	idtype = null
	headsettype = null
	alt_titles = list("Citizen", "Homesteader", "Wanderer", "Visitor")

/datum/job/borderworld/equip(var/mob/living/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0, var/alt_rank)
	return ..()

/datum/job/borderworld/equip_survival(var/mob/living/human/H)
	return ..()
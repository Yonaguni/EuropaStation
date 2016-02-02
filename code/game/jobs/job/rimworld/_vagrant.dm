/datum/job/borderworld
	title = "Vagrant"
	flag = CIVILIAN
	job_category = IS_CIVIL
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "your conscience"
	selection_color = "#dddddd"
	department_flag = CIVILIAN
	idtype = null
	headsettype = null
	pdatype = null
	alt_titles = list("Citizen", "Homesteader", "Wanderer", "Visitor")

/datum/job/borderworld/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/borderworld/equip_survival(var/mob/living/carbon/human/H)
	return ..()
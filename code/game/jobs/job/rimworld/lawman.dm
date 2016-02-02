/datum/job/borderworld/lawman
	title = "Lawman"
	job_category = IS_GOVERNMENT
	flag = MARSHAL
	total_positions = 1
	spawn_positions = 1
	alt_titles = list("Deputy", "Sherrif")
	selection_color = "#ccccff"
	department_flag = GOVERNMENT

/datum/job/borderworld/lawman/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/borderworld/lawman/equip_survival(var/mob/living/carbon/human/H)
	return ..()
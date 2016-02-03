/datum/job/borderworld/governor
	title = "Governor"
	job_category = IS_GOVERNMENT
	total_positions = 1
	spawn_positions = 1
	selection_color = "#ccccff"
	department_flag = GOVERNMENT

/datum/job/borderworld/governor/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/borderworld/governor/equip_survival(var/mob/living/carbon/human/H)
	return ..()
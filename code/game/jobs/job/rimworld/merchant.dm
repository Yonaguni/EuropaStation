/datum/job/borderworld/merchant
	title = "Merchant"
	job_category = IS_CIVIL
	flag = LIAISON
	total_positions = 3
	spawn_positions = 3
	alt_titles = list("Trader", "Banker")
	selection_color = "#ccccff"
	department_flag = INDUSTRY

/datum/job/borderworld/merchant/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/borderworld/merchant/equip_survival(var/mob/living/carbon/human/H)
	return ..()
/datum/job/civilian/lawman
	title = "Lawman"
	total_positions = 1
	spawn_positions = 1
	alt_titles = list("Deputy", "Sherrif")

/datum/job/civilian/lawman/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/civilian/lawman/equip_survival(var/mob/living/carbon/human/H)
	return ..()
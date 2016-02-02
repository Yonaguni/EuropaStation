/datum/job/civilian/hunter
	title = "Hunter"
	total_positions = 2
	spawn_positions = 2

/datum/job/civilian/hunter/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/civilian/hunter/equip_survival(var/mob/living/carbon/human/H)
	return ..()
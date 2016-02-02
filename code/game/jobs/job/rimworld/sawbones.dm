/datum/job/civilian/sawbones
	title = "Sawbones"
	total_positions = 1
	spawn_positions = 1
	alt_titles = list("Doctor")

/datum/job/civilian/sawbones/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/civilian/sawbones/equip_survival(var/mob/living/carbon/human/H)
	return ..()
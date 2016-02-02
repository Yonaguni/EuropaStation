/datum/job/civilian/merchant
	title = "Merchant"
	total_positions = 3
	spawn_positions = 3
	alt_titles = list("Trader", "Banker")

/datum/job/civilian/merchant/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/civilian/merchant/equip_survival(var/mob/living/carbon/human/H)
	return ..()
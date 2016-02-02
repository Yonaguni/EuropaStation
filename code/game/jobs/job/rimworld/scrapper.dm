/datum/job/civilian/scrapper
	title = "Scrapper"
	job_category = IS_INDUSTRY
	total_positions = 2
	spawn_positions = 2
	alt_titles = list("Salvager","Archaeologist")

/datum/job/civilian/scrapper/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/civilian/scrapper/equip_survival(var/mob/living/carbon/human/H)
	return ..()
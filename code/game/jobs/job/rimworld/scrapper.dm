/datum/job/borderworld/scrapper
	title = "Scrapper"
	job_category = IS_INDUSTRY
	total_positions = 2
	spawn_positions = 2
	alt_titles = list("Salvager","Scav","Archaeologist")
	selection_color = "#ffeeff"

/datum/job/borderworld/scrapper/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/borderworld/scrapper/equip_survival(var/mob/living/carbon/human/H)
	return ..()
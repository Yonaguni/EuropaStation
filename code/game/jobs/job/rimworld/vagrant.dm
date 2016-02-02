/datum/job/civilian/vagrant
	title = "Vagrant"
	job_category = IS_CIVIL
	total_positions = -1
	spawn_positions = -1

/datum/job/civilian/vagrant/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	return ..()

/datum/job/civilian/vagrant/equip_survival(var/mob/living/carbon/human/H)
	return ..()
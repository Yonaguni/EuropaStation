var/list/stored_shock_by_ref = list()

/mob/living/proc/apply_stored_shock_to(var/mob/living/target)
	if(stored_shock_by_ref["\ref[src]"])
		target.electrocute_act(stored_shock_by_ref["\ref[src]"]*0.9, src)
		stored_shock_by_ref["\ref[src]"] = 0

/datum/species/proc/can_prone()
	return 1

/datum/species/proc/handle_pre_move(var/mob/living/carbon/human/H)
	return 1

/datum/species/proc/handle_post_move(var/mob/living/carbon/human/H)
	return
/mob/living/aquatic/proc/handle_behavior()

	if((behavior_flags & FISH_FORM_SCHOOLS) && !following)
		update_flocking()

/mob/living/aquatic/proc/update_flocking()
	//world << "trying to find a leader to follow"
	return

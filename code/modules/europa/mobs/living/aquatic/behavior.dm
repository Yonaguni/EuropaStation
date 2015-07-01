/mob/living/aquatic/proc/handle_behavior()
	if(client && key)
		return
/*
	already_moved = null
	if(behavior_flags & FISH_FORM_SCHOOLS)
		update_flocking()
	sleep(-1)
	if(behavior_flags & FISH_AGGRESSIVE)
		update_mob_target()

/mob/living/aquatic/proc/update_flocking()

	if(client && key)
		following = null
		if(school)
			school.disperse()
		return

	// Are we flocking?
	if(following)
		var/follow_dist = get_dist(src, following)
		if(follow_dist >= follow_dist_min && follow_dist <= follow_dist_max)
			if(follow_dist < follow_dist_min)
				if(!already_moved)
					already_moved = 1
					src.Move(get_step(src,get_dist(following,src)))
			else if(follow_dist > follow_dist_min)
				if(!already_moved)
					already_moved = 1
					src.Move(get_step(src,get_dir(src,following)))
		else
			if(school)
				school.remove(src)
				school = null
				following = null
				update_followers()
	else if(!school)
		update_followers()

/mob/living/aquatic/proc/update_followers()
	var/list/updates_needed = list()
	for(var/mob/living/aquatic/A in view(follow_dist_max, src))
		if(A == src) continue
		if(!school)
			school = new
			school.add(src)
		if(!A.stat && A.will_follow(src))
			if(A.school)
				if(A.school == school)
					continue
				A.school.disperse()
				A.school = null
			following = src
			school.add(A)
			updates_needed |= A
	for(var/mob/living/aquatic/A in updates_needed)
		A.update_followers()

/mob/living/aquatic/proc/will_follow(var/mob/living/M)
	return (M && M.type == type)

/mob/living/aquatic/proc/update_mob_target()
	return 1

/mob/living/aquatic/proc/set_school(var/datum/fish_school/new_school)
	school.disperse()
	school = new_school
	update_followers()
*/
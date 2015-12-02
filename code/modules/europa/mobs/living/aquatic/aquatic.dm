/mob/living/aquatic
	name = "fish"
	desc = "Here, fishy fishy."
	icon = 'icons/mob/europa/aquatic.dmi'
	icon_state =      "fish"
	var/icon_living = "fish"
	var/icon_dying =  "fish_dying"
	var/icon_dead =   "fish_dead"

	// Behavior vars.
	var/current_mood = FISH_MOOD_CALM // Used in behavior calculation.
	var/hunger = 0                    // Current desire to feed.
	var/datum/fish_school/school
	var/mob/living/aquatic/following
	var/atom/movable/current_target   // What are we attacking currently?
	var/follow_dist_min               // Minimum distance to maintain from neighbors.
	var/follow_dist_max               // Bound at which flocking behavior fails.
	var/target_check_range = 5        // Distance to look for new targets.
	var/behavior_flags = 0            // Used for indicating various behavior processing.
	var/required_gas = "water"        // Requires water to survive.
	var/gas_amount = 60               // Required moles of above.
	var/suffocating                   // Are we currently suffocating?
	var/already_moved

/mob/living/aquatic/proc/update_icon()
	if(stat == DEAD)
		if(icon_dead) icon_state = icon_dead
	else if(suffocating)
		if(icon_dying) icon_state = icon_dying
	else if(icon_living)
		icon_state = icon_living
	else
		icon_state = initial(icon_state)

/mob/living/aquatic/water_act(var/depth)
	return

/mob/living/aquatic/grump
	icon_state =  "grump"
	icon_living = "grump"
	icon_dying =  "grump_dying"
	icon_dead =   "grump_dead"

/mob/living/aquatic/content
	icon_state =  "content"
	icon_living = "content"
	icon_dying =  "content_dying"
	icon_dead =   "content_dead"

/mob/living/aquatic/judge
	icon_state =  "judge"
	icon_living = "judge"
	icon_dying =  "judge_dying"
	icon_dead =   "judge_dead"

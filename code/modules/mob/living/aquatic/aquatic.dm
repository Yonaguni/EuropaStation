/mob/living/aquatic
	name = "fish"
	desc = "Here, fishy fishy."
	icon = 'icons/mob/aquatic.dmi'
	icon_state =      "fish"
	var/icon_living = "fish"
	var/icon_dying =  "fish_dying"
	var/icon_dead =   "fish_dead"

	var/atom/movable/following
	var/behavior_flags = FISH_FORM_SCHOOLS
	var/required_gas = "water" // Requires water to survive.
	var/gas_amount = 60        // Required moles of above.
	var/suffocating

/mob/living/aquatic/proc/update_icon()
	if(stat == DEAD)
		if(icon_dead) icon_state = icon_dead
	else if(suffocating)
		if(icon_dying) icon_state = icon_dying
	else if(icon_living)
		icon_state = icon_living
	else
		icon_state = initial(icon_state)

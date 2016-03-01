/datum/expansion/multitool/circuitboards/CanUseTopic(var/mob/user)
	if(isAI(user)) // No remote AI access
		return UI_CLOSE

	return ..()

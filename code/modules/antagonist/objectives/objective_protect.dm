
///////
// PROTECT
///////
/datum/objective/protect //The opposite of killing a dude.
	explanation_text = "Free Objective."

/datum/objective/protect/find_target()
	..()
	if(target && target.current)
		explanation_text = "Protect [target.current.real_name], the [target.assigned_role]."
	return target

/datum/objective/protect/find_target_by_role(role, role_type=0)
	..(role, role_type)
	if(target && target.current)
		explanation_text = "Protect [target.current.real_name], the [!role_type ? target.assigned_role : target.special_role]."
	return target

/datum/objective/protect/check_completion()
	if(!target)			//If it's a free objective.
		return 1
	if(target.current)
		if(target.current.stat == DEAD || issilicon(target.current) || isbrain(target.current))
			return 0
		return 1
	return 0

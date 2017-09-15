
datum/objective/anti_revolution/execute
	find_target()
		..()
		if(target && target.current)
			explanation_text = "[target.current.real_name], the [target.assigned_role] has extracted confidential information above their clearance. Execute \him[target.current]."
		else
			explanation_text = "Free Objective"
		return target


	find_target_by_role(role, role_type=0)
		..(role, role_type)
		if(target && target.current)
			explanation_text = "[target.current.real_name], the [!role_type ? target.assigned_role : target.special_role] has extracted confidential information above their clearance. Execute \him[target.current]."
		else
			explanation_text = "Free Objective"
		return target

	check_completion()
		if(target && target.current)
			if(target.current.stat == DEAD || !ishuman(target.current))
				return 1
			return 0
		return 1

datum/objective/anti_revolution/brig
	var/already_completed = 0

	find_target()
		..()
		if(target && target.current)
			explanation_text = "Brig [target.current.real_name], the [target.assigned_role] for 20 minutes to set an example."
		else
			explanation_text = "Free Objective"
		return target


	find_target_by_role(role, role_type=0)
		..(role, role_type)
		if(target && target.current)
			explanation_text = "Brig [target.current.real_name], the [!role_type ? target.assigned_role : target.special_role] for 20 minutes to set an example."
		else
			explanation_text = "Free Objective"
		return target

	check_completion()
		if(already_completed)
			return 1

		if(target && target.current)
			if(target.current.stat == DEAD)
				return 0
			if(target.is_brigged(10 * 60 * 10))
				already_completed = 1
				return 1
			return 0
		return 0

datum/objective/anti_revolution/demote
	find_target()
		..()
		if(target && target.current)
			explanation_text = "[target.current.real_name], the [target.assigned_role]  has been classified as harmful to [using_map.company_name]'s goals. Demote \him[target.current] to assistant."
		else
			explanation_text = "Free Objective"
		return target

	find_target_by_role(role, role_type=0)
		..(role, role_type)
		if(target && target.current)
			explanation_text = "[target.current.real_name], the [!role_type ? target.assigned_role : target.special_role] has been classified as harmful to [using_map.company_name]'s goals. Demote \him[target.current] to assistant."
		else
			explanation_text = "Free Objective"
		return target

	check_completion()
		if(target && target.current && istype(target,/mob/living/carbon/human))
			var/obj/item/card/id/I = target.current:wear_id
			if(istype(I, /obj/item/radio/headset/pda))
				var/obj/item/radio/headset/pda/P = I
				I = P.id

			if(!istype(I)) return 1

			if(I.assignment == using_map.default_role)
				return 1
			else
				return 0
		return 1

/datum/objective/rev/find_target()
	..()
	if(target && target.current)
		explanation_text = "Assassinate, capture or convert [target.current.real_name], the [target.assigned_role]."
	else
		explanation_text = "Free Objective"
	return target


/datum/objective/rev/find_target_by_role(role, role_type=0)
	..(role, role_type)
	if(target && target.current)
		explanation_text = "Assassinate, capture or convert [target.current.real_name], the [!role_type ? target.assigned_role : target.special_role]."
	else
		explanation_text = "Free Objective"
	return target

/datum/objective/rev/check_completion()
	var/rval = 1
	if(target && target.current)
		var/mob/living/carbon/human/H = target.current
		if(!istype(H))
			return 1
		if(H.stat == DEAD || H.restrained())
			return 1
		// Check if they're converted
		if(target in revs.current_antagonists)
			return 1
		var/turf/T = get_turf(H)
		if(T && isNotStationLevel(T.z))			//If they leave the station they count as dead for this
			rval = 2
		return 0
	return rval


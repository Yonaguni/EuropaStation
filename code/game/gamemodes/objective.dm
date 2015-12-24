//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31
var/global/list/all_objectives = list()

/datum/objective
	var/datum/mind/owner = null			//Who owns the objective.
	var/explanation_text = "Nothing"	//What that person is supposed to do.
	var/datum/mind/target = null		//If they are focused on a particular person.
	var/target_amount = 0				//If they are focused on a particular number. Steal objectives have their own counter.
	var/completed = 0					//currently only used for custom objectives.

/datum/objective/New(var/text)
	all_objectives |= src
	if(text) explanation_text = text

/datum/objective/Destroy()
	all_objectives -= src
	return ..()

/datum/objective/proc/check_completion()
	return completed

/datum/objective/proc/find_target()
	var/list/possible_targets = list()
	for(var/datum/mind/possible_target in ticker.minds)
		if(possible_target != owner && ishuman(possible_target.current) && (possible_target.current.stat != 2))
			possible_targets += possible_target
	if(possible_targets.len > 0)
		target = pick(possible_targets)

/datum/objective/proc/find_target_by_role(role, role_type=0)//Option sets either to check assigned role or special role. Default to assigned.
	for(var/datum/mind/possible_target in ticker.minds)
		if((possible_target != owner) && ishuman(possible_target.current) && ((role_type ? possible_target.special_role : possible_target.assigned_role) == role) )
			target = possible_target
			break

///////
// ASSASSINATE
///////
/datum/objective/assassinate
	explanation_text = "Free Objective"

/datum/objective/assassinate/find_target()
	..()
	if(target && target.current)
		explanation_text = "Assassinate [target.current.real_name], the [target.assigned_role]."
	return target

/datum/objective/assassinate/find_target_by_role(role, role_type=0)
	..(role, role_type)
	if(target && target.current)
		explanation_text = "Assassinate [target.current.real_name], the [!role_type ? target.assigned_role : target.special_role]."
	return target

/datum/objective/assassinate/check_completion()
	if(target && target.current)
		if(target.current.stat == DEAD || issilicon(target.current) || isbrain(target.current) || target.current.z > 6 || !target.current.ckey) //Borgs/brains/AIs count as dead for traitor objectives. --NeoFite
			return 1
		return 0
	return 1

///////
// DEBRAIN
///////
/datum/objective/debrain //I want braaaainssss
	explanation_text = "Free Objective"

/datum/objective/debrain/find_target()
	..()
	if(target && target.current)
		explanation_text = "Steal the brain of [target.current.real_name]."
	return target


/datum/objective/debrain/find_target_by_role(role, role_type=0)
	..(role, role_type)
	if(target && target.current)
		explanation_text = "Steal the brain of [target.current.real_name] the [!role_type ? target.assigned_role : target.special_role]."
	return target

/datum/objective/debrain/check_completion()
	if(!target)//If it's a free objective.
		return 1
	if( !owner.current || owner.current.stat==DEAD )//If you're otherwise dead.
		return 0
	if( !target.current || !isbrain(target.current) )
		return 0
	var/atom/A = target.current
	while(A.loc)			//check to see if the brainmob is on our person
		A = A.loc
		if(A == owner.current)
			return 1
	return 0

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

///////
// SILENCE
///////
/datum/objective/silence
	explanation_text = "Do not allow anyone to escape the colony alive."

/datum/objective/silence/check_completion()
	if(!emergency_shuttle.returned())
		return 0

	for(var/mob/living/player in player_list)
		if(player == owner.current)
			continue
		if(player.mind)
			if(player.stat != DEAD)
				var/turf/T = get_turf(player)
				if(!T)	continue
				switch(T.loc.type)
					if(/area/shuttle/escape/centcom, /area/shuttle/escape_pod1/centcom, /area/shuttle/escape_pod2/centcom, /area/shuttle/escape_pod3/centcom, /area/shuttle/escape_pod5/centcom)
						return 0
	return 1

///////
// ESCAPE
///////
/datum/objective/escape
	explanation_text = "Escape the colony alive and free."

/datum/objective/escape/check_completion()
		return 0

///////
// SURVIVE
///////
/datum/objective/survive
	explanation_text = "Stay alive until the end."

	check_completion()
		if(!owner.current || owner.current.stat == DEAD || isbrain(owner.current))
			return 0		//Brains no longer win survive objectives. --NEO
		if(issilicon(owner.current) && owner.current != owner.original)
			return 0
		return 1

///////
// HARM - Harm a crew member, making an example of them
///////
/datum/objective/harm
	var/already_completed = 0
	explanation_text = "Free Objective"

/datum/objective/harm/find_target()
	..()
	if(target && target.current)
		explanation_text = "Make an example of [target.current.real_name], the [target.assigned_role]. Break one of their bones, detach one of their limbs or disfigure their face. Make sure they're alive when you do it."
	return target

/datum/objective/harm/find_target_by_role(role, role_type=0)
	..(role, role_type)
	if(target && target.current)
		explanation_text = "Make an example of [target.current.real_name], the [!role_type ? target.assigned_role : target.special_role]. Break one of their bones, detach one of their limbs or disfigure their face. Make sure they're alive when you do it."
	return target

/datum/objective/harm/check_completion()
	if(already_completed)
		return 1

	if(target && target.current && istype(target.current, /mob/living/carbon/human))
		if(target.current.stat == DEAD)
			return 0

		var/mob/living/carbon/human/H = target.current
		for(var/obj/item/organ/external/E in H.organs)
			if(E.status & ORGAN_BROKEN)
				return 1
		for(var/limb_tag in H.species.has_limbs) //todo check prefs for robotic limbs and amputations.
			var/list/organ_data = H.species.has_limbs[limb_tag]
			var/limb_type = organ_data["path"]
			var/found
			for(var/obj/item/organ/external/E in H.organs)
				if(limb_type == E.type)
					found = 1
					break
			if(!found)
				return 1

		var/obj/item/organ/external/head/head = H.get_organ("head")
		if(head.disfigured)
			return 1
	return 0

///////
// STEAL
///////
/datum/objective/steal
	var/obj/item/steal_target
	var/target_name

	var/global/possible_items[] = list(
		"a hand teleporter" = /obj/item/weapon/hand_tele,
		"an RCD" = /obj/item/weapon/rcd,
		"a jetpack" = /obj/item/weapon/tank/jetpack,
		"a captain's jumpsuit" = /obj/item/clothing/under/rank/captain,
		"a functional AI" = /obj/item/device/aicard,
		"a pair of magboots" = /obj/item/clothing/shoes/magboots,
		"a nasa voidsuit" = /obj/item/clothing/suit/space/void,
		"28 moles of phoron (full tank)" = /obj/item/weapon/tank,
		"a piece of corgi meat" = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/corgi,
		"a research director's jumpsuit" = /obj/item/clothing/under/rank/research_director,
		"a chief engineer's jumpsuit" = /obj/item/clothing/under/rank/chief_engineer,
		"a chief medical officer's jumpsuit" = /obj/item/clothing/under/rank/chief_medical_officer,
		"a head of security's jumpsuit" = /obj/item/clothing/under/rank/head_of_security,
		"a head of personnel's jumpsuit" = /obj/item/clothing/under/rank/head_of_personnel,
		"the hypospray" = /obj/item/weapon/reagent_containers/hypospray,
		"an ablative armor vest" = /obj/item/clothing/suit/armor/laserproof,
	)

	var/global/possible_items_special[] = list(
		/*"nuclear authentication disk" = /obj/item/weapon/disk/nuclear,*///Broken with the change to nuke disk making it respawn on z level change.
		"diamond drill" = /obj/item/weapon/pickaxe/diamonddrill,
		"bag of holding" = /obj/item/weapon/storage/backpack/holding,
		"hyper-capacity cell" = /obj/item/weapon/cell/hyper,
		"10 diamonds" = /obj/item/stack/material/diamond,
		"50 gold bars" = /obj/item/stack/material/gold,
		"25 refined uranium bars" = /obj/item/stack/material/uranium,
	)


/datum/objective/steal/proc/set_target(item_name)
	target_name = item_name
	steal_target = possible_items[target_name]
	if (!steal_target )
		steal_target = possible_items_special[target_name]
	explanation_text = "Steal [target_name]."
	return steal_target


/datum/objective/steal/find_target()
	return set_target(pick(possible_items))


/datum/objective/steal/proc/select_target()
	var/list/possible_items_all = possible_items+possible_items_special+"custom"
	var/new_target = input("Select target:", "Objective target", steal_target) as null|anything in possible_items_all
	if (!new_target) return
	if (new_target == "custom")
		var/obj/item/custom_target = input("Select type:","Type") as null|anything in typesof(/obj/item)
		if (!custom_target) return
		var/tmp_obj = new custom_target
		var/custom_name = tmp_obj:name
		qdel(tmp_obj)
		custom_name = sanitize(input("Enter target name:", "Objective target", custom_name) as text|null)
		if (!custom_name) return
		target_name = custom_name
		steal_target = custom_target
		explanation_text = "Steal [target_name]."
	else
		set_target(new_target)
	return steal_target

/datum/objective/steal/check_completion()
	if(!steal_target || !owner.current)	return 0
	if(!isliving(owner.current))	return 0
	var/list/all_items = owner.current.get_contents()
	switch (target_name)
		if("28 moles of phoron (full tank)","10 diamonds","50 gold bars","25 refined uranium bars")
			var/target_amount = text2num(target_name)//Non-numbers are ignored.
			var/found_amount = 0.0//Always starts as zero.

			for(var/obj/item/I in all_items) //Check for phoron tanks
				if(istype(I, steal_target))
					found_amount += (target_name=="28 moles of fuel (full tank)" ? (I:air_contents:gas["fuel"]) : (I:amount))
			return found_amount>=target_amount

		if("50 coins (in bag)")
			var/obj/item/weapon/moneybag/B = locate() in all_items

			if(B)
				var/target = text2num(target_name)
				var/found_amount = 0.0
				for(var/obj/item/weapon/coin/C in B)
					found_amount++
				return found_amount>=target

		if("a functional AI")

			for(var/obj/item/device/aicard/C in all_items) //Check for ai card
				for(var/mob/living/silicon/ai/M in C)
					if(istype(M, /mob/living/silicon/ai) && M.stat != 2) //See if any AI's are alive inside that card.
						return 1

			for(var/mob/living/silicon/ai/ai in living_mob_list)
				var/turf/T = get_turf(ai)
				if(istype(T))
					var/area/check_area = get_area(ai)
					if(istype(check_area, /area/shuttle/escape/centcom))
						return 1
					if(istype(check_area, /area/shuttle/escape_pod1/centcom))
						return 1
					if(istype(check_area, /area/shuttle/escape_pod2/centcom))
						return 1
					if(istype(check_area, /area/shuttle/escape_pod3/centcom))
						return 1
					if(istype(check_area, /area/shuttle/escape_pod5/centcom))
						return 1
		else
			for(var/obj/I in all_items) //Check for items
				if(istype(I, steal_target))
					return 1
	return 0

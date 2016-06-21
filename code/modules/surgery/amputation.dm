/datum/surgery_step/generic/amputate
	allowed_tools = list(
	/obj/item/weapon/circular_saw = 100, \
	/obj/item/weapon/material/hatchet = 75
	)

	min_duration = 110
	max_duration = 160

	can_use(mob/living/user, mob/living/human/target, target_zone, obj/item/tool)
		if (target_zone == O_EYES)	//there are specific steps for eye surgery
			return 0
		if (!hasorgans(target))
			return 0
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if (affected == null)
			return 0
		return !affected.cannot_amputate

	begin_step(mob/user, mob/living/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("[user] is beginning to amputate [target]'s [affected.name] with \the [tool]." , \
		"You are beginning to cut through [target]'s [affected.amputation_point] with \the [tool].")
		target.custom_pain("Your [affected.amputation_point] is being ripped apart!",1)
		..()

	end_step(mob/living/user, mob/living/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\blue [user] amputates [target]'s [affected.name] at the [affected.amputation_point] with \the [tool].", \
		"\blue You amputate [target]'s [affected.name] with \the [tool].")
		affected.droplimb(1,DROPLIMB_EDGE)

	fail_step(mob/living/user, mob/living/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\red [user]'s hand slips, sawing through the bone in [target]'s [affected.name] with \the [tool]!", \
		"\red Your hand slips, sawwing through the bone in [target]'s [affected.name] with \the [tool]!")
		affected.createwound(CUT, 30)
		affected.fracture()

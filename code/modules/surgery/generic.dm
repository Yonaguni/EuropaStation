//Procedures in this file: Gneric surgery steps
//////////////////////////////////////////////////////////////////
//						COMMON STEPS							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/generic/
	can_infect = 1
	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (isslime(target))
			return 0
		if (target_zone == O_EYES)	//there are specific steps for eye surgery
			return 0
		if (!hasorgans(target))
			return 0
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if (affected == null)
			return 0
		if (affected.is_stump())
			return 0
		if (affected.status & ORGAN_ROBOT)
			return 0
		return 1

/datum/surgery_step/generic/cut_open
	allowed_tools = list(
	/obj/item/weapon/scalpel = 100,		\
	/obj/item/weapon/material/knife = 75,	\
	/obj/item/weapon/material/shard = 50, 		\
	)

	min_duration = 90
	max_duration = 110

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if(..())
			var/obj/item/organ/external/affected = target.get_organ(target_zone)
			return affected && affected.is_open() == 0 && target_zone != O_MOUTH

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("[user] starts the incision on [target]'s [affected.name] with \the [tool].", \
		"You start the incision on [target]'s [affected.name] with \the [tool].")
		target.custom_pain("You feel a horrible pain as if from a sharp knife in your [affected.name]!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\blue [user] has made an incision on [target]'s [affected.name] with \the [tool].", \
		"\blue You have made an incision on [target]'s [affected.name] with \the [tool].",)
		affected.open = 1

		if(istype(target) && target.should_have_organ(O_HEART))
			affected.status |= ORGAN_BLEEDING
		affected.createwound(CUT, 15)
		affected.update_damages()

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\red [user]'s hand slips, slicing open [target]'s [affected.name] in the wrong place with \the [tool]!", \
		"\red Your hand slips, slicing open [target]'s [affected.name] in the wrong place with \the [tool]!")
		target.apply_damage(rand(5,10), BRUTE< affected)

/datum/surgery_step/generic/cauterize_bleeders
	allowed_tools = list(
		/obj/item/weapon/cautery = 100,			\
		/obj/item/clothing/mask/smokable/cigarette = 75,	\
		/obj/item/weapon/flame/lighter = 50,			\
		/obj/item/weapon/weldingtool = 25
	)

	min_duration = 40
	max_duration = 60

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if(..())
			var/obj/item/organ/external/affected = target.get_organ(target_zone)
			return affected && affected.is_open() && (affected.status & ORGAN_BLEEDING)

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("[user] starts cauterizing bleeders in [target]'s [affected.name] with \the [tool].", \
		"You start cauterizing bleeders in [target]'s [affected.name] with \the [tool].")
		target.custom_pain("The pain in your [affected.name] is maddening!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\blue [user] cauterizes bleeders in [target]'s [affected.name] with \the [tool].",	\
		"\blue You cauterizes bleeders in [target]'s [affected.name] with \the [tool].")
		affected.clamp()
		spread_germs_to_organ(affected, user)

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\red [user]'s hand slips, leaving a large burn on [target]'s [affected.name] with \the [tool]!",	\
		"\red Your hand slips, leaving a large burn on [target]'s [affected.name] with \the [tool]!",)
		affected.createwound(BURN, 10)

/datum/surgery_step/generic/retract_skin
	allowed_tools = list(
	/obj/item/weapon/retractor = 100, 	\
	/obj/item/weapon/crowbar = 75,	\
	/obj/item/weapon/material/kitchen/utensil/fork = 50
	)

	min_duration = 30
	max_duration = 40

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if(..())
			var/obj/item/organ/external/affected = target.get_organ(target_zone)
			return affected && affected.is_open() == 1 //&& !(affected.status & ORGAN_BLEEDING)

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		var/msg = "[user] starts to pry open the incision on [target]'s [affected.name] with \the [tool]."
		var/self_msg = "You start to pry open the incision on [target]'s [affected.name] with \the [tool]."
		if (target_zone == BP_TORSO)
			msg = "[user] starts to separate the ribcage and rearrange the organs in [target]'s torso with \the [tool]."
			self_msg = "You start to separate the ribcage and rearrange the organs in [target]'s torso with \the [tool]."
		if (target_zone == BP_GROIN)
			msg = "[user] starts to pry open the incision and rearrange the organs in [target]'s lower abdomen with \the [tool]."
			self_msg = "You start to pry open the incision and rearrange the organs in [target]'s lower abdomen with \the [tool]."
		user.visible_message(msg, self_msg)
		target.custom_pain("It feels like the skin on your [affected.name] is on fire!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		var/msg = "\blue [user] keeps the incision open on [target]'s [affected.name] with \the [tool]."
		var/self_msg = "\blue You keep the incision open on [target]'s [affected.name] with \the [tool]."
		if (target_zone == BP_TORSO)
			msg = "\blue [user] keeps the ribcage open on [target]'s torso with \the [tool]."
			self_msg = "\blue You keep the ribcage open on [target]'s torso with \the [tool]."
		if (target_zone == BP_GROIN)
			msg = "\blue [user] keeps the incision open on [target]'s lower abdomen with \the [tool]."
			self_msg = "\blue You keep the incision open on [target]'s lower abdomen with \the [tool]."
		user.visible_message(msg, self_msg)
		affected.open = 2

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		var/msg = "\red [user]'s hand slips, tearing the edges of the incision on [target]'s [affected.name] with \the [tool]!"
		var/self_msg = "\red Your hand slips, tearing the edges of the incision on [target]'s [affected.name] with \the [tool]!"
		if (target_zone == BP_TORSO)
			msg = "\red [user]'s hand slips, damaging several organs in [target]'s torso with \the [tool]!"
			self_msg = "\red Your hand slips, damaging several organs in [target]'s torso with \the [tool]!"
		if (target_zone == BP_GROIN)
			msg = "\red [user]'s hand slips, damaging several organs in [target]'s lower abdomen with \the [tool]"
			self_msg = "\red Your hand slips, damaging several organs in [target]'s lower abdomen with \the [tool]!"
		user.visible_message(msg, self_msg)
		target.apply_damage(12, BRUTE, affected, sharp=1)

/datum/surgery_step/generic/amputate
	allowed_tools = list(
	/obj/item/weapon/circular_saw = 100, \
	/obj/item/weapon/material/hatchet = 75
	)

	min_duration = 110
	max_duration = 160

	can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if (target_zone == O_EYES)	//there are specific steps for eye surgery
			return 0
		if (!hasorgans(target))
			return 0
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if (affected == null)
			return 0
		return !affected.cannot_amputate

	begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("[user] is beginning to amputate [target]'s [affected.name] with \the [tool]." , \
		"You are beginning to cut through [target]'s [affected.amputation_point] with \the [tool].")
		target.custom_pain("Your [affected.amputation_point] is being ripped apart!",1)
		..()

	end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\blue [user] amputates [target]'s [affected.name] at the [affected.amputation_point] with \the [tool].", \
		"\blue You amputate [target]'s [affected.name] with \the [tool].")
		affected.droplimb(1,DROPLIMB_EDGE)

	fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		user.visible_message("\red [user]'s hand slips, sawing through the bone in [target]'s [affected.name] with \the [tool]!", \
		"\red Your hand slips, sawwing through the bone in [target]'s [affected.name] with \the [tool]!")
		affected.createwound(CUT, 30)
		affected.fracture()

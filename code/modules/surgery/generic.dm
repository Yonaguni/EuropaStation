//Procedures in this file: Gneric surgery steps
//////////////////////////////////////////////////////////////////
//						COMMON STEPS							//
//////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
//	generic surgery step datum
//////////////////////////////////////////////////////////////////
/datum/surgery_step/generic
	can_infect = 1
	priority = 1

/datum/surgery_step/generic/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (target_zone == BP_EYES)	//there are specific steps for eye surgery
		return 0
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if (affected == null)
		return 0
	if (affected.is_stump())
		return 0
	if (affected.robotic >= ORGAN_ROBOT)
		return 0
	return 1

//////////////////////////////////////////////////////////////////
//	 scalpel surgery step
//////////////////////////////////////////////////////////////////
/datum/surgery_step/generic/cut_open

	name = "Begin incision."
	desc = "Create an incision."

	allowed_tools = list(
	/obj/item/scalpel = 100,		\
	/obj/item/material/knife = 75,	\
	/obj/item/material/shard = 50, 		\
	)

	min_duration = 90
	max_duration = 110

/datum/surgery_step/generic/cut_open/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		if(affected.is_open())
			user << "<span class='notice'>\The [affected] is already cut open.</span>"
			return -1
		return affected && target_zone != BP_MOUTH

/datum/surgery_step/generic/cut_open/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("[user] starts the incision on [target]'s [affected.name] with \the [tool].", \
	"You start the incision on [target]'s [affected.name] with \the [tool].")
	target.custom_pain("You feel a horrible pain as if from a sharp knife in your [affected.name]!",1)
	..()

/datum/surgery_step/generic/cut_open/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] has made an incision on [target]'s [affected.name] with \the [tool].</span>", \
	"<span class='notice'>You have made an incision on [target]'s [affected.name] with \the [tool].</span>",)

	affected.createwound(CUT, WOUND_AUTOHEAL_POINT)
	affected.update_damages()
	playsound(target.loc, 'sound/weapons/bladeslice.ogg', 50, 1)

/datum/surgery_step/generic/cut_open/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='warning'>[user]'s hand slips, slicing open [target]'s [affected.name] in the wrong place with \the [tool]!</span>", \
	"<span class='warning'>Your hand slips, slicing open [target]'s [affected.name] in the wrong place with \the [tool]!</span>")
	target.apply_damage(rand(5,10), BRUTE)

//////////////////////////////////////////////////////////////////
//	 bleeder clamping surgery step
//////////////////////////////////////////////////////////////////
/datum/surgery_step/generic/cauterize_bleeders

	name = "Cauterize bleeders."
	desc = "Prevent an incision from bleeding. Requires an incision."

	allowed_tools = list(
		/obj/item/cautery = 100,
		/obj/item/clothing/mask/smokable/cigarette = 75,
		/obj/item/flame/lighter = 50,
		/obj/item/weldingtool = 25
	)

	min_duration = 40
	max_duration = 60

/datum/surgery_step/generic/cauterize_bleeders/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(..())
		var/obj/item/organ/external/affected = target.get_organ(target_zone)
		return affected && affected.is_open() && (affected.status & ORGAN_BLEEDING)

/datum/surgery_step/generic/cauterize_bleeders/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("[user] starts cauterizing bleeders in [target]'s [affected.name] with \the [tool].", \
	"You start cauterizing bleeders in [target]'s [affected.name] with \the [tool].")
	target.custom_pain("The pain in your [affected.name] is maddening!",1)
	..()

/datum/surgery_step/generic/cauterize_bleeders/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] cauterizes bleeders in [target]'s [affected.name] with \the [tool].</span>",	\
	"<span class='notice'>You clamp bleeders in [target]'s [affected.name] with \the [tool].</span>")
	affected.clamp()
	spread_germs_to_organ(affected, user)
	playsound(target.loc, 'sound/items/Welder.ogg', 50, 1)

/datum/surgery_step/generic/cauterize_bleeders/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='warning'>[user]'s hand slips, leaving a large burn on [target]'s [affected.name] with \the [tool]!</span>",	\
	"<span class='warning'>Your hand slips, tleaving a large burn on [target]'s [affected.name] with \the [tool]!</span>",)
	affected.createwound(BURN, 10)


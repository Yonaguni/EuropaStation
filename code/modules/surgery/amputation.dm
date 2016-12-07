//////////////////////////////////////////////////////////////////
//	 limb amputation surgery step
//////////////////////////////////////////////////////////////////
/datum/surgery_step/amputate

	name = "Amputate limb."
	desc = "Completely amputate a limb."

	allowed_tools = list(
	/obj/item/circular_saw = 100, \
	/obj/item/material/hatchet = 75
	)

	min_duration = 110
	max_duration = 160

/datum/surgery_step/amputate/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if (target_zone == BP_EYES)	//there are specific steps for eye surgery
		return 0
	if (!hasorgans(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if (affected == null)
		return 0
	return !affected.cannot_amputate

/datum/surgery_step/amputate/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("[user] is beginning to amputate [target]'s [affected.name] with \the [tool]." , \
	"You are beginning to cut through [target]'s [affected.amputation_point] with \the [tool].")
	target.custom_pain("Your [affected.amputation_point] is being ripped apart!",1)
	..()

/datum/surgery_step/amputate/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>[user] amputates [target]'s [affected.name] at the [affected.amputation_point] with \the [tool].</span>", \
	"<span class='notice'>You amputate [target]'s [affected.name] with \the [tool].</span>")
	affected.droplimb(1,DROPLIMB_EDGE)

/datum/surgery_step/amputate/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='warning'>[user]'s hand slips, sawing through the bone in [target]'s [affected.name] with \the [tool]!</span>", \
	"<span class='warning'>Your hand slips, sawwing through the bone in [target]'s [affected.name] with \the [tool]!</span>")
	affected.createwound(CUT, 30)
	affected.fracture()

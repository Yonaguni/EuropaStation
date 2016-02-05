/datum/surgery_step/disinfect
	priority = 2
	can_infect = 0
	allowed_tools = list(/obj/item/ = 100) // Contents check handled in can_use()
	min_duration = 80
	max_duration = 120

/datum/surgery_step/disinfect/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)

	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(!affected)
		return 0

	// Check if they're using something that can disinfect wounds.
	var/disinfect_amt = 5
	if(tool.reagents)
		for(var/datum/reagent/R in tool.reagents.reagent_list)
			if(R.disinfectant)
				disinfect_amt -= R.volume
				if(disinfect_amt <= 0)
					break
	return (disinfect_amt <= 0)

/datum/surgery_step/disinfect/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
		if(..())
			var/obj/item/organ/external/affected = target.get_organ(target_zone)
			return affected && affected.open == 0 && target_zone != O_MOUTH

/datum/surgery_step/disinfect/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("\The [user] begins disinfecting \the [target]'s [affected.name] with \the [tool].")

	affacted.germ_level = 0
	if(affected.open)
		tool.reagents.trans_to(target, rand(3,5), CHEM_BLOOD)
		target.custom_pain("You feel a searing pain in your [affected.name]!",1)
	else
		tool.reagents.splash(target, rand(3,5))
	..()

/datum/surgery_step/disinfect/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='notice'>\The [user] has disinfected \the [target]'s [affected.name] with \the [tool].</span>")
	affacted.germ_level = 0


/datum/surgery_step/disinfect/fail_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='danger'>\The [user]'s hand slips, spilling \the [tool] over \the [target]'s [affected.name]!</span>")
	if(affected.open)
		tool.reagents.splash(target, ceil(tool.reagents.total_volume/3))
		tool.reagents.trans_to(target, ceil(tool.reagents.total_volume/2), CHEM_BLOOD)
		target.custom_pain("You feel a searing pain in your [affected.name]!",1)
	else
		tool.reagents.splash(target, ceil(tool.reagents.total_volume/2))
	affected.germ_level = 0

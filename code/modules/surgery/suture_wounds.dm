/datum/surgery_step/suture_wounds
	allowed_tools = list(
	/obj/item/weapon/suture = 100
	)

	min_duration = 70
	max_duration = 100

/datum/surgery_step/suture_wounds/can_use(mob/living/user, mob/living/human/target, target_zone, obj/item/tool)
	if(!istype(target))
		return 0
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(!affected || affected.is_stump() || (affected.status & ORGAN_ROBOT))
		return 0
	for(var/datum/wound/W in affected.wounds)
		if(!W.internal && W.open && W.damage >= W.autoheal_cutoff)
			return 1
	return 0

/datum/surgery_step/suture_wounds/begin_step(mob/user, mob/living/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("[user] is beginning to close a wound on [target]'s [affected.name] with \the [tool]." , \
		"You are beginning to close a wound on [target]'s [affected.name] with \the [tool].")
	target.custom_pain("Your [affected.name] is being stabbed!",1)
	..()

/datum/surgery_step/suture_wounds/end_step(mob/living/user, mob/living/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	var/found_wound
	for(var/datum/wound/W in affected.wounds)
		if(!W.internal && W.open && W.damage >= W.autoheal_cutoff)
			// Close it up to a point that it can be bandaged and heal naturally!
			W.heal_damage(rand(10,20)+10)
			if(W.damage <= 10)
				W.clamped = 1
			found_wound = 1
			if(W.damage >= W.autoheal_cutoff)
				user.visible_message("<span class='notice'>\The [user] partially closes a wound on [target]'s [affected.name] with \the [tool].</span>", \
				"<span class='notice'>You partially close a wound on [target]'s [affected.name] with \the [tool].</span>")
			else
				user.visible_message("<span class='notice'>\The [user] closes a wound on [target]'s [affected.name] with \the [tool].</span>", \
				"<span class='notice'>You close a wound on [target]'s [affected.name] with \the [tool].</span>")
			break
	if(!found_wound)
		user << "<span class='notice'>You couldn't find any wounds big enough to treat on \the [target]'s [affected.name].</span>"
	affected.update_damages()

/datum/surgery_step/suture_wounds/fail_step(mob/living/user, mob/living/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("\red [user]'s hand slips, tearing [target]'s [affected.name] with \the [tool]!", \
		"\red Your hand slips, tearing [target]'s [affected.name] with \the [tool]!")
	target.apply_damage(3, BRUTE, affected)

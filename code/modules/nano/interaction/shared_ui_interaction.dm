/mob/proc/shared_ui_interaction(src_object)
	if(!client) // Close UIs if mindless.
		return UI_CLOSE
	else if(stat) // Disable UIs if unconcious.
		return UI_DISABLED
	else if(incapacitated() || lying) // Update UIs if incapicitated but concious.
		return UI_UPDATE
	return UI_INTERACTIVE

/mob/living/silicon/ai/shared_ui_interaction(src_object)
	if(!has_power()) // Disable UIs if the AI is unpowered.
		return UI_DISABLED
	return ..()

/mob/living/silicon/robot/shared_ui_interaction(src_object)
	if(cell.charge <= 0 || lockcharge) // Disable UIs if the Borg is unpowered or locked.
		return UI_DISABLED
	return ..()

/mob/proc/hands_can_use_topic(src_object)
	return UI_CLOSE

/mob/living/hands_can_use_topic(src_object)
	if(src_object in get_both_hands(src))
		return UI_INTERACTIVE
	return UI_CLOSE

/mob/living/silicon/robot/hands_can_use_topic(src_object)
	for(var/obj/item/weapon/gripper/active_gripper in list(module_state_1, module_state_2, module_state_3))
		if(active_gripper.contains(src_object))
			return UI_INTERACTIVE
	return UI_CLOSE
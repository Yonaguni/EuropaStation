/datum/proc/tgui_host()
	return src

/datum/proc/tgui_container()
	return src

/datum/proc/CanUseTopic(var/mob/user, var/datum/ui_state/state)
	var/datum/src_object = tgui_host()
	return state.can_use_topic(src_object, user)

/datum/ui_state/proc/href_list(var/mob/user)
	return list()

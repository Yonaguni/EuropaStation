var/datum/antagonist/presence/presences

/datum/antagonist/presence
	id = MODE_PRESENCE
	role_text = "Presence"
	role_text_plural = "Presences"
	flags = ANTAG_OVERRIDE_MOB | ANTAG_OVERRIDE_JOB | ANTAG_VOTABLE
	welcome_text = "You are something beyond human experience; a strange presence, partially \
		manifested from the deep dark of the most remote continua.<br> Use the <b>Select \
		Presence Type</b> to choose an archetype, <b>List Believers</b> to review your flock, \
		and <b>List Powers</b> to view and purchase powers."
	mob_path = /mob/living/presence
	hard_cap = 3
	hard_cap_round = 3
	initial_spawn_req = 1
	initial_spawn_target = 3
	var/presence_index = 1

/datum/antagonist/presence/New(var/no_reference)
	populate_presence_templates()
	..()
	if(!no_reference)
		presences = src

/datum/antagonist/presence/proc/get_presence_from_believer(var/mob/believer)
	for(var/thing in current_antagonists)
		var/datum/mind/mind = thing
		var/mob/living/presence/godhead = mind.current
		if(istype(godhead) && godhead.believers[believer])
			return godhead

/datum/antagonist/presence/proc/get_next_presence_for_unaligned_godtouched()
	if(!LAZYLEN(current_antagonists))
		return FALSE
	if(presence_index > LAZYLEN(current_antagonists)) presence_index = 1
	var/datum/mind/M = current_antagonists[presence_index]
	presence_index++
	return M.current

/*
/datum/antagonist/presence/clear_indicators(var/datum/mind/recipient)
	if(!recipient.current || !recipient.current.client)
		return
	for(var/image/I in recipient.current.client.images)
		if(I.icon_state == antag_indicator || (faction_indicator && I.icon_state == faction_indicator))
			qdel(I)

/datum/antagonist/presence/get_indicator(var/datum/mind/recipient, var/datum/mind/other)
	if(!other.current || !recipient.current) return
	var/indicator = (faction_indicator && (other in faction_members)) ? faction_indicator : antag_indicator
	return image('icons/mob/mob.dmi', loc = other.current, icon_state = indicator, layer = LIGHTING_LAYER+0.1)

/datum/antagonist/presence/update_all_icons()
	for(var/datum/mind/antag in current_antagonists)
		clear_indicators(antag)
		if(faction_invisible && (antag in faction_members))
			continue
		for(var/datum/mind/other_antag in current_antagonists)
			if(antag.current && antag.current.client)
				antag.current.client.images |= get_indicator(antag, other_antag)
*/
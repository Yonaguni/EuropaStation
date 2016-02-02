// This system is used to grab a ghost from observers with the required preferences and
// lack of bans set. See posibrain.dm for an example of how they are called/used. ~Z
var/list/ghost_traps

proc/get_ghost_trap(var/trap_key)
	if(!ghost_traps)
		populate_ghost_traps()
	return ghost_traps[trap_key]

proc/populate_ghost_traps()
	ghost_traps = list()
	for(var/traptype in typesof(/datum/ghosttrap))
		var/datum/ghosttrap/G = new traptype
		ghost_traps[G.object] = G

/datum/ghosttrap
	var/object = "computer brain"
	var/minutes_since_death = 0     // If non-zero the ghost must have been dead for this many minutes to be allowed to spawn
	var/list/ban_checks = list("AI","Cyborg")
	var/pref_check = BE_AI
	var/ghost_trap_message = "They are occupying a cybernetic brain now."
	var/ghost_trap_role = "Cybernetic Brain"

// Check for bans, proper atom types, etc.
/datum/ghosttrap/proc/assess_candidate(var/mob/dead/observer/candidate)
	if(!istype(candidate) || !candidate.client || !candidate.ckey)
		return 0
	if(!candidate.MayRespawn(1, minutes_since_death))
		return 0
	if(islist(ban_checks))
		for(var/bantype in ban_checks)
			if(jobban_isbanned(candidate, "[bantype]"))
				candidate << "You are banned from one or more required roles and hence cannot enter play as \a [object]."
				return 0
	return 1

// Print a message to all ghosts with the right prefs/lack of bans.
/datum/ghosttrap/proc/request_player(var/mob/target, var/request_string)
	if(!target)
		return
	for(var/mob/dead/observer/O in player_list)
		if(!O.MayRespawn())
			continue
		if(islist(ban_checks))
			for(var/bantype in ban_checks)
				if(jobban_isbanned(O, "[bantype]"))
					continue
		if(pref_check && !(O.client.prefs.be_special & pref_check))
			continue
		if(O.client)
			O << "[request_string]<a href='?src=\ref[src];candidate=\ref[O];target=\ref[target]'>Click here</a> if you wish to play as this option."

// Handles a response to request_player().
/datum/ghosttrap/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["candidate"] && href_list["target"])
		var/mob/dead/observer/candidate = locate(href_list["candidate"]) // BYOND magic.
		var/mob/target = locate(href_list["target"])                     // So much BYOND magic.
		if(!target || !candidate)
			return
		if(candidate == usr && assess_candidate(candidate) && !target.ckey)
			transfer_personality(candidate,target)
		return 1

// Shunts the ckey/mind into the target mob.
/datum/ghosttrap/proc/transfer_personality(var/mob/candidate, var/mob/target)
	if(!assess_candidate(candidate))
		return 0
	target.ckey = candidate.ckey
	if(target.mind)
		target.mind.assigned_role = "[ghost_trap_role]"
	announce_ghost_joinleave(candidate, 0, "[ghost_trap_message]")
	welcome_candidate(target)
	set_new_name(target)
	return 1

// Fluff!
/datum/ghosttrap/proc/welcome_candidate(var/mob/target)
	var/obj/item/device/mmi/digital/P = target.loc
	if(!istype(P)) return
	target << "<b>You are a downloaded intelligence, loaded into a processing substrate on [station_name()].</b>"
	P.visible_message("<span class='notice'>\The [P] chimes quietly.</span>")

// Allows people to set their own name. May or may not need to be removed for posibrains if people are dumbasses.
/datum/ghosttrap/proc/set_new_name(var/mob/target)
	var/newname = sanitizeSafe(input(target,"Enter a name, or leave blank for the default name.", "Name change","") as text, MAX_NAME_LEN)
	if (newname != "")
		target.real_name = newname
		target.name = target.real_name

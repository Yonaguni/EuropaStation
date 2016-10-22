//STRIKE TEAMS
//Thanks to Kilakk for the admin-button portion of this code.

var/send_emergency_team // Used for automagic response teams
                                   // 'admin_emergency_team' for admin-spawned response teams
var/ert_base_chance = 10 // Default base chance. Will be incremented by increment ERT chance.
var/can_call_ert

/client/proc/response_team()
	set name = "Activate Distress Beacon"
	set category = "Special Verbs"
	set desc = "Send an emergency response to the ship"

	if(!holder)
		usr << "<span class='danger'>Only administrators may use this command.</span>"
		return
	if(!ticker)
		usr << "<span class='danger'>The game hasn't started yet!</span>"
		return
	if(ticker.current_state == 1)
		usr << "<span class='danger'>The round hasn't started yet!</span>"
		return
	if(send_emergency_team)
		usr << "<span class='danger'>[boss_name] has already activated the distress beacon!</span>"
		return
	if(alert("Do you want to activate the distress beacon?",,"Yes","No") != "Yes")
		return
	if(get_security_level() != "red") // Allow admins to reconsider if the alert level isn't Red
		switch(alert("The ship is not in red alert. Do you still want to activate the beacon?",,"Yes","No"))
			if("No")
				return
	var/ert_type = ERT_CORPORATE
	if(alert("Do you want to send a specific team type?",,"Yes","No") == "Yes")
		var/teamtype = input("Select a team type.","ERT type") as null|anything in all_ert_types
		if(!teamtype || !all_ert_types[teamtype])
			return
		ert_type = all_ert_types[teamtype]
	if(send_emergency_team)
		usr << "<span class='danger'>Looks like somebody beat you to it!</span>"
		return

	message_admins("[key_name_admin(usr)] activated the distress beacon.", 1)
	log_admin("[key_name(usr)] activated the distress beacon.")
	trigger_armed_response_team(1, ert_type)

client/verb/JoinResponseTeam()

	set name = "Join Emergency Responders"
	set category = "IC"

	if(!MayRespawn(1))
		usr << "<span class='warning'>You cannot join the emergency responders at this time.</span>"
		return

	if(isghost(usr) || isnewplayer(usr))
		if(!send_emergency_team)
			usr << "The distress beacon has not been activated."
			return

		var/datum/antagonist/sending
		switch(send_emergency_team)
			if(ERT_PIRATE)
				sending = raiders
			if(ERT_MERCENARY)
				sending = mercs
			if(ERT_NAVY)
				sending = commandos
			else
				sending = ert

		if(jobban_isbanned(usr, sending.id) || jobban_isbanned(usr, "Security Officer"))
			usr << "<span class='danger'>You are jobbanned from this role!</span>"
			return
		if(sending.current_antagonists.len >= sending.hard_cap)
			usr << "The emergency responders are already full!"
			return

		sending.create_default(usr)

	else
		usr << "You need to be an observer or new player to use this."

// returns a number of dead players in %
proc/percentage_dead()
	var/total = 0
	var/deadcount = 0
	for(var/mob/living/carbon/human/H in mob_list)
		if(H.client) // Monkeys and mice don't have a client, amirite?
			if(H.stat == 2) deadcount++
			total++

	if(total == 0) return 0
	else return round(100 * deadcount / total)

// counts the number of antagonists in %
proc/percentage_antagonists()
	var/total = 0
	var/antagonists = 0
	for(var/mob/living/carbon/human/H in mob_list)
		if(is_special_character(H) >= 1)
			antagonists++
		total++

	if(total == 0) return 0
	else return round(100 * antagonists / total)

// Increments the ERT chance automatically, so that the later it is in the round,
// the more likely an ERT is to be able to be called.
proc/increment_ert_chance()
	while(!send_emergency_team) // There is no ERT at the time.
		if(get_security_level() == "green")
			ert_base_chance += 1
		if(get_security_level() == "blue")
			ert_base_chance += 2
		if(get_security_level() == "red")
			ert_base_chance += 3
		if(get_security_level() == "delta")
			ert_base_chance += 10           // Need those big guns
		sleep(600 * 3) // Minute * Number of Minutes


proc/trigger_armed_response_team(var/force = 0, var/force_type)
	if(!can_call_ert && !force)
		return
	if(send_emergency_team)
		return

	var/send_team_chance = ert_base_chance // Is incremented by increment_ert_chance.
	if(force)
		send_team_chance = 100
	else
		send_team_chance += 2*percentage_dead() // the more people are dead, the higher the chance
		send_team_chance += percentage_antagonists() // the more antagonists, the higher the chance
		send_team_chance = min(send_team_chance, 100)

	// there's only a certain chance a team will be sent
	if(!prob(send_team_chance))
		command_announcement.Announce("The distress beacon aboard [station_name()] has been activated. Unfortunately, no response has been received.", "[boss_name]")
		can_call_ert = 0 // Only one call per round, ladies.
		return

	command_announcement.Announce("The distress beacon aboard [station_name()] has been activated and an acknowledgement has been received. No further details available.", "[boss_name]")
	evacuation_controller.add_can_call_predicate(new/datum/evacuation_predicate/ert())

	can_call_ert = 0 // Only one call per round, gentleman.
	send_emergency_team = force_type ? force_type : pick(using_map.stellar_location.beacon_responders)

	sleep(600 * 5)
	send_emergency_team = null // Can no longer join the ERT.

/datum/evacuation_predicate/ert
	var/prevent_until

/datum/evacuation_predicate/ert/New()
	..()
	prevent_until = world.time + 30 MINUTES

/datum/evacuation_predicate/ert/is_valid()
	return world.time < prevent_until

/datum/evacuation_predicate/ert/can_call(var/user)
	if(world.time >= prevent_until)
		return TRUE
	user << "<span class='warning'>The distress beacon is active. Emergency wave jump requests will be denied until [duration2stationtime(prevent_until - world.time)].</span>"
	return FALSE

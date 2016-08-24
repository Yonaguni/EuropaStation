//Blocks an attempt to connect before even creating our client datum thing.
world/IsBanned(key, address, computer_id)

	if(isnull(computer_id))
		message_admins("[key] has logged in with a blank computer id in the ban check.")
	if(isnull(address))
		message_admins("[key] has logged in with a blank ip in the ban check.")

	//Guest Checking
	if(!config.guests_allowed && IsGuestKey(key))
		log_access("Failed Login: [key] - Guests not allowed")
		message_admins("\blue Failed Login: [key] - Guests not allowed")
		return list("reason"="guest", "desc"="\nReason: Guests not allowed. Please sign in with a byond account.")

	//check if the IP address is a known TOR node
	if(config && config.ToRban && ToRban_isbanned(address))
		log_access("Failed Login: [src] - Banned: ToR")
		message_admins("\blue Failed Login: [src] - Banned: ToR")
		//ban their computer_id and ckey for posterity
		add_ban(_ckey=ckey(key), _cid=computer_id, _reason="Use of ToR", _banningkey="Automated Ban")
		return list("reason"="Using ToR", "desc"="\nReason: The network you are using to connect has been banned.\nIf you believe this is a mistake, please request help at [config.banappeals]")

	var/ckeytext = ckey(key)
	for(var/thing in serverbans)
		var/datum/ban/B = thing
		if(B.data["ckey"] == ckeytext || B.data["cid"] == computer_id || B.data["ip"] == address)
			var/desc = "\nReason: You, or another user of this computer or connection ([B.data["ckey"]]) is banned from playing here. The ban reason is:\n[B.data["reason"]]\nThis ban was applied by [B.data["banning_key"]] on [B.get_banned_datetime()], [B.get_expiry_datetime()]"
			return list("reason"="[B.data["bantype"]]", "desc"="[desc]")

	return ..() //default pager ban stuff

/proc/jobban_isbanned(var/mob/M, var/rank)
	if(!M || !rank)
		return 0

	rank = lowertext(rank)

	if(guest_jobbans(rank))
		if(config.guest_jobban && IsGuestKey(M.key))
			return "Guest Job-ban"
		if(config.usewhitelist && !check_whitelist(M))
			return "Whitelisted Job"
	for(var/thing in jobbans)
		var/datum/ban/JB = thing
		if(M.ckey == JB.data["ckey"] && rank == JB.data["job"])
			return JB.data["reason"]
	return 0

/proc/guest_jobbans(var/job)
	job = lowertext(job)
	return ((job in head_positions) || (job in nonhuman_positions) || (job in gov_positions))

/proc/server_isbanned(var/mob/M)
	if(!M)
		return 0
	for(var/thing in serverbans)
		var/datum/ban/B = thing
		if(M.ckey == B.data["ckey"] )
			return B.data["reason"]
	return 0

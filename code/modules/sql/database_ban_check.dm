//Blocks an attempt to connect before even creating our client datum thing.
world/IsBanned(key, address, computer_id)

	if(ckey(key) in admin_datums)
		return ..()

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
		add_server_ban(_ckey=ckey(key), _cid=computer_id, _reason="Use of ToR", _banningkey="Automated Ban")
		return list("reason"="Using ToR", "desc"="\nReason: The network you are using to connect has been banned.\nIf you believe this is a mistake, please request help at [config.banappeals]")

	if(!config.sql_enabled)
		return ..()

	var/ckeytext = ckey(key)
	establish_database_connection()
	if(!global_db)
		error("Ban database connection failure. Key [ckeytext] not checked")
		log_misc("Ban database connection failure. Key [ckeytext] not checked")
		return

	for(var/thing in serverbans)
		var/datum/ban/B = thing
		if(B.data["ckey"] == ckeytext || B.data["cid"] == computer_id || B.data["ip"] == address)
			var/expires = "TODO."
			var/desc = "\nReason: You, or another user of this computer or connection ([B.data["ckey"]]) is banned from playing here. The ban reason is:\n[B.data["reason"]]\nThis ban was applied by [B.data["banning_key"]] on [B.data["banning_time"]], [expires]"
			return list("reason"="[B.data["bantype"]]", "desc"="[desc]")

	return ..() //default pager ban stuff

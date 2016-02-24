//Blocks an attempt to connect before even creating our client datum thing.
world/IsBanned(key,address,computer_id)
	if(ckey(key) in admin_datums)
		return ..()

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
		AddBan(ckey(key), computer_id, "Use of ToR", "Automated Ban", 0, 0)
		return list("reason"="Using ToR", "desc"="\nReason: The network you are using to connect has been banned.\nIf you believe this is a mistake, please request help at [config.banappeals]")

	if(!config.sql_enabled)
		return ..()

	var/ckeytext = ckey(key)
	establish_database_connection()
	if(!global_db)
		error("Ban database connection failure. Key [ckeytext] not checked")
		log_misc("Ban database connection failure. Key [ckeytext] not checked")
		return

	var/failedcid = 1
	var/failedip = 1

	var/ipquery = ""
	var/cidquery = ""
	if(address)
		failedip = 0
		ipquery = " OR ip = '[address]' "

	if(computer_id)
		failedcid = 0
		cidquery = " OR computerid = '[computer_id]' "

	var/database/query/query = new("SELECT ckey, a_ckey, reason, expiration_time, duration, bantime, bantype FROM ban WHERE (ckey = '[ckeytext]' [ipquery] [cidquery]) AND (bantype = 'PERMABAN'  OR (bantype = 'TEMPBAN' AND expiration_time > date('now'))) AND isnull(unbanned)")

	query.Execute(global_db)

	while(query.NextRow())
		var/list/querydata = query.GetRowData()
		var/pckey =      querydata["ckey"]
		var/ackey =      querydata["a_ckey"]
		var/reason =     querydata["reason"]
		var/expiration = querydata["expiration_time"]
		var/duration =   querydata["duration"]
		var/bantime =    querydata["bantime"]
		var/bantype =    querydata["bantype"]

		var/expires = ""
		if(text2num(duration) > 0)
			expires = " The ban is for [duration] minutes and expires on [expiration] (server time)."
		var/desc = "\nReason: You, or another user of this computer or connection ([pckey]) is banned from playing here. The ban reason is:\n[reason]\nThis ban was applied by [ackey] on [bantime], [expires]"
		return list("reason"="[bantype]", "desc"="[desc]")

	if (failedcid)
		message_admins("[key] has logged in with a blank computer id in the ban check.")
	if (failedip)
		message_admins("[key] has logged in with a blank ip in the ban check.")
	return ..()	//default pager ban stuff

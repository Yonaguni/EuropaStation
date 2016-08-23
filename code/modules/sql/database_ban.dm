/datum/ban
	var/list/data

/datum/ban/New(var/list/_data)
	data = _data

var/list/jobbans = list()
var/list/serverbans = list()

/hook/startup/proc/load_bans()
	if(!config.sql_enabled)
		return 1

	if(!establish_database_connection())
		error("Database connection failed. Unable to load bans.")
		log_misc("Database connection failed. Unable to load bans.")
		config.sql_enabled = 0
		return

	//Jobbans
	var/database/query/query = new("SELECT * FROM ban WHERE bantype = '[BAN_JOBBAN]' AND isnull(unbanned_datetime) AND expiration_time <= Now()")
	query.Execute(global_db)
	while(query.NextRow())
		var/list/querydata = query.GetRowData()
		jobbans += new /datum/ban(querydata)

	// Serverbans.
	query = null
	query = new("SELECT * FROM ban WHERE bantype = '[BAN_SERVERBAN]' AND isnull(unbanned_datetime) AND expiration_time <= Now()")
	query.Execute(global_db)
	while(query.NextRow())
		var/list/querydata = query.GetRowData()
		jobbans += new /datum/ban(querydata)

	return 1

/proc/jobban_isbanned(var/mob/M, var/rank)
	if(!M || !rank)
		return 0

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

/proc/server_isbanned(var/mob/M)
	if(!M)
		return 0
	for(var/thing in serverbans)
		var/datum/ban/B = thing
		if(M.ckey == B.data["ckey"] )
			return B.data["reason"]
	return 0

/proc/add_server_ban(var/_ckey, var/_cid, var/_reason = "Undefined", var/_banningkey = "Undefined", var/_expires)
	var/list/data = list()
	data["bantype"] = BAN_SERVERBAN
	data["reason"] = _reason
	data["expiration_time"] = _expires
	data["ckey"] = _ckey
	data["computerid"] = _cid
	data["banning_ckey"] = _banningkey
	data["banning_time"] = world.time
	serverbans += new /datum/ban(data)

/proc/save_job_bans()
	return

/proc/save_server_bans()
	return

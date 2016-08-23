var/list/jobbans = list()
var/list/serverbans = list()

/hook/startup/proc/rs_load_bans()
	load_bans()
	return 1

/proc/load_bans()
	if(!establish_database_connection())
		error("Database connection failed. Unable to load bans.")
		log_misc("Database connection failed. Unable to load bans.")
		return
	var/database/query/query = new("SELECT * FROM ban")
	query.Execute(global_db)
	while(query.NextRow())
		var/list/querydata = query.GetRowData()
		var/datum/ban/B = new /datum/ban(querydata)
		if(B.data["bantype"] == BAN_SERVERBAN)
			world.log << "Loaded serverban for [B.data["ckey"]]"
			serverbans += B
		else
			world.log << "Loaded jobban for [B.data["ckey"]], [B.data["job"]]"
			jobbans += B
	return 1

/proc/save_bans()
	// Update existing records and insert new ones where needed.
	for(var/datum/ban/B in (serverbans+jobbans))
		var/database/query/dbquery
		if(!isnull(B.data["id"]))
			dbquery = new("UPDATE bans SET bantype = '[B.data["bantype"]]', reason = '[B.data["reason"]]', job = '[B.data["job"]]', expiration_time = '[B.data["expiration_time"]]', ckey = '[B.data["ckey"]]', computerid = '[B.data["computerid"]]', ip = '[B.data["ip"]]', banning_ckey = '[B.data["banning_ckey"]]', banning_time = '[B.data["banning_time"]]', unbanned_ckey = '[B.data["unbanned_ckey"]]', unbanned_datetime = '[B.data["unbanned_datetime"]]' WHERE id == [B.data["id"]];")
		else
			dbquery = new("INSERT INTO bans (bantype, reason, job, expiration_time, ckey, computerid, ip, banning_ckey, banning_time, unbanned_ckey, unbanned_datetime) VALUES ('[B.data["bantype"]]', '[B.data["reason"]]', '[B.data["job"]]', '[B.data["expiration_time"]]', '[B.data["ckey"]]', '[B.data["computerid"]]', '[B.data["ip"]]', '[B.data["banning_ckey"]]', '[B.data["banning_time"]]', '[B.data["unbanned_ckey"]]', '[B.data["unbanned_datetime"]]');")
		dbquery.Execute(global_db)
		qdel(B)

	// Reload the list so saved bans get their ID var updated. Not sure how else to do this.
	serverbans.Cut()
	jobbans.Cut()
	load_bans()

/proc/add_server_ban(var/_ckey, var/_cid, var/_reason = "Undefined", var/_banningkey = "Undefined", var/_expires, var/defer_ban_save)

	var/list/data = list()
	data["bantype"] = BAN_SERVERBAN
	data["reason"] = _reason
	data["expiration_time"] = _expires
	data["ckey"] = _ckey
	data["computerid"] = _cid
	data["banning_ckey"] = _banningkey
	data["banning_time"] = world.time
	serverbans += new /datum/ban(data)
	if(!defer_ban_save) save_bans()

	message_admins("<span class='danger'>[data["banning_ckey"]] has banned [data["ckey"]] from the server for reason: [data["reason"]]</span>")

	for(var/client/C in clients)
		if(C.ckey == data["ckey"])
			C << "<span class='danger'>You have been banned by [data["banning_ckey"]] for the following reason: [data["reason"]]</span>"
			del(C)
			break

/proc/add_job_ban(var/_ckey, var/_cid, var/_reason = "Undefined", var/_banningkey = "Undefined", var/_role = "Undefined", var/_expires, var/defer_ban_save)
	var/list/data = list()
	data["bantype"] = BAN_JOBBAN
	data["reason"] = _reason
	data["job"] = _role
	data["expiration_time"] = _expires
	data["ckey"] = _ckey
	data["computerid"] = _cid
	data["banning_ckey"] = _banningkey
	data["banning_time"] = world.time
	jobbans += new /datum/ban(data)
	if(!defer_ban_save) save_bans()

	message_admins("<span class='danger'>[data["banning_ckey"]] has banned [data["ckey"]] from job ([data["job"]]) for reason: [data["reason"]]</span>")

	for(var/client/C in clients)
		if(C.ckey == data["ckey"])
			C << "<span class='danger'>You have been banned from job ([data["job"]]) by [data["banning_ckey"]] for the following reason: [data["reason"]]</span>"
			break

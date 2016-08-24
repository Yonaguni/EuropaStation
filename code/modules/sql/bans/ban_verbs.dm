/datum/admins/proc/apply_server_ban()
	set category = "Bans"
	set desc = "Apply a server ban to a given ckey."
	set name = "Apply Server Ban"

	if(!check_rights(R_BAN)) return

	var/ban_ckey = ckey(input("Enter ckey to ban.","Server Ban") as text|null)
	if(!ban_ckey)
		return
	var/ban_reason = input("Enter a ban reason.","Server Ban") as text|null
	if(!ban_reason)
		return

	add_ban(_ckey = ban_ckey, _reason = ban_reason, _banningkey = usr.ckey)

/datum/admins/proc/apply_job_ban()

	set category = "Bans"
	set desc = "Apply a job ban to a given ckey."
	set name = "Apply Job Ban"

	if(!check_rights(R_BAN)) return

	var/ban_ckey = ckey(input("Enter ckey to ban.","Server Ban") as text|null)
	if(!ban_ckey)
		return
	var/ban_job = input("Enter a role to ban.","Job Ban") as text|null
	if(!ban_job)
		return
	var/ban_reason = input("Enter a ban reason.","Server Ban") as text|null
	if(!ban_reason)
		return

	add_ban(_ckey = ban_ckey, _job = ban_job, _reason = ban_reason, _banningkey = usr.ckey)


/datum/admins/proc/list_bans()

	set category = "Bans"
	set desc = "List all bans for a ckey."
	set name = "List Bans"

	if(!check_rights(R_BAN)) return

	var/check_ckey = ckey(input("Enter ckey.","Server Ban") as text|null)
	if(!check_ckey)
		return

	var/found
	usr << "<b>Checking server bans for [check_ckey].</b>"
	for(var/datum/ban/ban in allbans)
		if(ban.data["ckey"] == check_ckey)
			found = 1
			usr << ban.get_summary()
	if(!found)
		usr << "<b>No bans found.</b>"

/datum/admins/proc/unban()

	set category = "Bans"
	set desc = "Remove a ban from a ckey."
	set name = "Lift Ban"

	if(!check_rights(R_BAN)) return

	var/check_ckey = ckey(input("Enter ckey.","Unban") as text|null)
	if(!check_ckey)
		return

	var/list/bans = list()
	var/database/query/query = new("SELECT bantype, job, reason, banning_ckey, banning_datetime, id FROM ban WHERE ckey == ? AND unbanned_ckey IS NULL;", check_ckey)
	query.Execute(global_db)
	if(query.ErrorMsg())
		world.log << "SQL ERROR: unban (1): [query.ErrorMsg()]."

	while(query.NextRow())
		var/list/row = query.GetRowData()
		bans["[row["job"] ? "JOB - [row["job"]]" : "SERVER"] - [row["banning_ckey"]] - [row["banning_datetime"]]"] = row["id"]

	if(!bans.len)
		usr << "No bans exist for that ckey."
		return

	var/choice = input("Select a ban to lift.","Unban") as null|anything in bans
	if(!choice)
		return

	choice = bans[choice]
	query = new("UPDATE ban SET unbanned_ckey = ?, unbanned_datetime = datetime('now') WHERE id == ?;", check_ckey, choice)
	query.Execute(global_db)
	if(query.ErrorMsg())
		world.log << "SQL ERROR: unban (2): [query.ErrorMsg()]."
	load_bans()
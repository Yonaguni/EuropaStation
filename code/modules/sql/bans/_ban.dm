var/list/jobbans = list()
var/list/serverbans = list()
var/list/allbans = list()

/hook/startup/proc/rs_load_bans()
	world.log << "<b>Loading ban database.</b>"
	load_bans()
	return 1

/proc/load_bans()
	serverbans.Cut()
	jobbans.Cut()
	for(var/thing in allbans)
		qdel(thing)
	allbans.Cut()
	var/database/query/query = new("SELECT * FROM ban")
	query.Execute(global_db)
	while(query.NextRow())
		new /datum/ban(query.GetRowData())
	return 1

/proc/add_ban(var/_ckey = "Undefined", var/_cid, var/_job, var/_reason = "Undefined", var/_banningkey = "Undefined", var/_expires)

	if(!_cid || _cid == "")
		_cid = "NULL"
		for(var/client/C in clients)
			if(C.ckey == _ckey)
				_cid = C.computer_id
				break

	if(_job)
		_job = lowertext(_job)

	var/query_names =  "bantype, job, reason, ckey, banning_ckey, banning_datetime, computerid, expiration_datetime"
	var/query_values = "[_job ? "'[BAN_JOBBAN]', '[_job]'" : "'[BAN_SERVERBAN]', NULL"], '[_reason]', '[_ckey]', '[_banningkey]', datetime('now'), [_cid], [_expires ? "datetime(julianday() + [_expires])" : "NULL"]"
	var/database/query/dbquery = new("INSERT INTO ban ([query_names]) VALUES ([query_values]);")
	dbquery.Execute(global_db)
	if(dbquery.ErrorMsg())
		world.log << "SQL ERROR: ban: [dbquery.ErrorMsg()]."

	message_admins("<span class='danger'>[_banningkey] has banned [_ckey] from [_job ? "from job ([_job])" : "the server"] for reason: [_reason]</span>")
	for(var/client/C in clients)
		if(C.ckey == _ckey)
			C << "<span class='danger'>You have been banned from [_job ? "from job ([_job])" : "the server"] by [_banningkey] for the following reason: [_reason]</span>"
			if(!_job)
				del(C)
			break

	load_bans()

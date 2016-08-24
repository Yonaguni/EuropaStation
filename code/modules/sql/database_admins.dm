var/list/admin_ranks = list()								//list of all ranks with associated rights

//load our rank - > rights associations
/proc/load_admin_ranks()
	admin_ranks.Cut()

	var/previous_rights = 0

	//load text from file
	var/list/Lines = file2list("config/admin_ranks.txt")

	//process each line seperately
	for(var/line in Lines)
		if(!length(line))				continue
		if(copytext(line,1,2) == "#")	continue

		var/list/List = splittext(line,"+")
		if(!List.len)					continue

		var/rank = ckeyEx(List[1])
		switch(rank)
			if(null,"")		continue
			if("Removed")	continue				//Reserved

		var/rights = 0
		for(var/i=2, i<=List.len, i++)
			switch(ckey(List[i]))
				if("@","prev")					rights |= previous_rights
				if("admin")						rights |= R_ADMIN
				if("ban")						rights |= R_BAN
				if("server")					rights |= R_SERVER
				if("debug")						rights |= R_DEBUG
				if("sound","sounds")			rights |= R_SOUNDS
				if("spawn","create")			rights |= R_SPAWN
				if("everything","all")			rights |= (R_ADMIN | R_BAN | R_SERVER | R_DEBUG | R_SOUNDS | R_SPAWN)

		admin_ranks[rank] = rights
		previous_rights = rights

/hook/startup/proc/loadAdmins()
	load_admins()
	return 1

/proc/load_admins()
	//clear the datums references
	admin_datums.Cut()
	for(var/client/C in admins)
		C.remove_admin_verbs()
		C.holder = null
	admins.Cut()

	load_admin_ranks()

	world.log << "<b>Loading staff database.</b>"

	var/list/existing_admins = list()
	var/database/query/check_query = new("SELECT * FROM admin;")
	check_query.Execute(global_db)
	while(check_query.NextRow())
		var/list/row = check_query.GetRowData()
		existing_admins |= row["ckey"]

	var/list/Lines = file2list("config/admins.txt")
	if(islist(Lines) && Lines.len)
		for(var/line in Lines)
			if(!length(line) || copytext(line,1,2) == "#")
				continue
			var/list/List = splittext(line, "-")
			if(List.len)
				var/ckey = ckey(List[1])
				if(ckey)
					var/rank = (List.len >= 2) ? ckeyEx(List[2]) : ""
					var/rights = admin_ranks[rank] ? admin_ranks[rank] : 0
					var/database/query/insert_query
					if(ckey in existing_admins)
						insert_query = new("UPDATE admin SET rank = ?, rights = ? WHERE ckey == ?;", rank, rights, ckey)
					else
						insert_query = new("INSERT INTO admin VALUES (?,?,?);", ckey, rank, rights)
					insert_query.Execute(global_db)

	var/database/query/query = new("SELECT * FROM admin")
	query.Execute(global_db)
	while(query.NextRow())
		var/list/querydata = query.GetRowData()
		var/ckey = querydata["ckey"]
		var/rank = querydata["rank"]
		if(rank == "Removed") continue
		var/rights = querydata["rights"]
		if(istext(rights))
			rights = text2num(rights)
		var/datum/admins/D = new /datum/admins(rank, rights, ckey)
		D.associate(directory[ckey])

/client/proc/reload_admins()
	set name = "Reload Admins"
	set category = "Debug"

	if(!check_rights(R_SERVER))	return

	message_admins("[usr] manually reloaded admins")
	load_admins()

// debug verbs only

/client/verb/apply_server_ban()
	var/list/data = list()
	data["ckey"] = input("Enter ckey to ban.","Server Ban") as text
	if(!data["ckey"])   return
	data["reason"] = input("Enter a ban reason.","Server Ban") as text
	if(!data["reason"]) return
	data["bantype"] = BAN_SERVERBAN
	data["banning_ckey"] = usr.ckey
	data["banning_time"] = world.time

	world << "[data["banning_ckey"]] has banned [data["ckey"]] from the server for reason: [data["reason"]]"
	for(var/client/C in clients)
		if(C.ckey == data["ckey"])
			C << "<span class='danger'>You have been banned by [data["banning_ckey"]] for the following reason: [data["reason"]]</span>"
			del(C)
			break
	serverbans += new /datum/ban(data)
	save_server_bans()

/client/verb/apply_job_ban()
	var/list/data = list()
	data["ckey"] = input("Enter ckey to ban.","Job Ban") as text
	if(!data["ckey"])   return
	data["job"] = input("Enter a role to ban.","Job Ban") as text
	if(!data["job"]) return
	data["reason"] = input("Enter a ban reason.","Job Ban") as text
	if(!data["reason"]) return
	data["bantype"] = BAN_JOBBAN
	data["banning_ckey"] = usr.ckey
	data["banning_time"] = world.time

	world << "[data["banning_ckey"]] has banned [data["ckey"]] from the role of [data["job"]] for reason: [data["reason"]]"
	jobbans += new /datum/ban(data)
	save_job_bans()

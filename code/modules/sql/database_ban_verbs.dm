/datum/admins/proc/apply_server_ban()

	set category = "Admin"
	set desc = "Apply a server ban to a given ckey."
	set name = "Apply Server Ban"

	if(!check_rights(R_ADMIN)) return

	var/list/data = list()
	data["ckey"] = ckey(input("Enter ckey to ban.","Server Ban") as text|null)
	if(!data["ckey"])   return
	data["reason"] = input("Enter a ban reason.","Server Ban") as text|null
	if(!data["reason"]) return
	data["bantype"] = BAN_SERVERBAN
	data["banning_ckey"] = usr.ckey
	data["banning_time"] = world.time

	message_admins("<span class='danger'>[data["banning_ckey"]] has banned [data["ckey"]] from the server for reason: [data["reason"]]</span>")
	for(var/client/C in clients)
		if(C.ckey == data["ckey"])
			C << "<span class='danger'>You have been banned by [data["banning_ckey"]] for the following reason: [data["reason"]]</span>"
			del(C)
			break
	serverbans += new /datum/ban(data)
	save_server_bans()

/datum/admins/proc/apply_job_ban()

	set category = "Admin"
	set desc = "Apply a job ban to a given ckey."
	set name = "Apply Job Ban"

	if(!check_rights(R_ADMIN)) return

	var/list/data = list()
	data["ckey"] = ckey(input("Enter ckey to ban.","Job Ban") as text|null)
	if(!data["ckey"])   return
	data["job"] = input("Enter a role to ban.","Job Ban") as text|null
	if(!data["job"]) return
	data["reason"] = input("Enter a ban reason.","Job Ban") as text|null
	if(!data["reason"]) return
	data["bantype"] = BAN_JOBBAN
	data["banning_ckey"] = usr.ckey
	data["banning_time"] = world.time

	message_admins("<span class='danger'>[data["banning_ckey"]] has banned [data["ckey"]] from the role of [data["job"]] for reason: [data["reason"]]</span>")
	jobbans += new /datum/ban(data)
	save_job_bans()

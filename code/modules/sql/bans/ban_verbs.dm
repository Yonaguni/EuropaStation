/datum/admins/proc/apply_server_ban()
	set category = "Bans"
	set desc = "Apply a server ban to a given ckey."
	set name = "Apply Server Ban"

	if(!check_rights(R_ADMIN))
		return

	var/ban_ckey = ckey(input("Enter ckey to ban.","Server Ban") as text|null)
	if(!ban_ckey)
		return
	var/ban_reason = input("Enter a ban reason.","Server Ban") as text|null
	if(!ban_reason)
		return

	add_server_ban(_ckey = ban_ckey, _reason = ban_reason, _banningkey = usr.ckey)

/datum/admins/proc/apply_job_ban()

	set category = "Bans"
	set desc = "Apply a job ban to a given ckey."
	set name = "Apply Job Ban"

	if(!check_rights(R_ADMIN))
		return

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
	save_bans()

/datum/admins/proc/clear_server_bans()

	set category = "Bans"
	set desc = "Clear all server bans on a ckey."
	set name = "Clear Server Bans"

	if(!check_rights(R_ADMIN)) return

	var/check_ckey = ckey(input("Enter ckey.","Server Ban") as text|null)
	if(!check_ckey)
		return

	save_bans()

/datum/admins/proc/clear_job_bans()

	set category = "Bans"
	set desc = "Clear all job bans on a ckey."
	set name = "Clear Job Bans"

	if(!check_rights(R_ADMIN)) return

	var/check_ckey = ckey(input("Enter ckey.","Job Ban") as text|null)
	if(!check_ckey)
		return

	save_bans()

/datum/admins/proc/list_server_bans()

	set category = "Bans"
	set desc = "List all server bans for a ckey."
	set name = "List Server Bans"

	if(!check_rights(R_ADMIN)) return

	var/check_ckey = ckey(input("Enter ckey.","Server Ban") as text|null)
	if(!check_ckey)
		return

	var/found
	usr << "<b>Checking server bans for [check_ckey].</b>"
	for(var/datum/ban/ban in serverbans)
		if(ban.data["ckey"] == check_ckey)
			found = 1
			usr << ban.get_summary()
	if(!found)
		usr << "<b>No bans found.</b>"

/datum/admins/proc/list_job_bans()

	set category = "Bans"
	set desc = "List all job bans for a ckey."
	set name = "List Job Bans"

	if(!check_rights(R_ADMIN)) return

	var/check_ckey = ckey(input("Enter ckey.","Job Ban") as text|null)
	if(!check_ckey)
		return

	var/found
	usr << "<b>Checking job bans for [check_ckey].</b>"
	for(var/datum/ban/ban in jobbans)
		if(ban.data["ckey"] == check_ckey)
			found = 1
			usr << ban.get_summary()
	if(!found)
		usr << "<b>No bans found.</b>"

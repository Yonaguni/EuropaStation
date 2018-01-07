/datum/ban
	var/list/data

/datum/ban/New(var/list/_data)
	data = _data
	if(data["bantype"] == BAN_SERVERBAN)
		serverbans += src
	else
		jobbans += src
	allbans += src

/datum/ban/Destroy()
	data.Cut()
	return ..()

/datum/ban/proc/get_summary()

	var/banstatus = "<b>(bID #[data["id"]])</b> "
	if(get_bantype() == BAN_SERVERBAN)
		banstatus += "Banned from the server"
	else
		banstatus += "Banned from job ([data["job"]])"

	banstatus += " by [data["banning_ckey"]] on [get_banned_datetime()] for reason: '[data["reason"]]'. "

	var/strike = 1
	if(!expired() && !lifted())
		strike = 0
		banstatus += "Active."
	else if(expired())
		banstatus += "Expired on [get_expiry_datetime()]."
	else if(lifted())
		banstatus += "Unbanned by [data["unbanned_ckey"]] on [get_unbanned_datetime()]."

	return strike ? "<strike>[banstatus]</strike>" : banstatus

/datum/ban/proc/expired()
	return 0

/datum/ban/proc/lifted()
	return (!isnull(data["unbanned_ckey"]) && data["unbanned_ckey"] != "")

/datum/ban/proc/get_banned_datetime()
	return data["banning_datetime"]

/datum/ban/proc/get_unbanned_datetime()
	return data["unbanned_datetime"]

/datum/ban/proc/get_expiry_datetime()
	return data["expiration_datetime"]

/datum/ban/proc/get_bantype()
	return data["bantype"]

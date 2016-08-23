/client/proc/admin_call_shuttle()

	set category = "Admin"
	set name = "Call Evac"

	if ((!( ticker ) || !emergency_shuttle.location()))
		return

	if(!check_rights(R_ADMIN))	return

	var/confirm = alert(src, "You sure?", "Confirm", "Yes", "No")
	if(confirm != "Yes") return

	var/choice
	if(ticker.mode.auto_recall_shuttle)
		choice = input("The shuttle will just return if you call it. Call anyway?") in list("Confirm", "Cancel")
		if(choice == "Confirm")
			emergency_shuttle.auto_recall = 1	//enable auto-recall
		else
			return

	log_admin("[key_name(usr)] admin-called the emergency shuttle.")
	message_admins("\blue [key_name_admin(usr)] admin-called the emergency shuttle.", 1)
	emergency_shuttle.call_evac()
	return

/client/proc/admin_cancel_shuttle()
	set category = "Admin"
	set name = "Cancel Evac"

	if(!check_rights(R_ADMIN))	return

	if(alert(src, "You sure?", "Confirm", "Yes", "No") != "Yes") return

	if(!ticker || !emergency_shuttle.can_recall())
		return

	emergency_shuttle.recall()
	log_admin("[key_name(usr)] admin-recalled the emergency shuttle.")
	message_admins("\blue [key_name_admin(usr)] admin-recalled the emergency shuttle.", 1)

	return

/client/proc/admin_deny_shuttle()
	set category = "Admin"
	set name = "Toggle Deny Evac"

	if (!ticker)
		return

	if(!check_rights(R_ADMIN))	return

	emergency_shuttle.deny_shuttle = !emergency_shuttle.deny_shuttle

	log_admin("[key_name(src)] has [emergency_shuttle.deny_shuttle ? "denied" : "allowed"] the shuttle to be called.")
	message_admins("[key_name_admin(usr)] has [emergency_shuttle.deny_shuttle ? "denied" : "allowed"] the shuttle to be called.")

//TODO: rewrite and standardise all controller datums to the datum/controller type
//TODO: allow all controllers to be deleted for clean restarts (see WIP master controller stuff) - MC done - lighting done
var/list/controllers_by_name = list()
var/list/controller_feedback_by_name = list()

/client/proc/restart_controller(controller in list("Supply"))
	set category = "Debug"
	set name = "Restart Controller"
	set desc = "Restart one of the various periodic loop controllers for the game (be careful!)"

	if(!holder)	return
	usr = null
	src = null
	switch(controller)
		if("Supply")
			supply_controller.process()
			feedback_add_details("admin_verb","RSupply")
	message_admins("Admin [key_name_admin(usr)] has restarted the [controller] controller.")
	return

/client/proc/debug_antagonist_template(antag_type in all_antag_types)
	set category = "Debug"
	set name = "Debug Antagonist"
	set desc = "Debug an antagonist template."

	var/datum/antagonist/antag = all_antag_types[antag_type]
	if(antag)
		usr.client.debug_variables(antag)
		message_admins("Admin [key_name_admin(usr)] is debugging the [antag.role_text] template.")

/client/proc/debug_controller(controller in controllers_by_name)
	set category = "Debug"
	set name = "Debug Controller"
	set desc = "Debug the various periodic loop controllers for the game (be careful!)"

	if(!holder)	return

	if(controllers_by_name[controller] && controller_feedback_by_name[controller])
		debug_variables(controllers_by_name[controller])
		feedback_add_details("admin_verb","[controller_feedback_by_name[controller]]")
	else
		to_chat(usr, "Untracked controller, please report this to the bug tracker.")

	message_admins("Admin [key_name_admin(usr)] is debugging the [controller] controller.")
	return

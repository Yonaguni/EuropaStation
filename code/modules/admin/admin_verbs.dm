var/list/admin_verbs_default = list(
	/datum/admins/proc/show_player_panel,
	/client/proc/toggleadminhelpsound,
	/client/proc/deadmin_self,
	/client/proc/debug_variables,
	/client/proc/cmd_assume_direct_control,
	/client/proc/cmd_debug_del_all
	)

var/list/admin_verbs_admin = list(
	/datum/admins/proc/show_game_mode,
	/datum/admins/proc/force_mode_latespawn,
	/datum/admins/proc/force_antag_latespawn,
	/datum/admins/proc/toggleenter,
	/datum/admins/proc/toggleguests,
	/datum/admins/proc/announce,
	/client/proc/colorooc,
	/client/proc/admin_ghost,
	/client/proc/toggle_view_range,
	/datum/admins/proc/view_txt_log,
	/datum/admins/proc/view_atk_log,
	/client/proc/cmd_admin_pm_context,
	/client/proc/cmd_admin_pm_panel,
	/client/proc/cmd_admin_subtle_message,
	/client/proc/cmd_admin_delete,
	/client/proc/giveruntimelog,
	/client/proc/getserverlog,
	/client/proc/jumptocoord,
	/client/proc/Getmob,
	/client/proc/Getkey,
	/client/proc/Jump,
	/client/proc/jumptokey,
	/client/proc/jumptomob,
	/client/proc/jumptoturf,
	/client/proc/admin_call_shuttle,
	/client/proc/admin_cancel_shuttle,
	/client/proc/cmd_admin_direct_narrate,
	/client/proc/cmd_admin_world_narrate,
	/client/proc/cmd_admin_create_centcom_report,
	/client/proc/check_antagonists,
	/client/proc/admin_memo,
	/client/proc/dsay,
	/client/proc/toggle_hear_radio,
	/client/proc/secrets,
	/datum/admins/proc/toggleooc,
	/datum/admins/proc/toggledsay,
	/client/proc/cmd_admin_say,
	/datum/admins/proc/togglehubvisibility,
	/datum/admins/proc/PlayerNotes,
	/datum/admins/proc/show_player_info,
	/client/proc/free_slot,
	/client/proc/cmd_admin_change_custom_event,
	/client/proc/cmd_admin_rejuvenate,
	/client/proc/toggleattacklogs,
	/client/proc/toggledebuglogs,
	/datum/admins/proc/show_aspects,
	/client/proc/toggle_antagHUD_use,
	/client/proc/toggle_antagHUD_restrictions,
	/client/proc/allow_character_respawn,
	/client/proc/event_manager_panel,
	/client/proc/change_human_appearance_admin,
	/client/proc/change_human_appearance_self,
	/datum/admins/proc/reload_vips,
	/datum/admins/proc/show_vips,
	/client/proc/view_chemical_reaction_logs,
	/client/proc/toggle_random_events,
	)

var/list/admin_verbs_ban = list(
	/datum/admins/proc/apply_server_ban,
	/datum/admins/proc/apply_job_ban,
	/datum/admins/proc/list_bans,
	/datum/admins/proc/unban
	)

var/list/admin_verbs_sounds = list(
	/client/proc/play_local_sound,
	/client/proc/play_sound,
	/client/proc/make_sound
	)

var/list/admin_verbs_spawn = list(
	/client/proc/drop_bomb,
	/datum/admins/proc/spawn_fruit,
	/datum/admins/proc/spawn_fluid_verb,
	/datum/admins/proc/spawn_custom_item,
	/datum/admins/proc/check_custom_items,
	/datum/admins/proc/spawn_plant,
	/datum/admins/proc/spawn_atom
)

var/list/admin_verbs_server = list(
	/datum/admins/proc/capture_map,
	/client/proc/ToRban,
	/datum/admins/proc/startnow,
	/datum/admins/proc/restart,
	/datum/admins/proc/delay,
	/datum/admins/proc/toggleaban,
	/client/proc/toggle_log_hrefs,
	/client/proc/cmd_admin_delete,
	/client/proc/toggle_random_events
	)
var/list/admin_verbs_debug = list(
	/client/proc/getruntimelog,
	/client/proc/debug_controller,
	/client/proc/debug_antagonist_template,
	/client/proc/cmd_admin_delete,
	/client/proc/print_random_map,
	/client/proc/create_random_map,
	/client/proc/apply_random_map,
	/client/proc/overlay_random_map,
	/client/proc/delete_random_map,
	/client/proc/callproc,
	/client/proc/callproc_target,
	/client/proc/toggledebuglogs,
	/client/proc/SDQL_query,
	/client/proc/SDQL2_query,
	/client/proc/Jump,
	/client/proc/jumptomob,
	/client/proc/jumptocoord,
	/client/proc/dsay
	)

/client/proc/add_admin_verbs()
	if(!holder)
		return

	verbs += admin_verbs_default
	if(holder.rights & R_ADMIN)
		verbs += admin_verbs_admin

	if(holder.rights & R_BAN)
		verbs += admin_verbs_ban

	if(holder.rights & R_SERVER)
		verbs += admin_verbs_server

	if(holder.rights & R_DEBUG)
		verbs += admin_verbs_debug

	if(holder.rights & R_SOUNDS)
		verbs += admin_verbs_sounds

	if(holder.rights & R_SPAWN)
		verbs += admin_verbs_spawn

/client/proc/remove_admin_verbs()
	verbs.Remove(
		admin_verbs_default,
		admin_verbs_admin,
		admin_verbs_ban,
		admin_verbs_server,
		admin_verbs_debug,
		admin_verbs_sounds,
		admin_verbs_spawn
		)

/client/proc/admin_ghost()
	set category = "Admin"
	set name = "Aghost"
	if(!holder)	return
	if(istype(mob,/mob/dead/observer))
		//re-enter
		var/mob/dead/observer/ghost = mob
		ghost.can_reenter_corpse = 1
		ghost.reenter_corpse()
	else if(istype(mob,/mob/new_player))
		src << "<font color='red'>Error: Aghost: Can't admin-ghost whilst in the lobby. Join or Observe first.</font>"
	else
		//ghostize
		var/mob/body = mob
		var/mob/dead/observer/ghost = body.ghostize(1)
		ghost.admin_ghosted = 1
		if(body)
			body.teleop = ghost
			if(!body.key)
				body.key = "@[key]"	//Haaaaaaaack. But the people have spoken. If it breaks; blame adminbus

/client/proc/check_antagonists()
	set name = "Check Antagonists"
	set category = "Admin"
	if(holder)
		holder.check_antagonists()
		log_admin("[key_name(usr)] checked antagonists.")	//for tsar~
	return

/client/proc/secrets()
	set name = "Secrets"
	set category = "Admin"
	if (holder)
		holder.Secrets()
	return

/client/proc/colorooc()
	set category = "Fun"
	set name = "OOC Text Color"
	if(!holder)	return
	var/response = alert(src, "Please choose a distinct color that is easy to read and doesn't mix with all the other chat and radio frequency colors.", "Change own OOC color", "Pick new color", "Reset to default", "Cancel")
	if(response == "Pick new color")
		prefs.ooccolor = input(src, "Please select your OOC colour.", "OOC colour") as color
	else if(response == "Reset to default")
		prefs.ooccolor = initial(prefs.ooccolor)
	prefs.save_preferences()

	return

/client/proc/drop_bomb() // Some admin dickery that can probably be done better -- TLE
	set category = "Special Verbs"
	set name = "Drop Bomb"
	set desc = "Cause an explosion of varying strength at your location."

	var/turf/epicenter = mob.loc
	var/list/choices = list("Small Bomb", "Medium Bomb", "Big Bomb", "Custom Bomb")
	var/choice = input("What size explosion would you like to produce?") in choices
	switch(choice)
		if(null)
			return 0
		if("Small Bomb")
			explosion(epicenter, 1, 2, 3, 3)
		if("Medium Bomb")
			explosion(epicenter, 2, 3, 4, 4)
		if("Big Bomb")
			explosion(epicenter, 3, 5, 7, 5)
		if("Custom Bomb")
			var/devastation_range = input("Devastation range (in tiles):") as num
			var/heavy_impact_range = input("Heavy impact range (in tiles):") as num
			var/light_impact_range = input("Light impact range (in tiles):") as num
			var/flash_range = input("Flash range (in tiles):") as num
			explosion(epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range)
	message_admins("\blue [ckey] creating an admin explosion at [epicenter.loc].")

/client/proc/make_sound(var/obj/O in range(world.view)) // -- TLE
	set category = "Special Verbs"
	set name = "Make Sound"
	set desc = "Display a message to everyone who can hear the target"
	if(O)
		var/message = sanitize(input("What do you want the message to be?", "Make Sound") as text|null)
		if(!message)
			return
		for (var/mob/V in hearers(O))
			V.show_message(message, 2)
		log_admin("[key_name(usr)] made [O] at [O.x], [O.y], [O.z]. make a sound")
		message_admins("\blue [key_name_admin(usr)] made [O] at [O.x], [O.y], [O.z]. make a sound", 1)

/client/proc/readmin_self()
	set name = "Re-Admin self"
	set category = "Admin"

	if(deadmin_holder)
		deadmin_holder.reassociate()
		log_admin("[src] re-admined themself.")
		message_admins("[src] re-admined themself.", 1)
		src << "<span class='interface'>You now have the keys to control the planet, or atleast a small space station</span>"
		verbs -= /client/proc/readmin_self

/client/proc/deadmin_self()
	set name = "De-admin self"
	set category = "Admin"

	if(holder)
		if(alert("Confirm self-deadmin for the round? You can re-admin yourself at any time.",,"Yes","No") == "Yes")
			log_admin("[src] deadmined themself.")
			message_admins("[src] deadmined themself.", 1)
			deadmin()
			src << "<span class='interface'>You are now a normal player.</span>"
			verbs |= /client/proc/readmin_self

/client/proc/toggle_log_hrefs()
	set name = "Toggle href logging"
	set category = "Server"
	if(!holder)	return
	if(config)
		if(config.log_hrefs)
			config.log_hrefs = 0
			src << "<b>Stopped logging hrefs</b>"
		else
			config.log_hrefs = 1
			src << "<b>Started logging hrefs</b>"

/client/proc/change_human_appearance_admin()
	set name = "Change Mob Appearance - Admin"
	set desc = "Allows you to change the mob appearance"
	set category = "Admin"

	if(!check_rights(R_SPAWN)) return

	var/mob/living/human/H = input("Select mob.", "Change Mob Appearance - Admin") as null|anything in human_mob_list
	if(!H) return

	usr << "Change Mob Appearance currently disabled pending ui rewrite."

/client/proc/change_human_appearance_self()
	set name = "Change Mob Appearance - Self"
	set desc = "Allows the mob to change its appearance"
	set category = "Admin"

	if(!check_rights(R_SPAWN)) return

	usr << "Change Mob Appearance currently disabled pending ui rewrite."
/*
	var/mob/living/human/H = input("Select mob.", "Change Mob Appearance - Self") as null|anything in human_mob_list
	if(!H) return

	if(!H.client)
		usr << "Only mobs with clients can alter their own appearance."
		return

	switch(alert("Do you wish for [H] to be allowed to select non-whitelisted races?","Alter Mob Appearance","Yes","No","Cancel"))
		if("Yes")
			log_and_message_admins("has allowed [H] to change \his appearance, without whitelisting of races.")
			H.change_appearance(APPEARANCE_ALL, H.loc, check_species_whitelist = 0)
		if("No")
			log_and_message_admins("has allowed [H] to change \his appearance, with whitelisting of races.")
			H.change_appearance(APPEARANCE_ALL, H.loc, check_species_whitelist = 1)
*/

//---- bs12 verbs ----

/client/proc/mod_panel()
	set name = "Moderator Panel"
	set category = "Admin"
	return

/client/proc/playernotes()
	set name = "Show Player Info"
	set category = "Admin"
	if(holder)
		holder.PlayerNotes()
	return

/client/proc/free_slot()
	set name = "Free Job Slot"
	set category = "Admin"
	if(holder)
		var/list/jobs = list()
		for (var/datum/job/J in job_master.occupations)
			if (J.current_positions >= J.total_positions && J.total_positions != -1)
				jobs += J.title
		if (!jobs.len)
			usr << "There are no fully staffed jobs."
			return
		var/job = input("Please select job slot to free", "Free job slot")  as null|anything in jobs
		if (job)
			job_master.FreeRole(job)
			message_admins("A job slot for [job] has been opened by [key_name_admin(usr)]")
			return

/client/proc/toggleattacklogs()
	set name = "Toggle Attack Log Messages"
	set category = "Preferences"

	prefs.toggles ^= CHAT_ATTACKLOGS
	if (prefs.toggles & CHAT_ATTACKLOGS)
		usr << "You now will get attack log messages"
	else
		usr << "You now won't get attack log messages"

/client/proc/toggledebuglogs()
	set name = "Toggle Debug Log Messages"
	set category = "Preferences"

	prefs.toggles ^= CHAT_DEBUGLOGS
	if (prefs.toggles & CHAT_DEBUGLOGS)
		usr << "You now will get debug log messages"
	else
		usr << "You now won't get debug log messages"

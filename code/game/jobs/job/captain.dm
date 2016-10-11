var/datum/announcement/minor/captain_announcement = new(do_newscast = 1)

/datum/job/captain
	title = "Commanding Officer"
	department = "Command"
	head_position = 1
	department_flag = COM
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Jovian Naval Authority and the Free Trade Union Admirality"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	economic_modifier = 20

	ideal_character_age = 70 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/captain

// Placeholder
/datum/job/xo
	title = "Executive Officer"
	department = "Command"
	head_position = 1
	department_flag = COM
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the ship's Commanding Officer"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	economic_modifier = 20

	ideal_character_age = 70 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/bridge/xo

/datum/job/xo/get_access()
	return get_all_station_access()
// End placeholder

/datum/job/hop
	title = "Operations Officer"
	head_position = 1
	department_flag = COM|CIV
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the ship's Commanding Officer"
	selection_color = "#2f2f7f"
	req_admin_notify = 1
	minimal_player_age = 14
	economic_modifier = 10
	ideal_character_age = 50

	access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)

	outfit_type = /decl/hierarchy/outfit/job/bridge/operations

// Placeholder
/datum/job/bridge
	title = "Flight Controller"
	head_position = 1
	department_flag = COM|CIV
	faction = "Crew"
	total_positions = 3
	spawn_positions = 1
	supervisors = "the ship's Commanding Officer"
	selection_color = "#2f2f7f"
	req_admin_notify = 1
	minimal_player_age = 14
	economic_modifier = 10
	ideal_character_age = 50

	access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)

	outfit_type = /decl/hierarchy/outfit/job/bridge
// End placeholder
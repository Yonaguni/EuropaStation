/datum/job/chief_engineer
	title = "Chief of Engineering"
	head_position = 1
	department = "Engineering"
	department_flag = ENG|COM
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the ship's Commanding Officer"
	selection_color = "#7f6e2c"
	req_admin_notify = 1
	economic_modifier = 10

	ideal_character_age = 50


	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload)
	minimal_player_age = 14
	outfit_type = /decl/hierarchy/outfit/job/engineering/chief_engineer

/datum/job/engineer
	title = "Engineering Officer"
	department = "Engineering"
	department_flag = ENG
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the Chief Engineer"
	selection_color = "#5b4d20"
	economic_modifier = 5
	minimal_player_age = 7
	access = list(access_eva, access_engine, access_atmospherics, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics)
	minimal_access = list(access_eva, access_atmospherics, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction)
	alt_titles = list("Maintenance Technician","Engine Technician","Life Support Technician")
	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer

/datum/job/roboticist
	title = "Roboticist"
	department = "Science"
	department_flag = SCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Chief Engineer"
	selection_color = "#633d63"
	economic_modifier = 5
	access = list(access_robotics, access_tox, access_tox_storage, access_tech_storage, access_morgue, access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	minimal_player_age = 3
	outfit_type = /decl/hierarchy/outfit/job/science/roboticist

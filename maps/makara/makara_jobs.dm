/datum/antagonist/revolutionary/New()
	restricted_job_types |= list(/datum/job/makara/crew/captain)
	protected_job_types |= list(/datum/job/makara/crew/gunner)
	..()

/datum/antagonist/traitor/New()
	protected_job_types |= list(/datum/job/makara/crew/captain, /datum/job/makara/crew/gunner)
	..()

/datum/map/makara
	default_role = "Passenger"
	default_job_type = /datum/job/makara
	allowed_jobs = list(
		/datum/job/makara/scientist,
		/datum/job/makara/crew,
		/datum/job/makara/crew/gunner,
		/datum/job/makara/crew/doctor,
		/datum/job/makara/crew/engineer,
		/datum/job/makara/crew/mate,
		/datum/job/makara/crew/captain,
		/datum/job/ai,
		/datum/job/cyborg
		)

/datum/job/makara
	title = "Passenger"
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = -1
	spawn_positions = -1
	access = list()
	minimal_access = list()
	supervisors = "the crew of the ship"
	outfit_type = /decl/hierarchy/outfit/job/makara
	selection_color = "#515151"

/datum/job/makara/scientist
	title = "Science Officer"
	head_position = 1
	department = "Science"
	department_flag = COM|SCI
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Captain"
	selection_color = "#ad6bad"
	req_admin_notify = 1
	economic_modifier = 15
	access = list(access_rd, access_tox, access_genetics, access_morgue,access_tox_storage, access_teleporter, access_sec_doors,access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch, access_network)
	minimal_access = list(access_rd, access_tox, access_genetics, access_morgue, access_tox_storage, access_teleporter, access_sec_doors, access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage, access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch, access_network)
	minimal_player_age = 14
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/makara/scientist

/datum/job/makara/crew
	title = "Crewman"
	access = list(access_maint_tunnels)
	minimal_access = list(access_maint_tunnels)
	total_positions = 15
	spawn_positions = 15
	department = "Security"
	department_flag = SEC
	supervisors = "the ship's Captain and First Mate"
	outfit_type = /decl/hierarchy/outfit/job/makara/crew
	selection_color = "#601c1c"
	access = list(access_maint_tunnels, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting)
	minimal_access = list(access_maint_tunnels, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting)

/datum/job/makara/crew/engineer
	title = "Engineer"
	total_positions = 1
	spawn_positions = 1
	access = list(access_heads, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_kitchen, access_tech_storage, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)
	minimal_access = list(access_heads, access_engine, access_maint_tunnels, access_rd, access_engine_equip, access_kitchen, access_atmospherics, access_tech_storage, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)
	supervisors = "the ship's Captain and First Mate"
	department = "Engineering"
	department_flag = ENG
	selection_color = "#5b4d20"
	outfit_type = /decl/hierarchy/outfit/job/makara/crew/engineer

/datum/job/makara/crew/captain
	title = "Captain"
	head_position = 1
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Jovian Naval Authority and the Research Division"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	minimal_player_age = 9
	economic_modifier = 20
	outfit_type = /decl/hierarchy/outfit/job/makara/crew/captain
	access = list(access_keycard_auth, access_kitchen, access_captain, access_medical, access_security, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)
	minimal_access = list(access_keycard_auth, access_kitchen, access_captain, access_medical, access_security, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)

/datum/job/makara/crew/mate
	title = "First Mate"
	selection_color = "#1d1d4f"
	head_position = 1
	supervisors = "the ship's Captain"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 6
	outfit_type = /decl/hierarchy/outfit/job/makara/crew/firstmate
	access = list(access_keycard_auth, access_kitchen, access_medical, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting)
	minimal_access = list(access_keycard_auth, access_kitchen, access_medical, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting)

/datum/job/makara/crew/gunner
	title = "Gunner"
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 6
	department = "Security"
	department_flag = SEC
	selection_color = "#8e2929"
	outfit_type = /decl/hierarchy/outfit/job/makara/crew/gunner
	access = list(access_heads, access_armory, access_kitchen, access_security, access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)
	minimal_access = list(access_heads, access_armory, access_kitchen, access_security, access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)

/datum/job/makara/crew/doctor
	title = "Ship Doctor"
	total_positions = 1
	spawn_positions = 1
	department = "Medical"
	department_flag = MED
	minimal_player_age = 6
	selection_color = "#026865"
	outfit_type = /decl/hierarchy/outfit/job/makara/crew/doctor
	access = list(access_medical, access_kitchen)
	minimal_access = list(access_medical, access_kitchen)

/mob/living/carbon/human/proc/makara_captain_rename_ship()

	set name = "Rename Ship"
	set desc = "Choose a name for the ship (one use)."
	set category = "IC"

	var/datum/map/makara/makara = using_map
	if(istype(makara))
		var/newname = sanitizeSafe(input("Enter a new name.", "Ship Name"), MAX_LNAME_LEN)
		if(!newname || newname == "")
			return
		makara.full_name = "SSV [newname]"
		world << "<span class='notice'><b>Captain [real_name] has christened this vessel the [makara.full_name]!</b></span>"
	else
		src << "<span class='warning'>You shouldn't have had that verb; please report it to a developer.</span>"
	src.verbs -= /mob/living/carbon/human/proc/makara_captain_rename_ship

/decl/hierarchy/outfit/job/makara/crew/engineer
	name = "Engineer"
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	pda_type = /obj/item/radio/headset/pda/engineering

/obj/effect/landmark/start/makara
	name = "Passenger"
/obj/effect/landmark/start/makara/crewman
	name = "Crewman"
/obj/effect/landmark/start/makara/engineer
	name = "Engineer"
/obj/effect/landmark/start/makara/captain
	name = "Captain"
/obj/effect/landmark/start/makara/firstmate
	name = "First Mate"
/obj/effect/landmark/start/makara/gunner
	name = "Gunner"
/obj/effect/landmark/start/makara/doctor
	name = "Ship Doctor"
/obj/effect/landmark/start/makara/scientist
	name = "Science Officer"

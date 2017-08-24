/datum/antagonist/changeling/New()
	protected_job_types |= list(/datum/job/katydid/crew/captain)
	..()

/datum/antagonist/cultist/New()
	restricted_job_types |= list(/datum/job/katydid/crew/gunner, /datum/job/katydid/crew/captain)
	protected_job_types |= list(/datum/job/katydid/crew/mate)
	..()

/datum/antagonist/revolutionary/New()
	restricted_job_types |= list(/datum/job/katydid/crew/captain)
	protected_job_types |= list(/datum/job/katydid/crew/gunner)
	..()

/datum/antagonist/traitor/New()
	protected_job_types |= list(/datum/job/katydid/crew/captain, /datum/job/katydid/crew/gunner)
	..()

/datum/map/katydid
	default_role = "Passenger"
	default_job_type = /datum/job/katydid
	allowed_jobs = list(
		/datum/job/katydid/priest,
		/datum/job/katydid/tourist,
		/datum/job/katydid/crew,
		/datum/job/katydid/crew/gunner,
		/datum/job/katydid/crew/doctor,
		/datum/job/katydid/crew/engineer,
		/datum/job/katydid/crew/mate,
		/datum/job/katydid/crew/captain,
		/datum/job/ai,
		/datum/job/cyborg
		)

/datum/job/katydid
	title = "Passenger"
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = -1
	spawn_positions = -1
	access = list()
	minimal_access = list()
	supervisors = "the crew of the ship"
	outfit_type = /decl/hierarchy/outfit/job/katydid
	selection_color = "#515151"

/datum/job/katydid/tourist
	title = "Tourist"
	outfit_type = /decl/hierarchy/outfit/job/katydid/tourist
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = 3
	spawn_positions = 1
	supervisors = "your home government"
	access = list()
	minimal_access = list()
	selection_color = "#633d63"


/datum/job/katydid/priest
	title = "Preacher"
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 3
	supervisors = "the tenets of your religion"
	outfit_type = /decl/hierarchy/outfit/job/katydid/priest

/datum/job/katydid/crew
	title = "Crewman"
	access = list(access_maint_tunnels)
	minimal_access = list(access_maint_tunnels)
	total_positions = 15
	spawn_positions = 15
	department = "Security"
	department_flag = SEC
	supervisors = "the ship's Captain and First Mate"
	outfit_type = /decl/hierarchy/outfit/job/katydid/crew
	selection_color = "#601c1c"
	access = list(access_maint_tunnels, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting)
	minimal_access = list(access_maint_tunnels, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting)

/datum/job/katydid/crew/engineer
	title = "Engineer"
	total_positions = 1
	spawn_positions = 1
	access = list(access_heads, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_kitchen, access_tech_storage, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)
	minimal_access = list(access_heads, access_engine, access_maint_tunnels, access_rd, access_engine_equip, access_kitchen, access_atmospherics, access_tech_storage, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)
	supervisors = "the ship's Captain and First Mate"
	department = "Engineering"
	department_flag = ENG
	selection_color = "#5b4d20"
	outfit_type = /decl/hierarchy/outfit/job/katydid/crew/engineer

/datum/job/katydid/crew/captain
	title = "Captain"
	head_position = 1
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Free Trade Union and your own profit margins"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	minimal_player_age = 9
	economic_modifier = 20
	outfit_type = /decl/hierarchy/outfit/job/katydid/crew/captain
	access = list(access_keycard_auth, access_kitchen, access_captain, access_medical, access_security, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)
	minimal_access = list(access_keycard_auth, access_kitchen, access_captain, access_medical, access_security, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting, access_ai_upload)

/datum/job/katydid/crew/mate
	title = "First Mate"
	selection_color = "#1d1d4f"
	head_position = 1
	supervisors = "the ship's Captain"
	department = "Command"
	department_flag = COM
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 6
	outfit_type = /decl/hierarchy/outfit/job/katydid/crew/firstmate
	access = list(access_keycard_auth, access_kitchen, access_medical, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting)
	minimal_access = list(access_keycard_auth, access_kitchen, access_medical, access_heads, access_armory, access_engine, access_maint_tunnels, access_rd, access_atmospherics, access_engine_equip, access_cargo, access_cargo_bot, access_mailsorting)

/datum/job/katydid/crew/gunner
	title = "Gunner"
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 6
	department = "Security"
	department_flag = SEC
	selection_color = "#8e2929"
	outfit_type = /decl/hierarchy/outfit/job/katydid/crew/gunner
	access = list(access_heads, access_armory, access_kitchen, access_security, access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)
	minimal_access = list(access_heads, access_armory, access_kitchen, access_security, access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)

/datum/job/katydid/crew/doctor
	title = "Ship Doctor"
	total_positions = 1
	spawn_positions = 1
	department = "Medical"
	department_flag = MED
	minimal_player_age = 6
	selection_color = "#026865"
	outfit_type = /decl/hierarchy/outfit/job/katydid/crew/doctor
	access = list(access_medical, access_kitchen)
	minimal_access = list(access_medical, access_kitchen)

/mob/living/carbon/human/proc/katydid_captain_rename_ship()

	set name = "Rename Ship"
	set desc = "Choose a name for the ship (one use)."
	set category = "IC"

	var/datum/map/katydid/katydid = using_map
	if(istype(katydid))
		var/newprefix = input("Select a new prefix.", "Ship Name") as null|anything in katydid.possible_ship_prefix
		if(!newprefix)
			return
		var/newname = sanitizeSafe(input("Enter a new name.", "Ship Name"), MAX_LNAME_LEN)
		if(!newname || newname == "")
			return
		katydid.ship_prefix = newprefix
		katydid.ship_name = newname
		katydid.full_name = "[katydid.ship_prefix] [katydid.ship_name]"
		world << "<span class='notice'><b>Captain [real_name] has christened this vessel the [katydid.full_name]!</b></span>"
	else
		src << "<span class='warning'>You shouldn't have had that verb; please report it to a developer.</span>"
	src.verbs -= /mob/living/carbon/human/proc/katydid_captain_rename_ship

/decl/hierarchy/outfit/job/katydid/crew/engineer
	name = "Engineer"
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	pda_type = /obj/item/radio/headset/pda/engineering

/obj/effect/landmark/start/katydid
	name = "Passenger"
/obj/effect/landmark/start/katydid/preacher
	name = "Preacher"
/obj/effect/landmark/start/katydid/crewman
	name = "Crewman"
/obj/effect/landmark/start/katydid/engineer
	name = "Engineer"
/obj/effect/landmark/start/katydid/captain
	name = "Captain"
/obj/effect/landmark/start/katydid/firstmate
	name = "First Mate"
/obj/effect/landmark/start/katydid/gunner
	name = "Gunner"
/obj/effect/landmark/start/katydid/doctor
	name = "Ship Doctor"
/obj/effect/landmark/start/katydid/tourist
	name = "Tourist"
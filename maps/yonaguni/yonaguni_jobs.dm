/datum/antagonist/changeling/New()
	protected_job_types |= list(/datum/job/officer, /datum/job/warden, /datum/job/qm, /datum/job/captain, /datum/job/hos)
	..()

/datum/antagonist/cultist/New()
	restricted_job_types |= list(/datum/job/hos, /datum/job/captain)
	protected_job_types |= list(/datum/job/officer, /datum/job/warden)
	..()

/datum/antagonist/revolutionary/New()
	restricted_job_types |= list(/datum/job/chief_engineer, /datum/job/administrator, /datum/job/captain, /datum/job/hos, /datum/job/scientist, /datum/job/cmo)
	protected_job_types |= list(/datum/job/officer, /datum/job/warden)
	..()

/datum/antagonist/traitor/New()
	protected_job_types |= list(/datum/job/officer, /datum/job/warden, /datum/job/hos, /datum/job/captain)
	..()

/datum/map/yonaguni
	default_role = "Employee"
	default_job_type = /datum/job/crewman/employee
	allowed_jobs = list(
		/datum/job/crewman/employee,
		/datum/job/captain,
		/datum/job/administrator,
		/datum/job/chief_engineer,
		/datum/job/engineer,
		/datum/job/roboticist,
		/datum/job/chef,
		/datum/job/qm,
		/datum/job/janitor,
		/datum/job/hos,
		/datum/job/warden,
		/datum/job/officer,
		/datum/job/scientist,
		/datum/job/cmo,
		/datum/job/doctor,
		/datum/job/psychiatrist,
		/datum/job/xenobiologist,
		/datum/job/ai,
		/datum/job/cyborg
		)

/datum/job/crewman/employee
	title = "Employee"
	supervisors = "absolutely everyone"
	welcome_blurb = "Research facilities often need people to do odd jobs. Today, that would be you."

/datum/job/captain
	title = "Site Director"
	welcome_blurb = "You are in charge of the entire facility and everyone on it. Keep it running smoothly. The buck stops with you."
	department = "Command"
	head_position = 1
	department_flag = COM
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the PicoMotion board of investors and the Jovian Naval Authority"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	economic_modifier = 20

	ideal_character_age = 70 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/colony_director

/datum/job/captain/New()
	id_modifying_ranks |= title
	..()

/datum/job/captain/get_access()
	return get_all_station_access()

/datum/job/administrator
	title = "Deputy Director"
	welcome_blurb = "Assist the Site Director in managing the crew and keeping the station running. Hand out access to those who need it, or terminate access for those who have been fired."
	head_position = 1
	department_flag = COM|CIV
	faction = "Crew"
	total_positions = 3
	spawn_positions = 1
	supervisors = "the Site Director"
	selection_color = "#2f2f7f"
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

	outfit_type = /decl/hierarchy/outfit/job/colony_administrator
// End placeholder

/datum/job/chief_engineer
	title = "Chief of Engineering"
	welcome_blurb = "Coordinate and direct the Engineering department in keeping the facility in one piece. Try not to go mad."
	head_position = 1
	department = "Engineering"
	department_flag = ENG|COM
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Site Director"
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
	outfit_type = /decl/hierarchy/outfit/job/europa_engineer/coe

/datum/job/engineer
	title = "Engineer"
	welcome_blurb = "Keep the lights on, the water out, and the power flowing. Easier said than done."
	department = "Engineering"
	department_flag = ENG
	faction = "Crew"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the Chief of Engineering"
	selection_color = "#5b4d20"
	economic_modifier = 5
	minimal_player_age = 7
	access = list(access_eva, access_engine, access_atmospherics, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics)
	minimal_access = list(access_eva, access_atmospherics, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction)
	alt_titles = list("Maintenance Technician","Engine Technician","Life Support Technician")
	outfit_type = /decl/hierarchy/outfit/job/europa_engineer

/datum/job/roboticist
	title = "Roboticist"
	welcome_blurb = "Build and maintain station robots, install and repair prosthetic limbs, and flaunt your doctorate over the rest of Engineering."
	department = "Engineering"
	department_flag = ENG
	faction = "Crew"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Chief of Engineering"
	selection_color = "#5b4d20"
	economic_modifier = 5
	access = list(access_robotics, access_tox, access_tox_storage, access_tech_storage, access_morgue, access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	minimal_player_age = 3
	outfit_type = /decl/hierarchy/outfit/job/europa_engineer/roboticist

//Food
/datum/job/chef
	title = "Cook"
	welcome_blurb = "Grow food and stock the cafeteria with meals and drinks to keep the crew moving. Avoid letting them find out you're serving them monkey steak."
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Chief of Logistics"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_kitchen)
	outfit_type = /decl/hierarchy/outfit/job/europa_chef

//Cargo
/datum/job/qm
	title = "Chief of Logistics"
	welcome_blurb = "Direct and coordinate the Supply department. Make orders, deploy supply beacons, and draft Employees to drag crates around when you can't be bothered."
	head_position = 1
	department = "Civilian"
	department_flag = CIV|CRG
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Site Director"
	selection_color = "#737373"
	economic_modifier = 5
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_player_age = 3
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/europa_chief_of_logistics

/datum/job/janitor
	title = "Sanitation Technician"
	welcome_blurb = "Keep the station clean and tidy. Put out wet floor signs while mopping and watch people slip over anyway."
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Chief of Logistics"
	selection_color = "#515151"
	access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	minimal_access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	outfit_type = /decl/hierarchy/outfit/job/europa_janitor

/datum/job/hos
	title = "Chief of Security"
	welcome_blurb = "Direct and coordinate the Security forces on the station."
	head_position = 1
	department = "Security"
	department_flag = SEC|COM
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Site Director"
	selection_color = "#8e2929"
	req_admin_notify = 1
	economic_modifier = 10
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_research, access_engine, access_mining, access_medical, access_construction, access_mailsorting,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimal_player_age = 14
	outfit_type = /decl/hierarchy/outfit/job/europa_chief_of_police

/datum/job/hos/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)

/datum/job/warden
	title = "Security Quartermaster"
	welcome_blurb = "Look after the armory, hand out weapons as directed, and keep an eye on any prisoners in the brig."
	department = "Security"
	department_flag = SEC
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Security Chief"
	selection_color = "#601c1c"
	economic_modifier = 5
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/europa_police_quartermaster

/datum/job/officer
	title = "Security Officer"
	welcome_blurb = "Keep the peace amongst the crew. Sort out small disturbances and fights, and coordinate with your team to respond to larger crises."
	department = "Security"
	department_flag = SEC
	faction = "Crew"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Security Chief"
	selection_color = "#601c1c"
	alt_titles = list("Junior Officer")
	economic_modifier = 4
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/europa_police_officer

/datum/job/scientist
	title = "Scientist"
	welcome_blurb = "You have a PhD, a laboratory full of gizmos, and nothing but free time. Make the most of it."
	department = "Science"
	department_flag = SCI
	faction = "Crew"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Site Director"
	selection_color = "#ad6bad"
	req_admin_notify = 1
	economic_modifier = 15
	access = list(access_rd, access_tox, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch, access_network)
	minimal_access = list(access_rd, access_tox, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch, access_network)
	minimal_player_age = 14
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/europa_scientist

/datum/job/xenobiologist
	title = "Xenobiologist"
	welcome_blurb = "Feed and crossbreed slimes to extract their cores, or grow and splice together exotic plants in the Xenoflora laboratory."
	department = "Science"
	department_flag = SCI
	faction = "Crew"
	total_positions = 3
	spawn_positions = 2
	supervisors = "the Site Director"
	selection_color = "#ad6bad"
	economic_modifier = 7
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_hydroponics)
	minimal_access = list(access_research, access_xenobiology, access_hydroponics)
	alt_titles = list(
		"Xenobotanist"
		)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/europa_doctor/xenobiologist

/datum/job/cmo
	title = "Chief of Medicine"
	welcome_blurb = "Direct and coordinate the Medical crew. Don't forget to feed Ganymede."
	head_position = 1
	department = "Medical"
	department_flag = MED|COM
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Site Director"
	selection_color = "#026865"
	req_admin_notify = 1
	economic_modifier = 10
	access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks)

	minimal_player_age = 14
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/europa_doctor/com

/datum/job/doctor
	title = "Doctor"
	welcome_blurb = "Treat wounds, mix medicines, administer pills, and conduct surgery. Try to keep at least some of the crew alive."
	department = "Medical"
	department_flag = MED
	faction = "Crew"
	minimal_player_age = 3
	total_positions = 5
	spawn_positions = 3
	supervisors = "the Chief of Medicine"
	selection_color = "#013d3b"
	economic_modifier = 7
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_chemistry)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_virology, access_chemistry)
	alt_titles = list(
		"Surgeon" = /decl/hierarchy/outfit/job/europa_doctor/surgeon,
		"Emergency Physician" = /decl/hierarchy/outfit/job/europa_doctor/emt,
		"Virologist" = /decl/hierarchy/outfit/job/europa_doctor/virologist
		)
	outfit_type = /decl/hierarchy/outfit/job/europa_doctor

/datum/job/psychiatrist
	title = "Counsellor"
	department = "Medical"
	department_flag = MED
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 5
	minimal_player_age = 3
	supervisors = "the Chief of Medicine"
	selection_color = "#013d3b"
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_psychiatrist)
	outfit_type = /decl/hierarchy/outfit/job/europa_doctor/counsellor

/obj/effect/landmark/start/employee
	name = "Employee"

/obj/effect/landmark/start/site_director
	name = "Site Director"

/obj/effect/landmark/start/deputy_director
	name = "Deputy Director"

/obj/effect/landmark/start/alien
	name = "Visitor"

/obj/effect/landmark/start/qm
	name = "Chief of Logistics"

/obj/effect/landmark/start/janitor
	name = "Sanitation Technician"

/obj/effect/landmark/start/cook
	name = "Cook"

/obj/effect/landmark/start/coe
	name = "Chief of Engineering"

/obj/effect/landmark/start/engineer
	name = "Engineer"

/obj/effect/landmark/start/roboticist
	name = "Roboticist"

/obj/effect/landmark/start/cmo
	name = "Chief of Medicine"

/obj/effect/landmark/start/medical_officer
	name = "Doctor"

/obj/effect/landmark/start/counsellor
	name = "Counsellor"

/obj/effect/landmark/start/xenobio
	name = "Xenobiologist"

/obj/effect/landmark/start/science_officer
	name = "Scientist"

/obj/effect/landmark/start/cos
	name = "Chief of Security"

/obj/effect/landmark/start/munitions_officer
	name = "Security Quartermaster"

/obj/effect/landmark/start/security_officer
	name = "Security Officer"

/obj/effect/landmark/start/colonist
	name = "Colonist"


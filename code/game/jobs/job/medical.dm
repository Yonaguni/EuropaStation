/datum/job/cmo
	title = "Chief of Medicine"
	head_position = 1
	department = "Medical"
	department_flag = MED|COM
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
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
	outfit_type = /decl/hierarchy/outfit/job/medical/cmo

/datum/job/doctor
	title = "Medical Officer"
	department = "Medical"
	department_flag = MED
	faction = "Station"
	minimal_player_age = 3
	total_positions = 5
	spawn_positions = 3
	supervisors = "the chief medical officer"
	selection_color = "#013d3b"
	economic_modifier = 7
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_chemistry)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_virology, access_chemistry)
	alt_titles = list(
		"Surgeon" = /decl/hierarchy/outfit/job/medical/doctor/surgeon,
		"Emergency Physician" = /decl/hierarchy/outfit/job/medical/doctor/emergency_physician,
		"Nurse" = /decl/hierarchy/outfit/job/medical/doctor/nurse)
	outfit_type = /decl/hierarchy/outfit/job/medical/doctor

/datum/job/psychiatrist
	title = "Counsellor"
	department = "Medical"
	department_flag = MED
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	economic_modifier = 5
	minimal_player_age = 3
	supervisors = "the Chief Medical Officer"
	selection_color = "#013d3b"
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_psychiatrist)
	minimal_access = list(access_medical, access_medical_equip, access_psychiatrist)
	alt_titles = list("Psychiatrist" = /decl/hierarchy/outfit/job/medical/psychiatrist, "Psychologist" = /decl/hierarchy/outfit/job/medical/psychiatrist/psychologist)
	outfit_type = /decl/hierarchy/outfit/job/medical/doctor

/datum/job/xenobiologist
	title = "Xenobiologist"
	department = "Medical"
	department_flag = SCI
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	supervisors = "the Chief Medical Officer"
	selection_color = "#633d63"
	economic_modifier = 7
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_hydroponics)
	minimal_access = list(access_research, access_xenobiology, access_hydroponics)
	alt_titles = list("Xenobotanist", "Virologist" = /decl/hierarchy/outfit/job/medical/doctor/virologist)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/science/xenobiologist

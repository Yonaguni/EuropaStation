/datum/job/foundation_liaison
	title = "Psionics Liaison"
	welcome_blurb = "You are a representative of the Cuchulain Foundation, serving as a consultant to the crew on psionic matters."
	department = "Medical"
	department_flag = MED
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Cuchulain Foundation advisory board, the Chief of Medicine, and your own conscience, in that order"
	selection_color = "#8271f2"
	access = list()
	minimal_access = list()
	minimal_player_age = 14
	economic_modifier = 12
	outfit_type = /decl/hierarchy/outfit/job/foundation
	psi_faculties = list(
		PSI_REDACTION = PSI_RANK_GRANDMASTER
	)
	access = list(access_foundation, access_medical, access_medical_equip, access_surgery, access_psychiatrist)
	minimal_access = list(access_foundation, access_medical, access_medical_equip, access_surgery, access_psychiatrist)

/obj/effect/landmark/start/foundation_counsellor
	name = "Psionics Liaison"

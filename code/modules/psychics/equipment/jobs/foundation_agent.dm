/datum/job/foundation_agent
	title = "Foundation Agent"
	welcome_blurb = "You are a Cuchulain Foundation field agent on secondment to your current site. When there's something strange in the neighborhood, you're the one they call."
	department = "Medical"
	department_flag = MED
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Cuchulain Foundation advisory board, the Psionics Liaison, the Chief of Medicine, and your own conscience, in that order"
	selection_color = "#6755e0"
	access = list(access_foundation, access_medical, access_medical_equip, access_surgery, access_psychiatrist)
	minimal_access = list(access_foundation, access_medical, access_medical_equip, access_surgery, access_psychiatrist)
	minimal_player_age = 14
	economic_modifier = 9
	outfit_type = /decl/hierarchy/outfit/job/foundation/agent
	psi_faculties = list(
		PSI_COERCION = PSI_RANK_MASTER,
		PSI_ENERGISTICS = PSI_RANK_MASTER
	)

/obj/effect/landmark/start/foundation_agent
	name = "Foundation Agent"

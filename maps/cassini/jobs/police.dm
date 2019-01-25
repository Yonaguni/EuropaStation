/datum/job/police
	welcome_blurb = "Keep the peace amongst the crew. Sort out small disturbances and fights, and coordinate with your team to respond to larger crises."
	department = "Police"
	department_flag = SEC
	supervisors = "the Chief of Police"
	selection_color = "#000080"
	economic_power = 4

/datum/job/police/officer
	title = "Police Officer"
	total_positions = 2
	spawn_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/cassini/police

/datum/job/police/police_chief
	title = "Chief of Police"
	welcome_blurb = "Direct and coordinate the colonial police. Keep the peace."
	total_positions = 1
	spawn_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/cassini/police/chief
	economic_power = 8
	department_flag = SEC|COM
	req_admin_notify = 1
	head_position = 1
	selection_color = "#000050"
	supervisors = "the Civil Administrator"
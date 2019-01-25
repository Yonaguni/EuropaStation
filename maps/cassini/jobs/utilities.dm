/datum/job/utilities
	welcome_blurb = "Keep the lights on, the water out, and the power flowing. Easier said than done."
	department_flag = ENG
	department = "Utilities"
	supervisors = "the General Foreman"
	selection_color = "#5b4d20"
	economic_power = 4

/datum/job/utilities/maintenance
	title = "Civil Technician"
	total_positions = 2
	spawn_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/cassini/utilities

/datum/job/utilities/construction
	title = "Construction Worker"
	total_positions = 2
	spawn_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/cassini/utilities/construction

/datum/job/utilities/maintenance_chief
	title = "General Foreman"
	welcome_blurb = "Coordinate and direct the Utilities staff in keeping the facility in one piece. Try not to go mad."
	total_positions = 1
	spawn_positions = 1
	head_position = TRUE
	department_flag = ENG|COM
	supervisors = "the Civil Administrator"
	selection_color = "#7f6e2c"
	req_admin_notify = 1
	outfit_type = /decl/hierarchy/outfit/job/cassini/utilities/chief
	economic_power = 8

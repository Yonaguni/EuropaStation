/datum/job/medical
	department_flag = MED
	department = "Medical"
	economic_power = 6
	selection_color = "#013d3b"
	supervisors = "the Chief Physician"

/datum/job/medical/physician
	title = "Physician"
	welcome_blurb = "Treat wounds, mix medicines, administer pills, and conduct surgery. Try to keep at least some of the colonists alive."
	total_positions = 3
	spawn_positions = 3
	hud_icon = "hudmedicaldoctor"
	outfit_type = /decl/hierarchy/outfit/job/cassini/medical

/datum/job/medical/physician_chief
	title = "Chief Physician"
	total_positions = 1
	spawn_positions = 1
	economic_power = 10
	department_flag = MED|COM
	welcome_blurb = "Direct and coordinate the Medical crew. Don't forget to feed Ganymede."
	selection_color = "#026865"
	req_admin_notify = 1
	head_position = TRUE
	outfit_type = /decl/hierarchy/outfit/job/cassini/medical/chief
	supervisors = "the Civil Administrator"
/datum/job/head
	title = "Colony Liaison"
	flag = LIAISON
	department_flag = CIVILIAN
	total_positions = 1
	spawn_positions = 1
	supervisors = "Jovian authorities"
	department = "Civil Sector"
	faction = "Station"
	head_position = 1
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1
	access = list()
	minimal_access = list()
	selection_color = "#dddddd"

/datum/job/head/marshal
	title = "Marshal"
	flag = MARSHAL
	department_flag = GOVERNMENT
	department = "Government Sector"
	selection_color = "#ccccff"

/datum/job/head/coordinator
	flag = CCO
	department_flag = INDUSTRY
	title = "Corporate Contact Officer"
	supervisors = "your corporate overseers"
	selection_color = "#ffeeff"
	department = "Industrial Sector"

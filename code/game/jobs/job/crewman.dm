/datum/job/crewman
	title = "Crewman"
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely everyone"
	selection_color = "#515151"
	economic_modifier = 1
	access = list()			//See /datum/job/crewman/get_access()
	minimal_access = list()	//See /datum/job/crewman/get_access()
	alt_titles = list("Ensign")
	outfit_type = /decl/hierarchy/outfit/job/crewman

/datum/job/crewman/get_access()
	if(config.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()

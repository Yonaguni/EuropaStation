/proc/make_shuttles()
	var/list/made_shuttles = list()
	var/datum/shuttle/ferry/shuttle

	// Escape pod.
	shuttle = new/datum/shuttle/ferry/emergency()
	shuttle.location = 1
	shuttle.warmup_time = 10
	shuttle.area_offsite = locate(/area/shuttle/escape/outpost)
	shuttle.area_station = locate(/area/shuttle/escape/station)
	shuttle.area_transition = locate(/area/shuttle/escape/transit)

	/*
	shuttle.docking_controller_tag = "escape_shuttle"
	shuttle.dock_target_station = "escape_dock"
	shuttle.dock_target_offsite = "centcom_dock"
	shuttle.transit_direction = NORTH
	*/

	shuttle.move_time = SHUTTLE_TRANSIT_DURATION_RETURN
	made_shuttles["Escape"] = shuttle

	shuttle = new()
	shuttle.warmup_time = 10
	shuttle.area_offsite = locate(/area/shuttle/mining/outpost)
	shuttle.area_station = locate(/area/shuttle/mining/station)
	made_shuttles["Mining"] = shuttle

	return made_shuttles

/datum/map/aeolus
	name = "Aeolus"
	full_name = "SDEV Aeolus"
	path = "aeolus"

	station_levels = list(1)
	admin_levels = list(1)
	contact_levels = list(1)
	player_levels = list(1)

	shuttle_docked_message = "Spooling complete. The scheduled wave jump will occur in approximately %ETD%. All hands, please prepare for departure."
	shuttle_leaving_dock = "Wave jump initiated. Please do not depart the vessel until the jump is complete. Estimate %ETA% until arrival at %dock_name%."
	shuttle_called_message = "Gravity drive spooling has begun for scheduled wave jump. Estimated completion time is %ETA%."
	shuttle_recall_message = "The scheduled wave jump has been cancelled."
	emergency_shuttle_docked_message = "Emergency gravity drive spooling complete. Emergency jump will occur in approximately %ETD%. All hands, prepare for departure."
	emergency_shuttle_leaving_dock = "Emergency wave jump initiated. Estimate %ETA% until arrival at %dock_name%."
	emergency_shuttle_called_message = "An emergency wave jump has been initiated. This is not a drill. Drive spooling will be complete in approximately %ETA%."
	emergency_shuttle_recall_message = "The emergency wave jump has been cancelled."

	evac_controller_type = /datum/evacuation_controller/pods

/datum/map/aeolus/perform_map_generation()
	return 1

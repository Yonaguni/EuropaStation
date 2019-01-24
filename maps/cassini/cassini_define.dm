/datum/map/cassini
	name = "Cassini"
	station_name = "Cassini"
	full_name = "Cassini"
	path = "cassini"
	lobby_icon = 'maps/cassini/cassini_lobby.dmi'
	lobby_tracks = list()
	station_levels = list(1)
	contact_levels = list(1)
	player_levels = list(1)
	allowed_spawns = list("Arrivals Shuttle")

	shuttle_docked_message = "The shuttle has docked."
	shuttle_leaving_dock = "The shuttle has departed from home dock."
	shuttle_called_message = "A scheduled transfer shuttle has been sent."
	shuttle_recall_message = "The shuttle has been recalled"
	emergency_shuttle_docked_message = "The emergency escape shuttle has docked."
	emergency_shuttle_leaving_dock = "The emergency escape shuttle has departed from %dock_name%."
	emergency_shuttle_called_message = "An emergency escape shuttle has been sent."
	emergency_shuttle_recall_message = "The emergency shuttle has been recalled"

/datum/map/cassini/perform_map_generation()
	new /datum/random_map/noise/seafloor(null, 1, 1, 1, 64, 64)

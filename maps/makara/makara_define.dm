/datum/map/makara
	name = "Makara"
	full_name = "SSV Makara"
	path = "makara"

	admin_levels = list(4)
	station_levels = list(1,2,3)
	contact_levels = list(1,2,3)
	player_levels = list(1,2,3)
	shallow_levels = list(1,2,3)

	test_x = 58
	test_y = 60
	test_z = 2

	evac_controller_type = /datum/evacuation_controller/pods/shuttle
	ambient_exterior_temperature = 110 // -160 degrees celcius (surface temperature of Europa)
	ambient_exterior_light = FALSE

	map_info = "The <b>SSV Makara</b> is a government-owned science vessel operated by the Naval Exploratory Research Division, conducting wide-ranging research patrols of the Europan ocean floor."

	full_name     = "SSV Makara"
	station_short = "Makara"
	dock_name     = "Rhadamanthus"
	boss_name     = "Jovian Navy"
	boss_short    = "Naval Command"
	company_name  = "Naval Exploratory Research Division"
	company_short = "NERD"
	commanding_role = "Captain"
	default_arrival_message = "has begun their watch"

	use_overmap = TRUE

	lobby_music_choices = list(
		/datum/music_track/hottub,
		/datum/music_track/alloveragain,
		/datum/music_track/farasitgets
		)

/datum/map/makara/perform_map_generation()
	map_submerged = TRUE

/datum/map/makara/get_exterior_air()
	return new /datum/gas_mixture

/obj/effect/landmark/map_data/makara
	name = "makara"
	desc = "The outpost and the mining level."
	height = 3

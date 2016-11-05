/datum/map/katydid
	name = "Katydid"
	full_name = "ICV Katydid"
	path = "katydid"

	station_levels = list(1)
	admin_levels = list(2)
	contact_levels = list(1,3)
	player_levels = list(1,3)

	shuttle_docked_message = "Jumpgate control reports that departure can occur in approximately %ETD%. All hands, please prepare for departure."
	shuttle_leaving_dock = "Wave jump initiated. Please do not depart the vessel until the jump is complete. Estimate %ETA% until jump completion and arrival at %dock_name%."
	shuttle_called_message = "Negotiations underway for jumpgate entry. Estimated approval time is %ETA%."
	shuttle_recall_message = "The scheduled wave jump has been cancelled."
	emergency_shuttle_docked_message = "Emergency jumpgate plotting complete. Escape pods prepared. Emergency jump will occur in approximately %ETD%. All hands, prepare for departure."
	emergency_shuttle_leaving_dock = "Emergency wave jump prepared; pods launching. Estimate %ETA% until completion of jump and arrival at %dock_name%."
	emergency_shuttle_called_message = "An emergency wave jump has been initiated and escape pods are being prepped. Preparations will be complete in approximately %ETA%"
	emergency_shuttle_recall_message = "The emergency wave jump has been cancelled."
	evac_controller_type = /datum/evacuation_controller/pods

	var/ship_prefix = "ICV"
	var/ship_name = "Katydid"
	var/datum/trade_destination/destination_location
	var/initial_announcement

	var/list/possible_ship_names = list(
		"Hornet",
		"Witchmoth",
		"Planthopper",
		"Mayfly",
		"Locust",
		"Cicada",
		"Sanddragon",
		"Conehead",
		"Whitetail",
		"Amberwing",
		"Swallowtail",
		"Hawkmoth",
		"Katydid",
		"Longhorn",
		"Luna Moth",
		"Monarch",
		"Mydas",
		"Paperwasp",
		"Treehopper",
		"Sphinxmoth",
		"Leatherwing",
		"Scarab",
		"Ash Borer",
		"Admiral",
		"Emperor",
		"Skipper",
		"Tarantula Hawk",
		"Adder",
		"Bumblebee"
		)

	var/list/possible_ship_prefix = list(
		"SEV",
		"SIC",
		"FTUV",
		"ICV",
		"HMS"
		)

/datum/map/katydid/New()
	. = ..()
	ship_prefix = pick(possible_ship_prefix)
	ship_name =   pick(possible_ship_names)
	full_name = "[ship_prefix] [ship_name]"

/datum/map/katydid/perform_map_generation()
	stellar_location.build_level(3)
	return 1

/datum/map/katydid/update_locations()
	. = ..()
	destination_location = pick(all_trade_destinations - stellar_location)
	if(stellar_location.flavour_locations && stellar_location.flavour_locations.len)
		specific_location = pick(stellar_location.flavour_locations)
		initial_announcement = "Wave jump complete. The SHIPNAME has safely arrived in the vicinity of [specific_location], [stellar_location.is_a_planet ? "orbiting" : "within"] [stellar_location.name]. Gravity drive systems are fully disengaged and all crewmembers are cleared to resume their regular duties."
	else
		specific_location = stellar_location.name
		initial_announcement = "Wave jump complete. The SHIPNAME has safely arrived at [specific_location]. Gravity drive systems are fully disengaged and all crewmembers are cleared to resume their regular duties."

/datum/map/katydid/do_roundstart_intro()
	. = ..()
	if(initial_announcement)
		priority_announcement.Announce(replacetext(initial_announcement, "SHIPNAME", full_name))
	sleep(600)
	if(destination_location)
		priority_announcement.Announce("Vector plotting for scheduled jump complete. Departure for [destination_location.name] will be undertaken in two standard hours.")

/obj/effect/landmark/map_data/katydid
	name = "ICV Katydid"
	desc = "A Free Trade Union freight vessel."
	height = 1

/obj/effect/landmark/map_data/katydid/initialize()
	if(using_map)
		name = using_map.full_name
	. = ..()

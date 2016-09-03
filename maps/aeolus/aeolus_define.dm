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

	evac_controller_type = /datum/evacuation_controller
	var/stellar_location
	var/specific_location

/datum/map/aeolus/perform_map_generation()
	return 1

// These are all either real stellar objects or fictional facilities built on real stellar objects,
// please refer to both Wikipedia and the Europa lore document before adding/removing them.
/datum/map/aeolus/do_roundstart_intro()

	stellar_location = pick("the Kuiper Belt", "the Oort cloud", "the Halo asteroid belt")

	if(stellar_location == "the Oort cloud")
		specific_location = pick(list(
			"Eris",
			"Dysnomia",
			"Hyakutake-2",
			"Hale-Bopp-54",
			"Sedna",
			"2006 SQ372",
			"2008 KV42",
			"2000 CR105"
			))

	else if(stellar_location == "the Kuiper Belt")
		specific_location = pick(list(
			"the Haumea archive",
			"the Makemake Correctional Facility",
			"the ruins of Pluto",
			"Charon",
			"2003 UB",
			"1992 QB1",
			"Orcus",
			"Quaoar",
			"Ixion",
			"Varuna"
			))

	else if(stellar_location == "the Halo asteroid belt")
		specific_location = pick(list(
			"Ceres",
			"Vesta",
			"Pallas",
			"Hygiea",
			"the Gefion family",
			"434 Hungaria",
			"the Phocaea family",
			"the Karin cluster"
			))

	priority_announcement.Announce("Wave jump complete. The [station_name()] has safely arrived in the vicinity of [specific_location], within [stellar_location]. Gravity drive systems are fully disengaged and all crewmembers are cleared to resume their regular duties.")

/obj/effect/landmark/map_data/aeolus
	name = "SDEV Aeolus"
	desc = "A Jovian naval vessel."
	height = 2
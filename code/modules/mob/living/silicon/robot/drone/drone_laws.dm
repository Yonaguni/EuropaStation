/******************** Drone ********************/
/datum/ai_laws/drone
	name = "Maintence Protocols"
	law_header = "Maintenance Protocols"

/datum/ai_laws/drone/New()
	add_inherent_law("Preserve, repair and improve the station to the best of your abilities.")
	add_inherent_law("Cause no harm to the station or anything on it.")
	add_inherent_law("Interact with no being that is not a fellow maintenance drone.")
	..()

/************* Construction *************/

/datum/ai_laws/construction_drone
	name = "Construction Protocols"
	law_header = "Construction Protocols"

/datum/ai_laws/construction_drone/New()
	add_inherent_law("Repair, refit and upgrade your assigned vessel.")
	add_inherent_law("Prevent unplanned damage to your assigned vessel wherever possible.")
	..()

/************* Journalist *************/
/datum/ai_laws/journalist_drone
	name = "Journalist"

/datum/ai_laws/journalist_drone/New()
	src.add_inherent_law("Uncover the truth and share it with the masses!")
	..()


/datum/random_map/structure/ruin
	descriptor = "ruined structure"

/datum/random_map/structure/ruin/apply_to_turf(var/x,var/y)
	var/current_cell = GET_MAP_CELL(x,y)
	if(!current_cell || map[current_cell] == EMPTY_CHAR)
		return
	. = ..()

/datum/random_map/structure/ruin/monolith
	descriptor = "ruined monolith"

/datum/random_map/structure/ruin/spacecraft
	descriptor = "ruined spacecraft"

/datum/random_map/structure/ruin/habitat
	descriptor = "ruined habitat"

/datum/random_map/structure/ruin/industrial
	descriptor = "ruined factory"

/datum/random_map/structure/ruin/science
	descriptor = "ruined facility"

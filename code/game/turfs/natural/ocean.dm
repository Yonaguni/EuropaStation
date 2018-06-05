/turf/simulated/ocean/can_build_cable(var/mob/user)
	return 1

/turf/simulated/ocean
	name = "sea floor"
	desc = "Silty."
	density = 0
	opacity = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	accept_lattice = 1
	blend_with_neighbors = 1
	flooded = 1
	outside = 1
	var/detail_decal

/turf/simulated/ocean/abyss
	name = "abyssal silt"
	desc = "Unfathomably silty."
	icon_state = "mud_light"

/turf/simulated/ocean/abyss/place_critter()
	return

/turf/simulated/ocean/open
	name = "open ocean"
	icon_state = "still"

/turf/simulated/ocean/open/add_decal()
	return 0

/turf/simulated/ocean/return_environment()
	var/datum/gas_mixture/GM = new
	GM.adjust_multi("water", 10000)
	GM.temperature = using_map.ambient_exterior_temperature
	return GM

/turf/simulated/ocean/is_plating()
	return 1

/turf/simulated/ocean/proc/add_decal()
	return prob(20)

/turf/simulated/ocean/Initialize()
	. = ..()
	if(isnull(detail_decal) && add_decal())
		detail_decal = "asteroid[rand(0,9)]"
	place_critter()

/turf/simulated/ocean/proc/place_critter()
	if((z in using_map.player_levels) && prob(0.05)) // please stop spawning carp on the overmap, thanks
		var/critter = using_map.get_minor_critter(0)
		new critter(src)

/turf/simulated/ocean/update_icon(update_neighbors)
	if(detail_decal)
		ADD_MINING_OVERLAY(src, detail_decal, null, null)
	..(update_neighbors)

/turf/simulated/ocean/moving
	name = "open ocean"
	desc = "No bottom in sight."
	icon_state = "moving"

/turf/simulated/ocean/moving/add_decal()
	return 0

/turf/simulated/ocean/moving/place_critter()
	return 0

/turf/simulated/ocean/moving/north
	dir = NORTH

/turf/simulated/ocean/moving/south
	dir = SOUTH

/turf/simulated/ocean/moving/east
	dir = EAST

/turf/simulated/ocean/moving/west
	dir = WEST

/turf/simulated/ocean
	name = "sea floor"
	desc = "Silty."
	density = 0
	opacity = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	accept_lattice = 1
	drop_state = "rockwall"
	blend_with_neighbors = 1
	flooded = 1
	outside = 1
	var/detail_decal

/turf/simulated/ocean/return_environment()
	var/datum/gas_mixture/GM = new
	GM.adjust_multi("water", 10000)
	GM.temperature = using_map.ambient_exterior_temperature
	return GM

/turf/simulated/ocean/is_plating()
	return 1

/turf/simulated/ocean/New()
	..()
	if(isnull(detail_decal) && prob(20))
		detail_decal = "asteroid[rand(0,9)]"

/turf/simulated/ocean/update_icon(var/update_neighbors)
	if(detail_decal)
		..(update_neighbors, list(get_mining_overlay(detail_decal)))
	else
		..(update_neighbors)

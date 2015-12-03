/obj/effect/landmark/map_data/europa
	name = "Yonaguni Dome"
	desc = "The main dome level and the mining abyss level."
	height = 2

/turf/simulated/open/flooded
	name = "abyss"

/turf/simulated/open/flooded/initialize()
	..()
	overlays |= get_ocean_overlay()

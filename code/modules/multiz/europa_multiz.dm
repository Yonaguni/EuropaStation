/obj/effect/landmark/map_data/europa
	name = "Yonaguni Dome"
	desc = "The main dome level, the mining abyss level, the transit level and the surface."
	height = 4

/turf/simulated/open/flooded
	name = "abyss"

/turf/simulated/open/flooded/update_appearance()
	..()
	overlays |= get_ocean_overlay()

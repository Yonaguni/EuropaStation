var/list/shallow_layers = list()

/obj/effect/landmark/map_data/europa
	name = "Yonaguni Dome"
	desc = "The main dome level, the mining abyss level, the transit level and the surface."
	height = 4

/turf/simulated/open/flooded
	name = "abyss"
	drop_state = "rockwall"

/turf/simulated/open/flooded/update_appearance()
	..()
	overlays |= get_ocean_overlay()

// TODO
/proc/layer_is_shallow(var/layer)
	switch(layer)
		if(1)
			return 0
		if(2)
			return 0
		if(3)
			return 0
		if(4)
			return 1
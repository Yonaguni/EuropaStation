/obj/effect/landmark/map_data/europa
	name = "Yonaguni Dome"
	desc = "The main dome level, the mining abyss level, the transit level and the surface."
	height = 4

/turf/simulated/open/flooded
	name = "abyss"
	drop_state = "rockwall"
	flooded = 1

// TODO
var/list/shallow_layers = list()
/proc/layer_is_shallow(var/layer)
	return 0
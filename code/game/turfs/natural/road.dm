/turf/simulated/floor/road
	name = "road"
	desc = "Smells like old rubber and tar."
	density = 0
	opacity = 0
	blocks_air = 0
	icon = 'icons/turf/road.dmi'
	icon_state = "asphalt"
	accept_lattice = 1
	drop_state = "rockwall"
	blend_with_neighbors = -1
	outside = 1

/turf/simulated/floor/road/is_plating()
	return 1

/turf/simulated/floor/road/edge
	icon_state = "road_edge"

/turf/simulated/floor/road/concrete
	name = "concrete"
	icon_state = "concrete"
	blend_with_neighbors = 10

/turf/simulated/floor/road/asphalt
	name = "asphalt"
	blend_with_neighbors = 11

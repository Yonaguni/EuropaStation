var/list/grass_types = list(
	/obj/structure/flora/ausbushes/sparsegrass,
	/obj/structure/flora/ausbushes/fullgrass
	)

var/list/tree_types = list(
	/obj/structure/flora/tree
	)

/turf/simulated/natural
	name = "dirt"
	desc = "Dirty."
	density = 0
	opacity = 0
	blocks_air = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	accept_lattice = 1
	drop_state = "rockwall"
	blend_with_neighbors = 1
	outside = 1

	var/grass_prob = 0
	var/tree_prob = 0

/turf/simulated/natural/is_plating()
	return 1

/turf/simulated/natural/initialize()
	if(grass_prob && prob(grass_prob))
		var/grass_type = pick(grass_types)
		new grass_type(src)
	if(tree_prob && prob(tree_prob))
		var/tree_type = pick(tree_types)
		new tree_type(src)
	return ..()

/turf/simulated/natural/light
	name = "light mud"
	icon_state = "mud_light"
	blend_with_neighbors = 2
	grass_prob = 10

/turf/simulated/natural/dark
	name = "dark mud"
	icon_state = "mud_dark"
	blend_with_neighbors = 3
	grass_prob = 15

/turf/simulated/natural/sand
	name = "sand"
	icon_state = "sand"
	blend_with_neighbors = 4
	grass_prob = 5

/turf/simulated/natural/dirt
	name = "dark dirt"
	icon_state = "dirt-dark"
	blend_with_neighbors = 5

/turf/simulated/natural/grass
	name = "grass"
	icon_state = "grass"
	blend_with_neighbors = 6
	grass_prob = 40
	tree_prob = 3

/turf/simulated/natural/grass/forest
	name = "thick grass"
	icon_state = "grass-dark"
	grass_prob = 80
	tree_prob = 20
	blend_with_neighbors = 8

/turf/simulated/natural/grass/New()
	if(prob(50))
		icon_state += "2"
		blend_with_neighbors++
	..()

/turf/simulated/water
	name = "shallow water"
	icon = 'icons/misc/beach.dmi'
	icon_state = "seashallow"
	blend_with_neighbors = -1

var/obj/effect/ocean/ocean_overlay_img = new()

/obj/effect/ocean
	name = ""
	mouse_opacity = 0
	layer = GAS_OVERLAY_LAYER+0.1
	color = "#66D1FF"
	icon = 'icons/effects/liquids.dmi'
	icon_state = "ocean"
	alpha = GAS_MAX_ALPHA+20
	simulated = 0
	density = 0
	opacity = 0
	anchored = 1

/obj/effect/ocean/ex_act()
	return

/obj/effect/ocean/New()
	..()
	verbs.Cut()

/turf/simulated/ocean
	name = "seafloor"
	desc = "Silty."
	density = 0
	opacity = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	accept_lattice = 1
	drop_state = "rockwall"
	blend_with_neighbors = 1
	flooded = 1

	var/detail_decal

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

var/obj/effect/ocean/ocean_overlay_img = new()

/obj/effect/ocean
	name = ""
	mouse_opacity = 0
	layer = GAS_OVERLAY_LAYER+0.1
	color = "#66D1FF"
	icon = 'icons/effects/xgm_overlays.dmi'
	icon_state = "ocean"
	alpha = GAS_MAX_ALPHA
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
	blocks_air = 1
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	accept_lattice = 1
	drop_state = "rockwall"
	flooded = 1
	blend_with_neighbors = 1
	var/detail_decal

/turf/simulated/ocean/is_plating()
	return 1

/turf/simulated/ocean/New()
	if(isnull(detail_decal) && prob(20))
		detail_decal = "asteroid[rand(0,9)]"
	if(ticker && ticker.current_state == GAME_STATE_PLAYING)
		initialize()
	else
		init_turfs |= src
	..()

/turf/simulated/ocean/update_icon(var/update_neighbors)
	overlays.Cut()
	if(detail_decal)
		overlays |= get_mining_overlay(detail_decal)
	..(update_neighbors)

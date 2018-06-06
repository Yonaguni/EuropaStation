/turf/simulated/mineral //wall piece
	name = "rock"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock"
	opacity = 1
	density = 1
	blend_with_neighbors = 15 // Blend over MOST THINGS.

	var/material/mineral
	var/sand_dug
	var/overlay_detail
	var/being_dug

/turf/simulated/mineral/Initialize()
	. = ..()
	if(!istype(mineral) && !isnull(mineral))
		mineral = SSmaterials.get_material(mineral)
	if(prob(20))
		overlay_detail = "asteroid[rand(0,9)]"
	queue_icon_update(1)

/turf/simulated/mineral/attackby(var/obj/item/thing, var/mob/user)

	if(being_dug || (!density && sand_dug))
		return ..()

	if(!istype(thing, /obj/item/pickaxe))
		return

	var/obj/item/pickaxe/P = thing

	if((density && !P.dig_rock) || (!density && !P.dig_sand))
		return

	playsound(src, P.drill_sound, 100, 1)
	being_dug = TRUE
	user.visible_message("<span class='notice'>\The [user] begins [P.drill_verb] into \the [src].</span>")

	var/dig_delay = P.digspeed
	if(HAS_ASPECT(user, ASPECT_GROUNDBREAKER))
		dig_delay = max(5, Floor(dig_delay * 0.5))

	if(do_after(user, dig_delay, src))
		if(density)
			user.visible_message("<span class='notice'>\The [user] finishes [P.drill_verb] \the [src].</span>")
			DROP_ORE(src)
			MAKE_FLOOR(src)
		else
			user.visible_message("<span class='notice'>\The [user] finishes [P.drill_verb] a hole in \the [src].</span>")
			DROP_SAND(src)
	being_dug = FALSE

/turf/simulated/mineral/ex_act(var/severity)
	if(prob(133 - (severity * 33))) // 33% per degree of badness.
		if(density)
			DROP_ORE(src)
			MAKE_FLOOR(src)
		else
			DROP_SAND(src)

/turf/simulated/mineral/Bumped(var/atom/movable/AM)
	. = ..()
	var/mob/living/M = AM
	if(istype(M))
		var/obj/item/W = M.get_active_hand()
		if(istype(W, /obj/item/pickaxe) || istype(W, /obj/item/storage/ore))
			attackby(W, M)
			return
		W = M.get_inactive_hand()
		if(istype(W, /obj/item/pickaxe) || istype(W, /obj/item/storage/ore))
			attackby(W, M)
			return
		var/obj/item/rig/rig = M.get_rig()
		if(rig && istype(rig.selected_module, /obj/item/rig_module/device/plasmacutter))
			M.HardsuitClickOn(src)

/turf/simulated/mineral/can_build_cable()
	return !density

/turf/simulated/mineral/is_plating()
	return !density

/turf/simulated/mineral/floor
	name = "sand"
	icon = 'icons/turf/flooring/asteroid.dmi'
	icon_state = "asteroid"
	density = 0
	opacity = 0
	blend_with_neighbors = 4
	accept_lattice = 1
	explosion_resistance = 2

/turf/simulated/mineral/flooded
	color = COLOR_BLUE

/turf/simulated/mineral/floor/flooded
	color = COLOR_BLUE

/turf/simulated/mineral/can_build_cable()
	return !density

/turf/simulated/mineral/is_plating()
	return 1

/turf/simulated/mineral/update_icon(var/update_neighbors)
	color = null
	cut_overlays()
	if(density)
		icon = 'icons/turf/walls.dmi'
		icon_state = "rock"
		blend_with_neighbors = 15
		if(istype(mineral))
			name = "[mineral.ore_name] deposit"
			if(mineral.ore_overlay)
				ADD_MINING_OVERLAY(src, mineral.ore_overlay, null, mineral.icon_colour)
		else
			name = "rock"
	else
		name = "sand"
		icon = 'icons/turf/flooring/asteroid.dmi'
		icon_state = "asteroid"
		blend_with_neighbors = 4
		if(sand_dug)
			ADD_MINING_OVERLAY(src, "dug_overlay", null, null)
		for(var/direction in cardinal)
			var/turf/T = get_step(src, direction)
			if(istype(T) && T.open_space)
				ADD_MINING_OVERLAY(src, "edges", direction, null)
		if(overlay_detail)
			ADD_MINING_OVERLAY(src, overlay_detail, null, null)
	..(update_neighbors)

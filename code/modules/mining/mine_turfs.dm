var/list/mining_overlays = list()

proc/get_mining_overlay(var/overlay_key)
	if(!mining_overlays[overlay_key])
		mining_overlays[overlay_key] = image('icons/turf/flooring/decals.dmi',overlay_key)
	return mining_overlays[overlay_key]

/**********************Mineral deposits**************************/
/turf/unsimulated/mineral
	name = "impassable rock"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock-dark"
	density = 1
	opacity = 1
	blocks_air = 1

/turf/simulated/mineral //wall piece
	name = "rock"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock"
	opacity = 1
	density = 1
	blocks_air = 1
	temperature = T0C
	has_resources = 1

	var/ore/mineral
	var/sand_dug
	var/mined_ore = 0
	var/last_act = 0
	var/overlay_detail
	var/ignore_mapgen

/turf/simulated/mineral/ignore_mapgen
	ignore_mapgen = 1

/turf/simulated/mineral/floor
	name = "sand"
	icon = 'icons/turf/flooring/asteroid.dmi'
	icon_state = "asteroid"
	density = 0
	opacity = 0
	blocks_air = 0

/turf/simulated/mineral/floor/ignore_mapgen
	ignore_mapgen = 1

/turf/simulated/mineral/proc/make_floor()
	if(!density && !opacity)
		return
	density = 0
	opacity = 0
	blocks_air = 0
	update_general()

/turf/simulated/mineral/proc/make_wall()
	if(density && opacity)
		return
	density = 1
	opacity = 1
	blocks_air = 1
	update_general()

/turf/simulated/mineral/proc/update_general()
	update_icon(1)
	if(ticker && ticker.current_state == GAME_STATE_PLAYING)
		reconsider_lights()
		if(air_master) air_master.add_to_active(src)

/turf/simulated/mineral/Entered(atom/movable/M as mob|obj)
	. = ..()
	if(istype(M,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = M
		if(R.module)
			if(istype(R.module_state_1,/obj/item/weapon/storage/bag/ore))
				attackby(R.module_state_1,R)
			else if(istype(R.module_state_2,/obj/item/weapon/storage/bag/ore))
				attackby(R.module_state_2,R)
			else if(istype(R.module_state_3,/obj/item/weapon/storage/bag/ore))
				attackby(R.module_state_3,R)
			else
				return

/turf/simulated/mineral/initialize()
	if(prob(20))
		overlay_detail = "asteroid[rand(0,9)]"
	if(density)
		spawn(0)
			MineralSpread()
	update_icon(1)

/turf/simulated/mineral/update_icon(var/update_neighbors)

	overlays.Cut()
	var/list/step_overlays = list("n" = NORTH, "s" = SOUTH, "e" = EAST, "w" = WEST)

	if(density)
		if(mineral)
			name = "[mineral.display_name] deposit"
		else
			name = "rock"

		icon = 'icons/turf/walls.dmi'
		icon_state = "rock"

		for(var/direction in step_overlays)
			var/turf/T = get_step(src,step_overlays[direction])
			if(istype(T) && !T.density)
				T.overlays += image('icons/turf/walls.dmi', "rock_side", dir = turn(step_overlays[direction], 180))
	else

		name = "sand"
		icon = 'icons/turf/flooring/asteroid.dmi'
		icon_state = "asteroid"

		if(sand_dug)
			overlays += image('icons/turf/flooring/asteroid.dmi', "dug_overlay")

		for(var/direction in step_overlays)
			if(istype(get_step(src, step_overlays[direction]), /turf/space))
				overlays += image('icons/turf/flooring/asteroid.dmi', "asteroid_edges", dir = step_overlays[direction])
			else
				var/turf/simulated/mineral/M = get_step(src, step_overlays[direction])
				if(istype(M) && M.density)
					overlays += image('icons/turf/walls.dmi', "rock_side", dir = step_overlays[direction])

		if(overlay_detail)
			overlays |= image(icon = 'icons/turf/flooring/decals.dmi', icon_state = overlay_detail)

		if(update_neighbors)
			var/list/all_step_directions = list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
			for(var/direction in all_step_directions)
				if(istype(get_step(src, direction), /turf/simulated/mineral))
					var/turf/simulated/mineral/M = get_step(src, direction)
					M.update_icon()

/turf/simulated/mineral/ex_act(severity)

	switch(severity)
		if(2.0)
			if (prob(70))
				mined_ore = 1 //some of the stuff gets blown up
				GetDrilled()
		if(1.0)
			mined_ore = 2 //some of the stuff gets blown up
			GetDrilled()

/turf/simulated/mineral/Bumped(AM)

	. = ..()

	if(!density)
		return .

	if(istype(AM,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = AM
		if((istype(H.l_hand,/obj/item/weapon/pickaxe)) && (!H.hand))
			attackby(H.l_hand,H)
		else if((istype(H.r_hand,/obj/item/weapon/pickaxe)) && H.hand)
			attackby(H.r_hand,H)

	else if(istype(AM,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = AM
		if(istype(R.module_active,/obj/item/weapon/pickaxe))
			attackby(R.module_active,R)

/turf/simulated/mineral/proc/MineralSpread()
	if(mineral && mineral.spread)
		for(var/trydir in cardinal)
			if(prob(mineral.spread_chance))
				var/turf/simulated/mineral/target_turf = get_step(src, trydir)
				if(istype(target_turf) && target_turf.density && !target_turf.mineral)
					target_turf.mineral = mineral
					target_turf.UpdateMineral()
					target_turf.MineralSpread()


/turf/simulated/mineral/proc/UpdateMineral()
	clear_ore_effects()
	if(mineral)
		new /obj/effect/mineral(src, mineral)
	update_icon()

/turf/simulated/mineral/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return

	if(!density)

		var/list/usable_tools = list(
			/obj/item/weapon/shovel,
			/obj/item/weapon/pickaxe/diamonddrill,
			/obj/item/weapon/pickaxe/drill,
			/obj/item/weapon/pickaxe/borgdrill
			)

		var/valid_tool
		for(var/valid_type in usable_tools)
			if(istype(W,valid_type))
				valid_tool = 1
				break

		if(valid_tool)
			if (sand_dug)
				user << "<span class='warning'>This area has already been dug.</span>"
				return

			var/turf/T = user.loc
			if (!(istype(T)))
				return

			user << "<span class='notice'>You start digging.</span>"
			playsound(user.loc, 'sound/effects/rustle1.ogg', 50, 1)

			if(!do_after(user,40)) return

			user << "<span class='notice'>You dug a hole.</span>"
			GetDrilled()
	else

		if (istype(W, /obj/item/weapon/pickaxe))
			var/turf/T = user.loc
			if (!( istype(T, /turf) ))
				return
			var/obj/item/weapon/pickaxe/P = W
			if(last_act + P.digspeed > world.time)//prevents message spam
				return
			last_act = world.time
			playsound(user, P.drill_sound, 20, 1)
			user << "<span class='notice'>You start [P.drill_verb].</span>"
			if(do_after(user,P.digspeed))
				user << "<span class='notice'>You finish [P.drill_verb] \the [src].</span>"
			GetDrilled()
			return

	return attack_hand(user)

/turf/simulated/mineral/proc/clear_ore_effects()
	for(var/obj/effect/mineral/M in contents)
		qdel(M)

/turf/simulated/mineral/proc/DropMineral()
	if(!mineral)
		return
	clear_ore_effects()
	var/obj/item/weapon/ore/O = new mineral.ore (src)
	return O

/turf/simulated/mineral/proc/GetDrilled(var/artifact_fail = 0)

	if(!density)
		if(!sand_dug)
			sand_dug = 1
			for(var/i=0;i<(rand(3)+2);i++)
				new/obj/item/weapon/ore/glass(src)
			update_icon()
		return

	if (mineral && mineral.result_amount)
		for (var/i = 1 to mineral.result_amount - mined_ore)
			DropMineral()

	// Kill and update the space overlays around us.
	var/list/step_overlays = list("n" = NORTH, "s" = SOUTH, "e" = EAST, "w" = WEST)
	for(var/direction in step_overlays)
		var/turf/space/T = get_step(src, step_overlays[direction])
		if(istype(T))
			T.overlays.Cut()
			for(var/next_direction in step_overlays)
				if(istype(get_step(T, step_overlays[next_direction]),/turf/simulated/mineral))
					T.overlays += image('icons/turf/walls.dmi', "rock_side", dir = step_overlays[next_direction])

	make_floor()

/turf/simulated/mineral/proc/make_ore(var/rare_ore)
	if(mineral)
		return

	var/mineral_name
	if(rare_ore)
		mineral_name = pickweight(list("Uranium" = 10, "Platinum" = 10, "Iron" = 20, "Coal" = 20, "Diamond" = 2, "Gold" = 10, "Silver" = 10, "Phoron" = 20))
	else
		mineral_name = pickweight(list("Uranium" = 5, "Platinum" = 5, "Iron" = 35, "Coal" = 35, "Diamond" = 1, "Gold" = 5, "Silver" = 5, "Phoron" = 10))
	mineral_name = lowertext(mineral_name)
	if(mineral_name && (mineral_name in ore_data))
		mineral = ore_data[mineral_name]
		UpdateMineral()
	update_icon()

/* EUROPA MINING LEVEL SHIT - this is a hackfix for the level,
        DO NOT LEAVE THIS INDEFINITELY, ZUHAYR. */
/turf/simulated/mineral/var/flooded
/turf/simulated/mineral/var/datum/gas_mixture/water
/turf/simulated/mineral/flooded/flooded = 1
/turf/simulated/mineral/floor/flooded/flooded = 1

/turf/simulated/mineral/update_icon(var/update_neighbors)
	..()
	if(flooded)
		overlays += get_ocean_overlay()

/turf/simulated/mineral/is_flooded()
	return flooded

/turf/simulated/mineral/return_air()
	if(!flooded)
		return ..()
	if(!water)
		water = new/datum/gas_mixture      // Make our 'air', freezing water.
		water.temperature = 250            // -24C
		water.adjust_gas("water", 1500, 1) // Should be higher.
		water.volume = CELL_VOLUME
	var/datum/gas_mixture/infiniwater = new()
	infiniwater.copy_from(water)
	return infiniwater

/turf/simulated/mineral/get_fluid_depth()
	return flooded ? 1200 : ..()

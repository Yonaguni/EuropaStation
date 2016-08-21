/turf
	var/air_pressure_difference = 0
	var/air_pressure_direction = 0
	var/atmos_adjacent_turfs = 0
	var/atmos_adjacent_turfs_amount = 0
	var/needs_air_update
	var/obj/effect/gas_overlay/gas_overlay

/turf/simulated
	var/air_recently_active = 0
	var/air_archived_cycle = 0
	var/air_current_cycle = 0
	var/datum/gas_mixture/air
	var/list/initial_air

/turf/assume_air(datum/gas_mixture/giver) //use this for machines to adjust air
	return 0

/turf/return_air()
	if(is_flooded(absolute=1))
		return
	var/datum/gas_mixture/GM = new
	GM.adjust_multi(REAGENT_ID_OXYGEN, MOLES_O2STANDARD, REAGENT_ID_NITROGEN, MOLES_N2STANDARD)
	GM.volume = CELL_VOLUME
	return GM

/turf/remove_air(amount as num)
	return

/turf/simulated/assume_air(datum/gas_mixture/giver)
	if(is_flooded(absolute=1))
		return
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()
	my_air.merge(giver)
	if(my_air.check_tile_graphic())
		update_visuals_air(my_air)

/turf/simulated/remove_air(amount as num)
	if(is_flooded(absolute=1))
		return
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()
	var/returnval = my_air.remove(amount)
	if(my_air.check_tile_graphic())
		update_visuals_air(my_air)
	return returnval

/turf/simulated/return_air()
	if(is_flooded(absolute=1))
		return
	if(!air)
		make_air()
	return air

/turf/proc/make_air()
	return

/turf/simulated/make_air(var/override_mix, var/override_volume, var/override_temp)
	if(is_flooded(absolute=1))
		return
	air = new/datum/gas_mixture
	if(!override_mix)
		if(initial_air && islist(initial_air))
			for(var/gastype in initial_air)
				air.adjust_gas(gastype, initial_air[gastype])
		else
			air.adjust_multi(REAGENT_ID_OXYGEN, MOLES_O2STANDARD, REAGENT_ID_NITROGEN, MOLES_N2STANDARD)
	air.volume =      (isnull(override_volume) ? CELL_VOLUME : override_volume)
	update_visuals_air(air)
	if(air_master)
		air_master.add_to_active(src)

/turf/simulated/initialize()
	..()
	if(!is_flooded(absolute=1) && !blocks_air && initial_air && initial_air.len)
		make_air()
		air_update_turf(1)

/turf/simulated/assume_air(datum/gas_mixture/giver)
	if(is_flooded(absolute=1))
		return
	if(!giver)	return 0
	var/datum/gas_mixture/receiver = air
	if(istype(receiver))
		air.merge(giver)
		if(air.check_tile_graphic())
			update_visuals_air(air)
		return 1
	else return ..()

/turf/simulated/proc/process_cell()
	if(!air_master)
		return

	if(is_flooded(absolute=1))
		air_master.active_turfs -= src
		return

	if(air_archived_cycle < air_master.current_cycle) //archive self if not already done
		archive_air()
	air_current_cycle = air_master.current_cycle

	var/remove = 1 //set by non simulated turfs who are sharing with this turf

	for(var/direction in atmos_dirs)
		if(!(atmos_adjacent_turfs & direction))
			continue

		var/turf/enemy_tile = get_step(src, direction)

		if(istype(enemy_tile,/turf/simulated))
			var/turf/simulated/enemy_simulated = enemy_tile

			if(!enemy_simulated.air)
				enemy_simulated.make_air()

			if(!enemy_simulated.air)
				continue

			if(air_current_cycle > enemy_simulated.air_current_cycle)
				enemy_simulated.archive_air()

			if(!air)
				make_air()
			if(air && !air.compare(enemy_simulated.air)) //compare if
				air_master.add_to_active(enemy_simulated) //excite enemy
				share_air(enemy_simulated) //share

			if(remove && !air.check_turf_air(enemy_tile, atmos_adjacent_turfs_amount))
				var/difference = air.mimic(enemy_tile,,atmos_adjacent_turfs_amount)
				if(difference)
					if(difference > 0)
						consider_pressure_difference(enemy_tile, difference)
					else
						enemy_tile.consider_pressure_difference(src, difference)
				remove = 0

	if(air && air.check_tile_graphic())
		update_visuals_air(air)

	if(remove == 1)
		air_master.active_turfs -= src

/turf/simulated/proc/archive_air()
	if(!air_master)
		return
	if(air) air.archive()
	air_archived_cycle = air_master.current_cycle

/turf/simulated/proc/update_visuals_air(var/datum/gas_mixture/model)
	if(!air_master)
		return 0
	if(gas_overlay)
		gas_overlay.overlays.Cut()
	if(model.graphic.len)
		if(!gas_overlay)
			gas_overlay = new /obj/effect/gas_overlay(src)
		for(var/gas_icon in model.graphic)
			gas_overlay.overlays |= gas_icon
	if(gas_overlay)
		gas_overlay.alpha = model.graphic_alpha
	update_icon()
	return 1

/turf/simulated/proc/share_air(var/turf/simulated/T)
	if(is_flooded(absolute=1))
		return
	if(T.air_current_cycle >= air_current_cycle)
		return
	var/difference
	difference = air.share(T.air, atmos_adjacent_turfs_amount)
	if(difference)
		if(difference > 0)
			consider_pressure_difference(T, difference)
		else
			T.consider_pressure_difference(src, difference)

/turf/proc/consider_pressure_difference(var/turf/simulated/T, var/difference)
	if(is_flooded(absolute=1) || !air_master)
		return
	air_master.high_pressure_delta |= src
	if(difference > air_pressure_difference)
		air_pressure_direction = get_dir(src, T)
		air_pressure_difference = difference

/turf/proc/high_pressure_movements()
	for(var/atom/movable/M in src)
		M.experience_pressure_difference(air_pressure_difference, air_pressure_direction)

/turf/proc/CalculateAdjacentTurfs()
	atmos_adjacent_turfs_amount = 0
	for(var/direction in atmos_dirs)
		var/turf/T = get_step(src, direction)
		if(!istype(T))
			continue
		var/counterdir = get_dir(T, src)
		if(CanAtmosPass(T))
			atmos_adjacent_turfs_amount += 1
			atmos_adjacent_turfs |= direction
			if(!(T.atmos_adjacent_turfs & counterdir))
				T.atmos_adjacent_turfs_amount += 1
			T.atmos_adjacent_turfs |= counterdir
		else
			atmos_adjacent_turfs &= ~direction
			if(T.atmos_adjacent_turfs & counterdir)
				T.atmos_adjacent_turfs_amount -= 1
			T.atmos_adjacent_turfs &= ~counterdir

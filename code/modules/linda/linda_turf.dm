/turf
	var/air_pressure_difference = 0
	var/air_pressure_direction = 0
	var/atmos_adjacent_turfs = 0
	var/atmos_adjacent_turfs_amount = 0
	var/needs_air_update

/turf/simulated
	var/air_recently_active = 0
	var/air_archived_cycle = 0
	var/air_current_cycle = 0

	var/datum/gas_mixture/air
	var/obj/effect/hotspot/active_hotspot
	var/temperature_archived //USED ONLY FOR SOLIDS
	var/list/initial_air
	var/initial_temperature = T20C

/turf/assume_air(datum/gas_mixture/giver) //use this for machines to adjust air
	return 0

/turf/proc/assume_gas(gasid, moles, temp = 0)
	return 0

/turf/return_air()
	var/datum/gas_mixture/GM = new
	GM.adjust_multi("oxygen", MOLES_O2STANDARD, "nitrogen", MOLES_N2STANDARD)
	GM.temperature = T20C
	GM.volume = CELL_VOLUME
	return GM

/turf/remove_air(amount as num)
	return

/turf/simulated/assume_air(datum/gas_mixture/giver)
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()
	my_air.merge(giver)
	if(my_air.check_tile_graphic())
		update_visuals(my_air)

/turf/simulated/assume_gas(gasid, moles, temp = null)
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()

	if(isnull(temp))
		my_air.adjust_gas(gasid, moles)
	else
		my_air.adjust_gas_temp(gasid, moles, temp)
	if(my_air.check_tile_graphic())
		update_visuals(my_air)
	return 1

/turf/simulated/remove_air(amount as num)
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()
	var/returnval = my_air.remove(amount)
	if(my_air.check_tile_graphic())
		update_visuals(my_air)
	return returnval

/turf/simulated/return_air()
	if(!air)
		make_air()
	return air

/turf/proc/make_air()
	return

/turf/simulated/make_air(var/override_mix, var/override_volume, var/override_temp)
	air = new/datum/gas_mixture
	if(!override_mix)
		if(initial_air && islist(initial_air))
			for(var/gastype in initial_air)
				air.adjust_gas(gastype, initial_air[gastype])
		else
			air.adjust_multi("oxygen", MOLES_O2STANDARD, "nitrogen", MOLES_N2STANDARD)
	air.temperature = (isnull(override_temp) ? initial_temperature : override_temp)
	air.volume =      (isnull(override_volume) ? CELL_VOLUME : override_volume)
	update_visuals(air)
	if(air_master)
		air_master.add_to_active(src)

/turf/simulated/initialize()
	..()
	if(!blocks_air)
		make_air()
	air_update_turf(1)

/turf/simulated/Destroy()
	if(active_hotspot)
		qdel(active_hotspot)
	return ..()

/turf/simulated/assume_air(datum/gas_mixture/giver)
	if(!giver)	return 0
	var/datum/gas_mixture/receiver = air
	if(istype(receiver))
		air.merge(giver)
		if(air.check_tile_graphic())
			update_visuals(air)
		return 1
	else return ..()

turf/simulated/proc/mimic_temperature_solid(turf/model, conduction_coefficient)
	var/delta_temperature = (temperature_archived - model.temperature)
	if((heat_capacity > 0) && (abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER))

		var/heat = conduction_coefficient*delta_temperature* \
			(heat_capacity*model.heat_capacity/(heat_capacity+model.heat_capacity))
		temperature -= heat/heat_capacity

turf/simulated/proc/share_temperature_mutual_solid(turf/simulated/sharer, conduction_coefficient)
	var/delta_temperature = (temperature_archived - sharer.temperature_archived)
	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER && heat_capacity && sharer.heat_capacity)

		var/heat = conduction_coefficient*delta_temperature* \
			(heat_capacity*sharer.heat_capacity/(heat_capacity+sharer.heat_capacity))

		temperature -= heat/heat_capacity
		sharer.temperature += heat/sharer.heat_capacity

/turf/simulated/proc/process_cell()
	if(!air_master)
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

			if(air_current_cycle > enemy_simulated.air_current_cycle)
				enemy_simulated.archive_air()

			if(!air.compare(enemy_simulated.air)) //compare if
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
	if(air)
		air.react()
		if(air.temperature > FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
			hotspot_expose(air.temperature, CELL_VOLUME)
			for(var/atom/movable/item in src)
				item.temperature_expose(air, air.temperature, CELL_VOLUME)
			temperature_expose(air, air.temperature, CELL_VOLUME)
		if(air.check_tile_graphic())
			update_visuals(air)

	if(remove == 1)
		air_master.active_turfs -= src

/turf/simulated/proc/archive_air()
	if(!air_master)
		return
	if(air) //For open space like floors
		air.archive()
	temperature_archived = temperature
	air_archived_cycle = air_master.current_cycle

/turf/simulated/proc/update_visuals(var/datum/gas_mixture/model)
	if(!air_master)
		return 0
	if(gas_overlay)
		gas_overlay.overlays.Cut()
	if(model.graphic.len)
		if(!gas_overlay)
			gas_overlay = PoolOrNew(/obj/effect/gas_overlay,src)
		for(var/gas_icon in model.graphic)
			gas_overlay.overlays |= gas_icon
	if(gas_overlay && !isnull(model.graphic_alpha) && gas_overlay.alpha != model.graphic_alpha)
		gas_overlay.alpha = model.graphic_alpha
	update_icon()
	return 1

/turf/simulated/proc/share_air(var/turf/simulated/T)
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
	if(!air_master)
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

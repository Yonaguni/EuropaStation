/turf
	var/pressure_difference = 0
	var/pressure_direction = 0
	var/atmos_adjacent_turfs = 0
	var/atmos_adjacent_turfs_amount = 0
	var/atmos_supeconductivity = 0
	var/needs_air_update

/turf/simulated
	var/excited = 0
	var/recently_active = 0
	var/datum/gas_mixture/air
	var/archived_cycle = 0
	var/current_cycle = 0
	var/obj/effect/hotspot/active_hotspot
	var/temperature_archived //USED ONLY FOR SOLIDS
	var/open_directions
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
	make_air()

/turf/simulated/New()
	..()
	if(!blocks_air)
		make_air()
	if(initial_air)
		if(ticker && ticker.current_state == GAME_STATE_PLAYING)
			initialize()
		else
			init_turfs += src

/turf/simulated/Destroy()
	if(active_hotspot)
		qdel(active_hotspot)
	..()

/turf/simulated/assume_air(datum/gas_mixture/giver)
	if(!giver)	return 0
	var/datum/gas_mixture/receiver = air
	if(istype(receiver))
		air.merge(giver)
		if(air.check_tile_graphic())
			update_visuals(air)
		return 1
	else return ..()

turf/simulated/proc/copy_air_with_tile(turf/simulated/T)
	if(istype(T) && T.air && air)
		air.copy_from(T.air)

turf/simulated/proc/copy_air(datum/gas_mixture/copy)
	if(air && copy)
		air.copy_from(copy)

turf/simulated/return_air()
	if(air)
		return air

	else
		return ..()

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
	if(archived_cycle < air_master.current_cycle) //archive self if not already done
		archive()
	current_cycle = air_master.current_cycle

	var/remove = 1 //set by non simulated turfs who are sharing with this turf

	// Check if we are moving gas up or down.
	var/list/extradirs = list()
	if(istype(GetAbove(src), /turf/simulated/open))
		extradirs += UP
	if(istype(src, /turf/simulated/open))
		extradirs += DOWN

	for(var/direction in (cardinal+extradirs))
		if(!(atmos_adjacent_turfs & direction))
			continue

		var/turf/enemy_tile = get_step(src, direction)

		if(istype(enemy_tile,/turf/simulated))
			var/turf/simulated/enemy_simulated = enemy_tile

			if(current_cycle > enemy_simulated.current_cycle)
				enemy_simulated.archive()

			if(!air.compare(enemy_simulated.air)) //compare if
				air_master.add_to_active(enemy_simulated) //excite enemy
				share_air(enemy_simulated) //share
		else
			if(!air.check_turf(enemy_tile, atmos_adjacent_turfs_amount))
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
			if(air.temperature > MINIMUM_TEMPERATURE_START_SUPERCONDUCTION)
				if(consider_superconductivity(starting = 1))
					remove = 0
		if(air.check_tile_graphic())
			update_visuals(air)

	if(remove == 1)
		air_master.remove_from_active(src)

/turf/simulated/proc/archive()
	if(!air_master)
		return
	if(air) //For open space like floors
		air.archive()
	temperature_archived = temperature
	archived_cycle = air_master.current_cycle

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
	if(T.current_cycle < current_cycle)
		var/difference
		difference = air.share(T.air, atmos_adjacent_turfs_amount)
		if(difference)
			if(difference > 0)
				consider_pressure_difference(T, difference)
			else
				T.consider_pressure_difference(src, difference)
		last_share_check()

/turf/proc/consider_pressure_difference(var/turf/simulated/T, var/difference)
	if(!air_master)
		return
	air_master.high_pressure_delta |= src
	if(difference > pressure_difference)
		pressure_direction = get_dir(src, T)
		pressure_difference = difference

/turf/simulated/proc/last_share_check()
	return

/turf/proc/high_pressure_movements()
	for(var/atom/movable/M in src)
		M.experience_pressure_difference(pressure_difference, pressure_direction)

/atom/movable/var/last_forced_movement = 0

/turf/simulated/proc/super_conduct()
	if(!air_master)
		return
	var/conductivity_directions = 0

	// TODO make this a set of turf vars
	// Check if we are moving gas up or down.
	var/list/extradirs = list()
	if(istype(GetAbove(src), /turf/simulated/open))
		extradirs += UP
	if(istype(src, /turf/simulated/open))
		extradirs += DOWN

	if(blocks_air)
		//Does not participate in air exchange, so will conduct heat across all four borders at this time
		conductivity_directions = NORTH|SOUTH|EAST|WEST

		if(archived_cycle < air_master.current_cycle)
			archive()
	else
		//Does particate in air exchange so only consider directions not considered during process_cell()
		for(var/direction in (cardinal+extradirs))
			if(!(atmos_adjacent_turfs & direction) && !(atmos_supeconductivity & direction))
				conductivity_directions += direction

	if(conductivity_directions>0)
		//Conduct with tiles around me
		for(var/direction in (cardinal+extradirs))
			if(conductivity_directions&direction)
				var/turf/neighbor = get_step(src,direction)

				if(!neighbor.thermal_conductivity)
					continue

				if(istype(neighbor, /turf/simulated)) //anything under this subtype will share in the exchange
					var/turf/simulated/T = neighbor

					if(T.archived_cycle < air_master.current_cycle)
						T.archive()

					if(T.air)
						if(air) //Both tiles are open
							air.temperature_share(T.air, WINDOW_HEAT_TRANSFER_COEFFICIENT)
						else //Solid but neighbor is open
							T.air.temperature_turf_share(src, T.thermal_conductivity)
						air_master.add_to_active(T, 0)
					else
						if(air) //Open but neighbor is solid
							air.temperature_turf_share(T, T.thermal_conductivity)
						else //Both tiles are solid
							share_temperature_mutual_solid(T, T.thermal_conductivity)
						T.temperature_expose(null, T.temperature, null)

					T.consider_superconductivity()

				else
					if(air) //Open
						air.temperature_mimic(neighbor, neighbor.thermal_conductivity)
					else
						mimic_temperature_solid(neighbor, neighbor.thermal_conductivity)

	if(temperature > T0C) //Considering 0 degC as te break even point for radiation in and out
		var/delta_temperature = (temperature_archived - 2.7) //hardcoded space temperature
		if((heat_capacity > 0) && (abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER))

			var/heat = thermal_conductivity*delta_temperature* \
				(heat_capacity*700000/(heat_capacity+700000)) //700000 is the heat_capacity from a space turf, hardcoded here
			temperature -= heat/heat_capacity

	//Conduct with air on my tile if I have it
	if(air)
		air.temperature_turf_share(src, thermal_conductivity)

		//Make sure still hot enough to continue conducting heat
		if(air.temperature < MINIMUM_TEMPERATURE_FOR_SUPERCONDUCTION)
			air_master.active_super_conductivity -= src
			return 0

	else
		if(temperature < MINIMUM_TEMPERATURE_FOR_SUPERCONDUCTION)
			air_master.active_super_conductivity -= src
			return 0

turf/simulated/proc/consider_superconductivity(starting)
	if(!thermal_conductivity)
		return 0

	if(air)
		if(air.temperature < (starting?MINIMUM_TEMPERATURE_START_SUPERCONDUCTION:MINIMUM_TEMPERATURE_FOR_SUPERCONDUCTION))
			return 0
		if(air.heat_capacity() < M_CELL_WITH_RATIO) // Was: MOLES_CELLSTANDARD*0.1*0.05 Since there are no variables here we can make this a constant.
			return 0
	else
		if(temperature < (starting?MINIMUM_TEMPERATURE_START_SUPERCONDUCTION:MINIMUM_TEMPERATURE_FOR_SUPERCONDUCTION))
			return 0

	air_master.active_super_conductivity |= src
	return 1

/turf/proc/CalculateAdjacentTurfs()

	var/list/extradirs = list()
	if(istype(GetAbove(src), /turf/simulated/open))
		extradirs += UP
	if(istype(src, /turf/simulated/open))
		extradirs += DOWN

	atmos_adjacent_turfs_amount = 0
	for(var/direction in (cardinal+extradirs))
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

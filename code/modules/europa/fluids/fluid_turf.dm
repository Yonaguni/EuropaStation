/turf
	var/need_fluid_recalc = 0
	var/fluid_adjacent_turfs = 0
	var/fluid_adjacent_turfs_amount = 0

/turf/simulated
	var/datum/gas_mixture/fluid/fluids
	var/fluid_recently_active = 0
	var/fluid_archived_cycle = 0
	var/fluid_current_cycle = 0

/turf/simulated/proc/archive_fluids()
	if(!fluid_master)
		return
	if(fluids)
		fluids.archive()
	temperature_archived = temperature
	fluid_archived_cycle = fluid_master.current_cycle

/turf/proc/assume_fluids()
	return

/turf/simulated/assume_fluids(datum/gas_mixture/giver)
	if(flooded)
		return
	fluid_update_turf(1)
	var/datum/gas_mixture/fluid/my_fluid = return_fluids()
	my_fluid.merge(giver)
	if(my_fluid.check_tile_graphic())
		update_visuals(my_fluid)

/turf/simulated/assume_fluid(gasid, moles, temp = null)
	if(flooded)
		return
	fluid_update_turf(1)
	var/datum/gas_mixture/fluid/my_fluid = return_fluids()
	if(isnull(temp))
		my_fluid.adjust_gas(gasid, moles)
	else
		my_fluid.adjust_gas_temp(gasid, moles, temp)
	if(my_fluid.check_tile_graphic())
		update_visuals(my_fluid)
	return 1

/turf/simulated/remove_fluid(amount as num)
	if(flooded)
		return
	fluid_update_turf(1)
	var/datum/gas_mixture/fluid/my_fluid = return_fluids()
	var/returnval = my_fluid.remove(amount)
	if(my_fluid.check_tile_graphic())
		update_visuals(my_fluid)
	return returnval

/atom/proc/return_fluids()

/turf/return_fluids()
	if(flooded)
		var/datum/gas_mixture/infiniwater = new()
		infiniwater.copy_from(get_global_ocean())
		return infiniwater
	return null

/turf/simulated/return_fluids()
	if(flooded)
		return ..()
	if(!fluids)
		make_fluids()
	return fluids

/turf/proc/make_fluids()
	return

/turf/simulated/make_fluids()
	fluids = new()
	return fluids

/turf/simulated/proc/share_fluids(var/turf/simulated/T)
	if(flooded)
		return
	if(T.fluid_current_cycle >= fluid_current_cycle)
		return
	fluids.share(T.fluids, fluid_adjacent_turfs_amount)

/turf/simulated/proc/process_fluids()
	if(!fluid_master || flooded)
		return
	if(fluid_archived_cycle < fluid_master.current_cycle) //archive self if not already done
		archive_fluids()
	fluid_current_cycle = fluid_master.current_cycle
	var/remove = 1
	for(var/direction in fluid_dirs)
		if(!(fluid_adjacent_turfs & direction))
			continue
		var/turf/enemy_tile = get_step(src, direction)
		if(istype(enemy_tile,/turf/simulated))
			var/turf/simulated/enemy_simulated = enemy_tile
			if(fluid_current_cycle > enemy_simulated.fluid_current_cycle)
				enemy_simulated.archive_fluids()
			if(!fluids.compare(enemy_simulated.return_fluids()))
				fluid_master.add_to_active(enemy_simulated)
				share_fluids(enemy_simulated)
			if(remove && !fluids.check_turf_fluid(enemy_tile, atmos_adjacent_turfs_amount))
				remove = 0

	if(fluids)
		if(fluids.check_tile_graphic())
			update_visuals(fluids)
	if(remove == 1)
		fluid_master.active_turfs -= src
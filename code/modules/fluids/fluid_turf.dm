/turf
	var/fluids_adjacent_turfs = 0
	var/fluids_adjacent_turfs_amount = 0
	var/need_fluid_update
	var/obj/effect/gas_overlay/fluid_overlay

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
		update_visuals_fluids(my_fluid)

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
		update_visuals_fluids(my_fluid)
	return 1

/turf/simulated/remove_fluid(amount as num)
	if(flooded)
		return
	fluid_update_turf(1)
	var/datum/gas_mixture/fluid/my_fluid = return_fluids()
	var/returnval = my_fluid.remove(amount)
	if(my_fluid.check_tile_graphic())
		update_visuals_fluids(my_fluid)
	return returnval

/turf/simulated/proc/update_visuals_fluids(var/datum/gas_mixture/model)
	if(!fluid_master)
		return 0
	if(fluid_overlay)
		fluid_overlay.overlays.Cut()
	if(model.graphic.len)
		if(!fluid_overlay)
			fluid_overlay = new /obj/effect/gas_overlay(src)
		for(var/gas_icon in model.graphic)
			fluid_overlay.overlays |= gas_icon
	if(fluid_overlay)
		fluid_overlay.alpha = model.graphic_alpha
	update_icon()
	return 1

/turf/proc/return_fluids()
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
	fluids.share(T.fluids, fluids_adjacent_turfs_amount)

/turf/simulated/proc/process_fluids()
	if(!fluid_master)
		return
	if(flooded)
		fluid_master.active_turfs -= src
		return
	if(fluid_archived_cycle < fluid_master.current_cycle) //archive self if not already done
		archive_fluids()
	fluid_archived_cycle = fluid_master.current_cycle
	for(var/direction in fluid_dirs)
		if(!(fluids_adjacent_turfs & direction))
			continue
		var/turf/enemy_tile = get_step(src, direction)
		if(!istype(enemy_tile) || enemy_tile.flooded)
			continue
		if(istype(enemy_tile,/turf/simulated))
			var/turf/simulated/enemy_simulated = enemy_tile
			if(!enemy_simulated.fluids)
				enemy_simulated.make_fluids()
			if(!enemy_simulated.fluids)
				continue
			if(fluid_current_cycle > enemy_simulated.fluid_current_cycle)
				enemy_simulated.archive_fluids()
			if(!fluids)
				make_fluids()
			if(fluids && !fluids.compare(enemy_simulated.fluids)) //compare if
				fluid_master.add_to_active(enemy_simulated) //excite enemy
				share_fluids(enemy_simulated) //share
	if(fluids && fluids.check_tile_graphic())
		update_visuals_fluids(air)
	fluid_master.active_turfs -= src

/turf/proc/calculate_flow_dirs()
	fluids_adjacent_turfs_amount = 0
	for(var/direction in fluid_dirs)
		var/turf/T = get_step(src, direction)
		if(!istype(T))
			continue
		var/counterdir = get_dir(T, src)
		if(CanFluidPass(T))
			fluids_adjacent_turfs_amount += 1
			fluids_adjacent_turfs |= direction
			if(!(T.fluids_adjacent_turfs & counterdir))
				T.fluids_adjacent_turfs_amount += 1
			T.fluids_adjacent_turfs |= counterdir
		else
			fluids_adjacent_turfs &= ~direction
			if(T.fluids_adjacent_turfs & counterdir)
				T.fluids_adjacent_turfs_amount -= 1
			T.fluids_adjacent_turfs &= ~counterdir
/datum/gas_mixture
	//Associative list of gas moles.
	//Gases with 0 moles are not tracked and are pruned by update_values()
	var/list/gas = list()
	var/list/archived_gas = list()     // Used for calculating deltas, might as well be magic.
	var/total_moles = 0                // Sum of all the gas moles in this mix.  Updated by update_values()
	var/volume = CELL_VOLUME           // Volume of this mix.
	var/list/graphic = list()          // List of active tile overlays for this gas_mixture.  Updated by check_tile_graphic()
	var/list/graphic_archived = list() // Archive
	var/graphic_alpha = 0              // Used by tile overlays.
	var/last_share                     // Last gas amount shared.

/datum/gas_mixture/New(vol = CELL_VOLUME)
	volume = vol

//Takes a gas string and the amount of moles to adjust by.  Calls update_values() if update isn't 0.
/datum/gas_mixture/proc/adjust_gas(gasid, moles, update = 1)
	if(moles == 0)
		return
	gas[gasid] += moles
	if(update)
		update_values()

//Variadic version of adjust_gas().  Takes any number of gas and mole pairs and applies them.
/datum/gas_mixture/proc/adjust_multi()
	ASSERT(!(args.len % 2))
	for(var/i = 1; i < args.len; i += 2)
		adjust_gas(args[i], args[i+1], update = 0)
	update_values()

//Merges all the gas from another mixture into this one. Does not modify giver in any way.
/datum/gas_mixture/proc/merge(const/datum/gas_mixture/giver)
	if(!giver)
		return
	for(var/g in giver.gas)
		gas[g] += giver.gas[g]
	update_values()

/datum/gas_mixture/proc/equalize(datum/gas_mixture/sharer)
	for(var/g in gas|sharer.gas)
		var/comb = gas[g] + sharer.gas[g]
		comb /= volume + sharer.volume
		gas[g] = comb * volume
		sharer.gas[g] = comb * sharer.volume
	update_values()
	return 1

//Updates the total_moles count and trims any empty gases.
/datum/gas_mixture/proc/update_values()
	total_moles = 0
	for(var/g in gas)
		if(gas[g] <= 0)
			gas -= g
		else
			total_moles += gas[g]

//Returns the pressure of the gas mix.  Only accurate if there have been no gas modifications since update_values() has been called.
/datum/gas_mixture/proc/return_pressure()
	if(volume)
		return total_moles * R_IDEAL_GAS_EQUATION * volume
	return 0

//Removes moles from the gas mixture and returns a gas_mixture containing the removed air.
/datum/gas_mixture/proc/remove(amount)
	amount = min(amount, total_moles) //Can not take more air than the gas mixture has!
	if(amount <= 0)
		return null
	var/datum/gas_mixture/removed = new
	for(var/g in gas)
		removed.gas[g] = QUANTIZE((gas[g] / total_moles) * amount)
		gas[g] -= removed.gas[g]
	update_values()
	removed.update_values()
	return removed

//Removes a ratio of gas from the mixture and returns a gas_mixture containing the removed air.
/datum/gas_mixture/proc/remove_ratio(ratio)
	if(ratio <= 0)
		return null

	ratio = min(ratio, 1)

	var/datum/gas_mixture/removed = new
	for(var/g in gas)
		removed.gas[g] = (gas[g] * ratio)
		gas[g] = gas[g] * (1 - ratio)
	update_values()
	removed.update_values()

	return removed

//Removes a volume of gas from the mixture and returns a gas_mixture containing the removed air with the given volume
/datum/gas_mixture/proc/remove_volume(removed_volume)
	var/datum/gas_mixture/removed = remove_ratio(removed_volume/volume, 1)
	removed.volume = removed_volume
	return removed

//Removes moles from the gas mixture, limited by a given flag.  Returns a gax_mixture containing the removed air.
/datum/gas_mixture/proc/remove_by_flag(flag, amount)
	if(!flag || amount <= 0)
		return

	var/sum = 0
	for(var/g in gas)
		if(gas_data.flags[g] & flag)
			sum += gas[g]
	var/datum/gas_mixture/removed = new
	for(var/g in gas)
		if(gas_data.flags[g] & flag)
			removed.gas[g] = QUANTIZE((gas[g] / sum) * amount)
			gas[g] -= removed.gas[g]
	update_values()
	removed.update_values()
	return removed

//Copies gas and temperature from another gas_mixture.
/datum/gas_mixture/proc/copy_from(const/datum/gas_mixture/sample)
	gas = sample.gas.Copy()
	update_values()
	return 1

//Checks if we are within acceptable range of another gas_mixture to suspend processing or merge.
/datum/gas_mixture/proc/compare(const/datum/gas_mixture/sample)
	if(!sample) return 0

	var/list/marked = list()
	for(var/g in gas)
		if((abs(gas[g] - sample.gas[g]) > MINIMUM_AIR_TO_SUSPEND) && \
		((gas[g] < (1 - MINIMUM_AIR_RATIO_TO_SUSPEND) * sample.gas[g]) || \
		(gas[g] > (1 + MINIMUM_AIR_RATIO_TO_SUSPEND) * sample.gas[g])))
			return 0
		marked[g] = 1

	for(var/g in sample.gas)
		if(!marked[g])
			if((abs(gas[g] - sample.gas[g]) > MINIMUM_AIR_TO_SUSPEND) && \
			((gas[g] < (1 - MINIMUM_AIR_RATIO_TO_SUSPEND) * sample.gas[g]) || \
			(gas[g] > (1 + MINIMUM_AIR_RATIO_TO_SUSPEND) * sample.gas[g])))
				return 0

	if(total_moles > MINIMUM_AIR_TO_SUSPEND)
		return 0

	return 1

/datum/gas_mixture/proc/react()
	return

//Rechecks the gas_mixture and adjusts the graphic list if needed.
//Two lists can be passed by reference if you need know specifically which graphics were added and removed.
/datum/gas_mixture/proc/check_tile_graphic(list/graphic_add = null, list/graphic_remove = null)
	var/next_alpha = 0
	graphic_alpha = 0

	if(!gas_data)
		return // ??? Runtiming for some reason.

	for(var/g in gas_data.overlay_limit)

		if(isnull(gas[g]))
			continue

		var/gas_amount = gas[g]
		next_alpha += gas_amount
		var/image/tile_overlay = gas_data.tile_overlay[g]
		if(graphic.Find(tile_overlay))
			//Overlay is already applied for this gas, check if it's still valid.
			if(gas_amount <= gas_data.overlay_limit[g] || gas_amount >= GAS_SATURATION_POINT)
				if(!graphic_remove)
					graphic_remove = list()
				graphic_remove |= tile_overlay
		else
			//Overlay isn't applied for this gas, check if it's valid and needs to be added.
			if(gas_amount > gas_data.overlay_limit[g] && gas_amount < GAS_SATURATION_POINT)
				graphic_alpha += gas_amount
				if(!graphic_add)
					graphic_add = list()
				graphic_add |= tile_overlay

		var/image/saturated_overlay = gas_data.saturated_overlay[g]
		if(graphic.Find(saturated_overlay))
			if(gas_amount < GAS_SATURATION_POINT)
				if(!graphic_remove)
					graphic_remove = list()
				graphic_remove |= saturated_overlay
		else
			if(gas_amount >= GAS_SATURATION_POINT)
				if(!graphic_add)
					graphic_add = list()
				graphic_add |= saturated_overlay

	. = 0
	//Apply changes
	if(graphic_add && graphic_add.len)
		graphic |= graphic_add
		. = 1
	if(graphic_remove && graphic_remove.len)
		graphic -= graphic_remove
		. = 1
	if(next_alpha != graphic_alpha || graphic_alpha > GAS_MAX_ALPHA || graphic_alpha < GAS_MIN_ALPHA)
		graphic_alpha = max(min(GAS_MAX_ALPHA, next_alpha),GAS_MIN_ALPHA)
		. = 1

//Simpler version of merge(), adjusts gas amounts directly and doesn't account for temperature.
/datum/gas_mixture/proc/add(datum/gas_mixture/right_side)
	for(var/g in right_side.gas)
		gas[g] += right_side.gas[g]
	update_values()
	return 1

//Simpler version of remove(), adjusts gas amounts directly.
/datum/gas_mixture/proc/subtract(datum/gas_mixture/right_side)
	for(var/g in right_side.gas)
		gas[g] -= right_side.gas[g]
	update_values()
	return 1

//Multiply all gas amounts by a factor.
/datum/gas_mixture/proc/multiply(factor)
	for(var/g in gas)
		gas[g] *= factor
	update_values()
	return 1

//Divide all gas amounts by a factor.
/datum/gas_mixture/proc/divide(factor)
	for(var/g in gas)
		gas[g] /= factor
	update_values()
	return 1

//Equalizes a list of gas mixtures.  Used for pipe networks.
/proc/equalize_gases(datum/gas_mixture/list/gases)
	//Calculate totals from individual components
	var/total_volume = 0

	var/list/total_gas = list()
	for(var/datum/gas_mixture/gasmix in gases)
		total_volume += gasmix.volume
		for(var/g in gasmix.gas)
			total_gas[g] += gasmix.gas[g]

	if(total_volume > 0)
		var/datum/gas_mixture/combined = new(total_volume)
		combined.gas = total_gas
		//Average out the gases
		for(var/g in combined.gas)
			combined.gas[g] /= total_volume
		//Update individual gas_mixtures
		for(var/datum/gas_mixture/gasmix in gases)
			gasmix.gas = combined.gas.Copy()
			gasmix.multiply(gasmix.volume)

	return 1

/datum/gas_mixture/proc/archive()
	archived_gas = list()
	for(var/gas_id in gas)
		archived_gas[gas_id] = gas[gas_id]
	graphic_archived = graphic
	return 1

/datum/gas_mixture/proc/get_gas_deltas(var/datum/gas_mixture/sharer, var/adjacent_turfs)
	var/list/cdeltas = list()
	for(var/gas_id in archived_gas)
		var/current_level = (!isnull(archived_gas[gas_id]) ? archived_gas[gas_id] : 0)
		var/sharer_level = 0
		if(sharer.archived_gas && !isnull(sharer.archived_gas[gas_id]))
			sharer_level = sharer.archived_gas[gas_id]
		var/cdelta = QUANTIZE((current_level - sharer_level)/adjacent_turfs)
		if(cdelta) cdeltas[gas_id] = cdelta
	return cdeltas

// Shares gas between two datums.
/datum/gas_mixture/proc/share(var/datum/gas_mixture/sharer, var/atmos_adjacent_turfs = 4)

	if(!sharer)	return 0

	var/moved_moles = 0
	last_share = 0
	var/list/current_deltas = get_gas_deltas(sharer, atmos_adjacent_turfs+1)
	for(var/gas_id in current_deltas)
		var/cdelta = current_deltas[gas_id]
		moved_moles += cdelta
		last_share += abs(cdelta)

	for(var/gas_id in gas)
		var/cdelta = current_deltas[gas_id]
		gas[gas_id] -= cdelta
		sharer.adjust_gas(gas_id, cdelta)

	update_values()
	sharer.update_values()

/datum/gas_mixture/proc/mimic(turf/model, border_multiplier, var/atmos_adjacent_turfs = 4)

	var/datum/gas_mixture/sharer = model.return_air()
	if(!sharer)
		return
	var/moved_moles = 0
	last_share = 0
	var/list/current_deltas = get_gas_deltas(sharer, atmos_adjacent_turfs+1)
	for(var/gas_id in current_deltas)
		var/cdelta = current_deltas[gas_id]
		moved_moles += cdelta
		last_share += abs(cdelta)

	for(var/gas_id in gas)
		if(!gas_id in gas_data.gases)
			continue
		var/gas_delta = current_deltas[gas_id]
		if(border_multiplier)
			gas_delta *= border_multiplier
		gas[gas_id] -= gas_delta

	if(abs(moved_moles) > MINIMUM_MOLES_DELTA_TO_MOVE)
		var/delta_pressure = (total_moles + moved_moles) - sharer.total_moles
		return delta_pressure*R_IDEAL_GAS_EQUATION/volume
	else
		return 0

/datum/gas_mixture/proc/check_turf_air(var/turf/model, var/atmos_adjacent_turfs = 4)

	var/datum/gas_mixture/sharer = model.return_air()
	if(isnull(sharer))
		return
	var/list/current_deltas = get_gas_deltas(sharer, atmos_adjacent_turfs+1)

	for(var/gas_id in current_deltas)
		var/cdelta = abs(current_deltas[gas_id])
		if(cdelta > MINIMUM_AIR_TO_SUSPEND)
			var/compare_val = archived_gas[gas_id] ? (archived_gas[gas_id]*MINIMUM_AIR_RATIO_TO_SUSPEND) : 0
			if(cdelta > compare_val)
				return 0
	return 1

#define MINIMUM_HEAT_CAPACITY 0.0003

/datum/gas_mixture
	//Associative list of gas moles.
	//Gases with 0 moles are not tracked and are pruned by update_values()
	var/list/gas = list()
	var/list/archived_gas = list()     // Used for calculating deltas, might as well be magic.
	var/temperature = 0                // Temperature in Kelvin of this gas mix.
	var/temperature_archived = 0       // Archive
	var/total_moles = 0                // Sum of all the gas moles in this mix.  Updated by update_values()
	var/volume = CELL_VOLUME           // Volume of this mix.
	var/list/graphic = list()          // List of active tile overlays for this gas_mixture.  Updated by check_tile_graphic()
	var/list/graphic_archived = list() // Archive
	var/last_share                     // Last gas amount shared.
	var/tmp/fuel_burnt = 0             // Something to do with fire.

/datum/gas_mixture/New(vol = CELL_VOLUME)
	volume = vol

//Takes a gas string and the amount of moles to adjust by.  Calls update_values() if update isn't 0.
/datum/gas_mixture/proc/adjust_gas(gasid, moles, update = 1)
	if(moles == 0)
		return
	gas[gasid] += moles
	if(update)
		update_values()

//Same as adjust_gas(), but takes a temperature which is mixed in with the gas.
/datum/gas_mixture/proc/adjust_gas_temp(gasid, moles, temp, update = 1)
	if(moles == 0)
		return
	if(moles > 0 && abs(temperature - temp) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/self_heat_capacity = heat_capacity()
		var/giver_heat_capacity = gas_data.specific_heat[gasid] * moles
		var/combined_heat_capacity = giver_heat_capacity + self_heat_capacity
		if(combined_heat_capacity != 0)
			temperature = (temp * giver_heat_capacity + temperature * self_heat_capacity) / combined_heat_capacity
	gas[gasid] += moles
	if(update)
		update_values()

//Variadic version of adjust_gas().  Takes any number of gas and mole pairs and applies them.
/datum/gas_mixture/proc/adjust_multi()
	ASSERT(!(args.len % 2))
	for(var/i = 1; i < args.len; i += 2)
		adjust_gas(args[i], args[i+1], update = 0)
	update_values()

//Variadic version of adjust_gas_temp().  Takes any number of gas, mole and temperature associations and applies them.
/datum/gas_mixture/proc/adjust_multi_temp()
	ASSERT(!(args.len % 3))
	for(var/i = 1; i < args.len; i += 3)
		adjust_gas_temp(args[i], args[i + 1], args[i + 2], update = 0)
	update_values()

//Merges all the gas from another mixture into this one. Does not modify giver in any way.
/datum/gas_mixture/proc/merge(const/datum/gas_mixture/giver)
	if(!giver)
		return

	if(abs(temperature-giver.temperature)>MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/self_heat_capacity = heat_capacity()
		var/giver_heat_capacity = giver.heat_capacity()
		var/combined_heat_capacity = giver_heat_capacity + self_heat_capacity
		if(combined_heat_capacity != 0)
			temperature = (giver.temperature*giver_heat_capacity + temperature*self_heat_capacity)/combined_heat_capacity
	for(var/g in giver.gas)
		gas[g] += giver.gas[g]

	update_values()

/datum/gas_mixture/proc/equalize(datum/gas_mixture/sharer)
	for(var/g in sharer.gas)
		var/comb = gas[g] + sharer.gas[g]
		comb /= volume + sharer.volume
		gas[g] = comb * volume
		sharer.gas[g] = comb * sharer.volume

	var/our_heatcap = heat_capacity()
	var/share_heatcap = sharer.heat_capacity()

	if(our_heatcap + share_heatcap)
		temperature = ((temperature * our_heatcap) + (sharer.temperature * share_heatcap)) / (our_heatcap + share_heatcap)
	sharer.temperature = temperature

	update_values()

	return 1

//Returns the heat capacity of the gas mix based on the specific heat of the gases.
/datum/gas_mixture/proc/heat_capacity()
	. = 0
	for(var/g in gas)
		. += gas_data.specific_heat[g] * gas[g]
	.

/datum/gas_mixture/proc/heat_capacity_archived()
	var/heat_capacity_archived = 0
	for(var/gas_id in gas)
		if(!(gas_id in gas_data.gases))
			continue
		if(isnull(archived_gas[gas_id])) archived_gas[gas_id] = 0
		heat_capacity_archived += archived_gas[gas_id] * gas_data.specific_heat[gas_id]
	return heat_capacity_archived

//Adds or removes thermal energy. Returns the actual thermal energy change, as in the case of removing energy we can't go below TCMB.
/datum/gas_mixture/proc/add_thermal_energy(var/thermal_energy)
	if (total_moles == 0)
		return 0

	var/heat_capacity = heat_capacity()
	if (thermal_energy < 0)
		if (temperature < TCMB)
			return 0
		var/thermal_energy_limit = -(temperature - TCMB)*heat_capacity	//ensure temperature does not go below TCMB
		thermal_energy = max( thermal_energy, thermal_energy_limit )	//thermal_energy and thermal_energy_limit are negative here.
	temperature += thermal_energy/heat_capacity
	return thermal_energy

//Returns the thermal energy change required to get to a new temperature
/datum/gas_mixture/proc/get_thermal_energy_change(var/new_temperature)
	return heat_capacity()*(max(new_temperature, 0) - temperature)

//Technically vacuum doesn't have a specific entropy. Just use a really big number (infinity would be ideal) here so that it's easy to add gas to vacuum and hard to take gas out.
#define SPECIFIC_ENTROPY_VACUUM		150000

//Returns the ideal gas specific entropy of the whole mix. This is the entropy per mole of /mixed/ gas.
/datum/gas_mixture/proc/specific_entropy()
	if (!gas.len || total_moles == 0)
		return SPECIFIC_ENTROPY_VACUUM

	. = 0
	for(var/g in gas)
		. += gas[g] * specific_entropy_gas(g)
	. /= total_moles

/*
	It's arguable whether this should even be called entropy anymore. It's more "based on" entropy than actually entropy now.

	Returns the ideal gas specific entropy of a specific gas in the mix. This is the entropy due to that gas per mole of /that/ gas in the mixture, not the entropy due to that gas per mole of gas mixture.

	For the purposes of SS13, the specific entropy is just a number that tells you how hard it is to move gas. You can replace this with whatever you want.
	Just remember that returning a SMALL number == adding gas to this gas mix is HARD, taking gas away is EASY, and that returning a LARGE number means the opposite (so a vacuum should approach infinity).

	So returning a constant/(partial pressure) would probably do what most players expect. Although the version I have implemented below is a bit more nuanced than simply 1/P in that it scales in a way
	which is bit more realistic (natural log), and returns a fairly accurate entropy around room temperatures and pressures.
*/
/datum/gas_mixture/proc/specific_entropy_gas(var/gasid)
	if (!(gasid in gas) || gas[gasid] == 0)
		return SPECIFIC_ENTROPY_VACUUM	//that gas isn't here

	var/molar_mass = gas_data.molar_mass[gasid]
	var/specific_heat = gas_data.specific_heat[gasid]
	return R_IDEAL_GAS_EQUATION * ( log( (IDEAL_GAS_ENTROPY_CONSTANT*volume/(gas[gasid] * temperature)) * (molar_mass*specific_heat*temperature)**(2/3) + 1 ) +  15 )

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
		return total_moles * R_IDEAL_GAS_EQUATION * temperature / volume
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

	removed.temperature = temperature
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

	removed.temperature = temperature
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

	removed.temperature = temperature
	update_values()
	removed.update_values()

	return removed

//Copies gas and temperature from another gas_mixture.
/datum/gas_mixture/proc/copy_from(const/datum/gas_mixture/sample)
	gas = sample.gas.Copy()
	temperature = sample.temperature
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
		if((abs(temperature - sample.temperature) > MINIMUM_TEMPERATURE_DELTA_TO_SUSPEND) && \
		((temperature < (1 - MINIMUM_TEMPERATURE_RATIO_TO_SUSPEND)*sample.temperature) || \
		(temperature > (1 + MINIMUM_TEMPERATURE_RATIO_TO_SUSPEND)*sample.temperature)))
			return 0

	return 1

/datum/gas_mixture/proc/react(atom/dump_location)
	return

//Rechecks the gas_mixture and adjusts the graphic list if needed.
//Two lists can be passed by reference if you need know specifically which graphics were added and removed.
/datum/gas_mixture/proc/check_tile_graphic(list/graphic_add = null, list/graphic_remove = null)
	for(var/g in gas_data.overlay_limit)
		if(graphic.Find(gas_data.tile_overlay[g]))
			//Overlay is already applied for this gas, check if it's still valid.
			if(gas[g] <= gas_data.overlay_limit[g])
				if(!graphic_remove)
					graphic_remove = list()
				graphic_remove += gas_data.tile_overlay[g]
		else
			//Overlay isn't applied for this gas, check if it's valid and needs to be added.
			if(gas[g] > gas_data.overlay_limit[g])
				if(!graphic_add)
					graphic_add = list()
				graphic_add += gas_data.tile_overlay[g]

	. = 0
	//Apply changes
	if(graphic_add && graphic_add.len)
		graphic += graphic_add
		. = 1
	if(graphic_remove && graphic_remove.len)
		graphic -= graphic_remove
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
	var/total_thermal_energy = 0
	var/total_heat_capacity = 0

	var/list/total_gas = list()
	for(var/datum/gas_mixture/gasmix in gases)
		total_volume += gasmix.volume
		var/temp_heatcap = gasmix.heat_capacity()
		total_thermal_energy += gasmix.temperature * temp_heatcap
		total_heat_capacity += temp_heatcap
		for(var/g in gasmix.gas)
			total_gas[g] += gasmix.gas[g]

	if(total_volume > 0)
		//Average out the gases
		for(var/g in total_gas)
			total_gas[g] /= total_volume

		//Calculate temperature
		var/temperature = 0

		if(total_heat_capacity > 0)
			temperature = total_thermal_energy / total_heat_capacity

		//Update individual gas_mixtures
		for(var/datum/gas_mixture/gasmix in gases)
			gasmix.gas = total_gas.Copy()
			gasmix.temperature = temperature
			gasmix.multiply(gasmix.volume)

	return 1

/datum/gas_mixture/proc/archive()
	archived_gas = list()
	for(var/gas_id in gas)
		archived_gas[gas_id] = gas[gas_id]
	temperature_archived = temperature
	graphic_archived = graphic
	return 1

/datum/gas_mixture/proc/get_gas_deltas(var/datum/gas_mixture/sharer, var/adjacent_turfs)
	var/list/cdeltas = list()
	for(var/gas_id in archived_gas)
		var/current_level = (!isnull(archived_gas[gas_id]) ? archived_gas[gas_id] : 0)
		var/sharer_level = 0
		if(sharer.archived_gas && !isnull(sharer.archived_gas[gas_id]))
			sharer_level = sharer.archived_gas[gas_id]
		cdeltas[gas] = QUANTIZE((current_level - sharer_level)/adjacent_turfs)
	return cdeltas

/datum/gas_mixture/proc/get_temperature_delta(var/datum/gas_mixture/sharer)
	return (temperature_archived - sharer.temperature_archived)

// Shares gas between two datums.
/datum/gas_mixture/proc/share(var/datum/gas_mixture/sharer, var/atmos_adjacent_turfs = 4)

	if(!sharer)	return 0

	var/delta_temperature = get_temperature_delta(sharer)
	var/old_self_heat_capacity = 0
	var/old_sharer_heat_capacity = 0
	var/heat_capacity_self_to_sharer = 0
	var/heat_capacity_sharer_to_self = 0

	var/moved_moles = 0
	last_share = 0
	var/list/current_deltas = get_gas_deltas(sharer, atmos_adjacent_turfs+1)
	for(var/gas_id in current_deltas)
		var/cdelta = current_deltas[gas_id]
		moved_moles += cdelta
		last_share += abs(cdelta)

	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)

		for(var/gas_id in gas)
			if(!(gas_id in gas_data.gases))
				continue
			var/gas_delta = current_deltas[gas_id]
			if(gas_delta)
				var/gas_heat_capacity = gas_data.specific_heat[gas_id] * gas[gas_id]
				if(gas_delta > 0)
					heat_capacity_self_to_sharer += gas_heat_capacity
				else
					heat_capacity_sharer_to_self -= gas_heat_capacity

		old_self_heat_capacity = heat_capacity()
		old_sharer_heat_capacity = sharer.heat_capacity()

		var/new_self_heat_capacity = old_self_heat_capacity + heat_capacity_sharer_to_self - heat_capacity_self_to_sharer
		var/new_sharer_heat_capacity = old_sharer_heat_capacity + heat_capacity_self_to_sharer - heat_capacity_sharer_to_self

		if(new_self_heat_capacity > MINIMUM_HEAT_CAPACITY)
			temperature = (old_self_heat_capacity*temperature - heat_capacity_self_to_sharer*temperature_archived + heat_capacity_sharer_to_self*sharer.temperature_archived)/new_self_heat_capacity

		if(new_sharer_heat_capacity > MINIMUM_HEAT_CAPACITY)
			sharer.temperature = (old_sharer_heat_capacity*sharer.temperature-heat_capacity_sharer_to_self*sharer.temperature_archived + heat_capacity_self_to_sharer*temperature_archived)/new_sharer_heat_capacity

			if(abs(old_sharer_heat_capacity) > MINIMUM_HEAT_CAPACITY)
				if(abs(new_sharer_heat_capacity/old_sharer_heat_capacity - 1) < 0.10) // <10% change in sharer heat capacity
					temperature_share(sharer, OPEN_HEAT_TRANSFER_COEFFICIENT)

	for(var/gas_id in gas)
		var/cdelta = current_deltas[gas_id]
		gas[gas_id] -= cdelta
		if(isnull(sharer.gas[gas_id]))
			sharer.gas[gas_id] = cdelta
		else
			sharer.gas[gas_id] += cdelta

	update_values()
	sharer.update_values()

	if((delta_temperature > MINIMUM_TEMPERATURE_TO_MOVE) || abs(moved_moles) > MINIMUM_MOLES_DELTA_TO_MOVE)
		var/delta_pressure = temperature_archived*(total_moles + moved_moles) - sharer.temperature_archived*(sharer.total_moles - moved_moles)
		return delta_pressure*R_IDEAL_GAS_EQUATION/volume

/datum/gas_mixture/proc/mimic(turf/model, border_multiplier, var/atmos_adjacent_turfs = 4)

	var/datum/gas_mixture/sharer = model.return_air()
	if(!sharer)
		return
	var/delta_temperature = get_temperature_delta(sharer)
	var/heat_transferred = 0
	var/old_self_heat_capacity = 0
	var/heat_capacity_transferred = 0

	var/moved_moles = 0
	last_share = 0
	var/list/current_deltas = get_gas_deltas(sharer, atmos_adjacent_turfs+1)
	for(var/gas_id in current_deltas)
		var/cdelta = current_deltas[gas_id]
		moved_moles += cdelta
		last_share += abs(cdelta)

	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)

		for(var/gas_id in gas)
			if(!gas_id in gas_data.gases)
				continue
			var/gas_delta = current_deltas[gas_id]
			if(gas_delta)
				var/gas_heat_capacity = gas_data.specific_heat[gas_id] * gas[gas_id]
				heat_transferred -= gas_heat_capacity*sharer.temperature
				heat_capacity_transferred -= gas_heat_capacity

		old_self_heat_capacity = heat_capacity()

	for(var/gas_id in gas)
		if(!gas_id in gas_data.gases)
			continue
		var/gas_delta = current_deltas[gas_id]
		if(border_multiplier)
			gas_delta *= border_multiplier
		gas[gas_id] -= gas_delta

	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/new_self_heat_capacity = old_self_heat_capacity - heat_capacity_transferred
		if(new_self_heat_capacity > MINIMUM_HEAT_CAPACITY)
			if(border_multiplier)
				temperature = (old_self_heat_capacity*temperature - heat_capacity_transferred*border_multiplier*temperature_archived)/new_self_heat_capacity
			else
				temperature = (old_self_heat_capacity*temperature - heat_capacity_transferred*temperature_archived)/new_self_heat_capacity

		temperature_mimic(model, model.thermal_conductivity, border_multiplier)

	if((delta_temperature > MINIMUM_TEMPERATURE_TO_MOVE) || abs(moved_moles) > MINIMUM_MOLES_DELTA_TO_MOVE)
		var/delta_pressure = temperature_archived*(total_moles + moved_moles) - sharer.temperature*sharer.total_moles
		return delta_pressure*R_IDEAL_GAS_EQUATION/volume
	else
		return 0

/datum/gas_mixture/proc/check_turf(var/turf/model, var/atmos_adjacent_turfs = 4)

	var/datum/gas_mixture/sharer = model.return_air()
	if(isnull(sharer))
		return
	var/delta_temperature = get_temperature_delta(sharer)
	var/list/current_deltas = get_gas_deltas(sharer, atmos_adjacent_turfs+1)

	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_SUSPEND)
		return 0
	for(var/gas_id in current_deltas)
		var/cdelta = abs(current_deltas[gas_id])
		if(cdelta > MINIMUM_AIR_TO_SUSPEND)
			var/compare_val = archived_gas[gas_id] ? (archived_gas[gas_id]*MINIMUM_AIR_RATIO_TO_SUSPEND) : 0
			if(cdelta > compare_val)
				return 0
	return 1

/datum/gas_mixture/proc/temperature_share(datum/gas_mixture/sharer, conduction_coefficient)

	var/delta_temperature = (temperature_archived - sharer.temperature_archived)
	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/self_heat_capacity = heat_capacity_archived()
		var/sharer_heat_capacity = sharer.heat_capacity_archived()

		if((sharer_heat_capacity > MINIMUM_HEAT_CAPACITY) && (self_heat_capacity > MINIMUM_HEAT_CAPACITY))
			var/heat = conduction_coefficient*delta_temperature* \
				(self_heat_capacity*sharer_heat_capacity/(self_heat_capacity+sharer_heat_capacity))

			temperature -= heat/self_heat_capacity
			sharer.temperature += heat/sharer_heat_capacity

/datum/gas_mixture/proc/temperature_mimic(turf/model, conduction_coefficient, border_multiplier)
	var/delta_temperature = (temperature - model.temperature)
	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/self_heat_capacity = heat_capacity()//_archived()

		if((model.heat_capacity > MINIMUM_HEAT_CAPACITY) && (self_heat_capacity > MINIMUM_HEAT_CAPACITY))
			var/heat = conduction_coefficient*delta_temperature* \
				(self_heat_capacity*model.heat_capacity/(self_heat_capacity+model.heat_capacity))

			if(border_multiplier)
				temperature -= heat*border_multiplier/self_heat_capacity
			else
				temperature -= heat/self_heat_capacity

/datum/gas_mixture/proc/temperature_turf_share(turf/simulated/sharer, conduction_coefficient)
	var/delta_temperature = (temperature_archived - sharer.temperature)
	if(abs(delta_temperature) > MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER)
		var/self_heat_capacity = heat_capacity()

		if((sharer.heat_capacity > MINIMUM_HEAT_CAPACITY) && (self_heat_capacity > MINIMUM_HEAT_CAPACITY))
			var/heat = conduction_coefficient*delta_temperature* \
				(self_heat_capacity*sharer.heat_capacity/(self_heat_capacity+sharer.heat_capacity))

			temperature -= heat/self_heat_capacity
			sharer.temperature += heat/sharer.heat_capacity

#undef MINIMUM_HEAT_CAPACITY

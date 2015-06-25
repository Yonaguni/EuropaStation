/turf/simulated/var/open_directions
/turf/var/needs_air_update = 0

/turf/simulated/proc/update_graphic(list/graphic_add = null, list/graphic_remove = null)
	if(graphic_add && graphic_add.len)
		overlays += graphic_add
	if(graphic_remove && graphic_remove.len)
		overlays -= graphic_remove

/turf/proc/update_air_properties()
	return

/turf/simulated/update_air_properties()
	return

/turf/proc/post_update_air_properties()
	//if(connections) connections.update_all()

/turf/assume_air(datum/gas_mixture/giver) //use this for machines to adjust air
	return 0

/turf/proc/assume_gas(gasid, moles, temp = 0)
	return 0

/turf/simulated/proc/burn_tile()
	return

/turf/return_air()
	//Create gas mixture to hold data for passing
	var/datum/gas_mixture/GM = new

	GM.adjust_multi("oxygen", oxygen, "carbon_dioxide", carbon_dioxide, "nitrogen", nitrogen, "phoron", phoron)
	GM.temperature = temperature

	return GM

/turf/remove_air(amount as num)
	air_update_turf(1)
	var/datum/gas_mixture/GM = new
	var/sum = oxygen + carbon_dioxide + nitrogen + phoron
	if(sum>0)
		GM.gas["oxygen"] = (oxygen/sum)*amount
		GM.gas["carbon_dioxide"] = (carbon_dioxide/sum)*amount
		GM.gas["nitrogen"] = (nitrogen/sum)*amount
		GM.gas["phoron"] = (phoron/sum)*amount

	GM.temperature = temperature
	GM.update_values()

	return GM

/turf/simulated/assume_air(datum/gas_mixture/giver)
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()
	my_air.merge(giver)

/turf/simulated/assume_gas(gasid, moles, temp = null)
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()

	if(isnull(temp))
		my_air.adjust_gas(gasid, moles)
	else
		my_air.adjust_gas_temp(gasid, moles, temp)

	return 1

/turf/simulated/remove_air(amount as num)
	air_update_turf(1)
	var/datum/gas_mixture/my_air = return_air()
	return my_air.remove(amount)

/turf/simulated/return_air()
	if(!air)
		make_air()
	return air

/turf/proc/make_air()
	return

/turf/simulated/make_air()
	air = new/datum/gas_mixture
	air.temperature = temperature
	air.adjust_multi("oxygen", oxygen, "carbon_dioxide", carbon_dioxide, "nitrogen", nitrogen, "phoron", phoron)
	air.volume = CELL_VOLUME

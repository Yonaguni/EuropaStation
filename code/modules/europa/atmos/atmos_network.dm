/datum/conduit_network/gas
	name = "atmospherics pipeline"
	var/gas = 0
	var/datum/gas_mixture/air_contents

/datum/conduit_network/gas/Destroy()
	if(air_contents)
		qdel(air_contents)
		air_contents = null
	. = ..()

/datum/conduit_network/gas/split_between(var/list/networks)

	if(!gas)
		return

	var/initial_gas = gas
	var/list/gas_results = list()

	// Get total pipe size (for second pass)
	var/conduit_count = 0
	for(var/datum/conduit_network/network in networks)
		conduit_count += network.conduits.len

	// Split gas contents between networks based on size.
	for(var/datum/conduit_network/gas/network in networks)
		network.gas = gas * (network.conduits.len/conduit_count)
		gas -= network.gas
		gas_results += "[network.gas]:[network.conduits.len]"

	to_chat(world, "Split [initial_gas] between [networks.len]:[conduit_count] | [gas_results.Join(" ")]")

	..()
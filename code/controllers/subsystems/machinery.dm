
var/machinery_sort_required = 0

/datum/controller/subsystem/machinery
	name = "Machinery"
	wait = MACHINERY_TICKRATE SECONDS
	flags = SS_NO_INIT

	var/list/current_machinery
	var/list/current_powernets
	var/list/current_powersinks
	var/list/current_pipenets

/datum/controller/subsystem/machinery/fire(resumed = 0)
	if (!resumed)
		current_machinery = machines.Copy()
		current_powernets = powernets.Copy()
		current_powersinks = processing_power_items.Copy()
		current_pipenets = pipe_networks.Copy()

		if (machinery_sort_required)
			machinery_sort_required = 0
			machines = dd_sortedObjectList(machines)

	var/list/curr_machines = current_machinery
	var/list/curr_powernets = current_powernets
	var/list/curr_sinks = current_powersinks
	var/list/curr_pipes = current_pipenets

	while (curr_pipes.len)
		var/datum/pipe_network/PN = curr_pipes[curr_pipes.len]
		curr_pipes.len--

		if (!QDELETED(PN))
			PN.process()
		else
			pipe_networks -= PN

		if (MC_TICK_CHECK)
			return

	while (curr_machines.len)
		var/obj/machinery/M = curr_machines[curr_machines.len]
		curr_machines.len--

		if (M.process() == PROCESS_KILL)
			machines -= M
		else if (M.use_power)
			M.auto_use_power()

		if (MC_TICK_CHECK)
			return

	while (curr_powernets.len)
		var/datum/powernet/PN = curr_powernets[curr_powernets.len]
		curr_powernets.len--

		if (!QDELETED(PN))
			PN.reset()
		else
			powernets -= PN

		if (MC_TICK_CHECK)
			return

	while (curr_sinks.len)
		var/obj/item/I = curr_sinks[curr_sinks.len]
		curr_sinks.len--

		if (QDELETED(I) || !I.pwr_drain())
			processing_power_items -= I

		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/machinery/stat_entry()
	..("M:[machines.len] PoN:[powernets.len] PiN:[pipe_networks.len] S:[processing_power_items.len]")

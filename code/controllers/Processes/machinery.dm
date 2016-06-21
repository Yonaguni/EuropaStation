/var/global/machinery_sort_required = 0

/datum/controller/process/machinery/setup()
	name = "machinery"
	schedule_interval = 20 // every 2 seconds
	start_delay = 12

/datum/controller/process/machinery/doWork()
	internal_sort()
	internal_process_machinery()

/datum/controller/process/machinery/proc/internal_sort()
	if(machinery_sort_required)
		machinery_sort_required = 0
		machines = dd_sortedObjectList(machines)

/datum/controller/process/machinery/proc/internal_process_machinery()
	for(last_object in machines)
		var/obj/machinery/M = last_object
		if(M && !M.gcDestroyed)
			if(M.process() == PROCESS_KILL)
				//M.inMachineList = 0 We don't use this debugging function
				machines.Remove(M)
				continue

			if(M && M.use_power)
				M.auto_use_power()

		SCHECK

/datum/controller/process/machinery/statProcess()
	..()
	stat(null, "[machines.len] machines")

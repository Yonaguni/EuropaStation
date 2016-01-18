var/list/open_turf_list = list()

/proc/queue_open_turf_update(var/turf/simulated/open/newturf)
	if(!istype(newturf))
		log_debug("Non-open turf supplied to queue.")
		return
	open_turf_list |= newturf

/datum/controller/process/open_space
	var/tmp/datum/updateQueue/updateQueueInstance

/datum/controller/process/open_space/setup()
	name = "openspace"
	schedule_interval = 5
	start_delay = 10

/datum/controller/process/open_space/started()
	..()
	if(!open_turf_list) open_turf_list = list()

/datum/controller/process/open_space/doWork()
	for(var/turf/simulated/open/open_turf in open_turf_list)
		open_turf.update_icon()
		open_turf_list -= open_turf

/datum/controller/process/open_space/statProcess()
	..()
	stat(null, "[open_turf_list.len] updates queued")

/var/datum/controller/subsystem/icon/SSicon_update

/datum/controller/subsystem/icon
	name = "Icon Updates"
	wait = 1	// ds
	priority = SS_PRIORITY_ICON_UPDATE
	init_order = SS_INIT_ICON_UPDATE
	
	var/list/queue = list()

/datum/controller/subsystem/icon/New()
	NEW_SS_GLOBAL(SSicon_update)

/datum/controller/subsystem/icon/stat_entry()
	..("QU:[queue.len]")

/datum/controller/subsystem/icon/Initialize()
	fire(FALSE, TRUE)
	..()

/datum/controller/subsystem/icon/fire(resumed = FALSE, no_mc_tick = FALSE)
	var/list/curr = queue

	if (!curr.len)
		suspend()
		return

	while (curr.len)
		var/atom/A = curr[curr.len]
		curr.len--

		A.icon_update_queued = FALSE
		A.update_icon()

		if (no_mc_tick)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			return

/atom
	var/tmp/icon_update_queued

// Almost nothing calls parent in this proc stack, so don't expect this base proc to actually get called.
/atom/proc/update_icon()

/atom/proc/queue_icon_update()
	if (!icon_update_queued)
		icon_update_queued = TRUE
		SSicon_update.queue += src
		if (SSicon_update.suspended)
			SSicon_update.wake()


// OT-specific stuff
/proc/queue_open_turf_update(var/turf/simulated/open/newturf)
	if(!istype(newturf))
		log_debug("Non-open turf supplied to queue.")
		return

	newturf.queue_icon_update()

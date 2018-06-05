/var/datum/controller/subsystem/turbolift/SSturbolift

/datum/controller/subsystem/turbolift
	name = "Turbolift"
	wait = 1 SECOND
	flags = SS_NO_INIT

	var/list/turbolifts = list()

	var/list/moving_lifts = list()
	var/list/currentrun

/datum/controller/subsystem/turbolift/New()
	NEW_SS_GLOBAL(SSturbolift)

/datum/controller/subsystem/turbolift/fire(resumed = 0)
	if (!resumed)
		src.currentrun = moving_lifts.Copy()

	var/list/currentrun = src.currentrun
	while (currentrun.len)
		var/ref = currentrun[currentrun.len]
		currentrun.len--

		if (world.time < moving_lifts[ref])
			if (MC_TICK_CHECK)
				return
			continue

		var/datum/turbolift/lift = locate(ref)
		if (lift.busy)
			if (MC_TICK_CHECK)
				return
			continue

		handle_lift(lift, ref)

		if (MC_TICK_CHECK)
			return
		
/datum/controller/subsystem/turbolift/proc/handle_lift(datum/turbolift/L, Lref)
	set waitfor = FALSE
	L.busy = TRUE

	if (!L.do_move())
		moving_lifts[Lref] = null
		moving_lifts -= Lref
	else
		lift_is_moving(L)
	
	L.busy = FALSE

/datum/controller/subsystem/turbolift/proc/lift_is_moving(datum/turbolift/lift)
	moving_lifts["\ref[lift]"] = world.time + lift.move_delay

/var/datum/controller/subsystem/mobs/SSmob

/datum/controller/subsystem/mobs
	name = "Mobs"
	flags = SS_NO_INIT
	priority = SS_PRIORITY_MOB
	wait = SS_MOB_TR

	var/list/slept = list()

	var/list/currentrun = list()

/datum/controller/subsystem/mobs/New()
	NEW_SS_GLOBAL(SSmob)

/datum/controller/subsystem/mobs/stat_entry()
	..("P:[mob_list.len]")

/datum/controller/subsystem/mobs/fire(resumed = 0)
	if (!resumed)
		src.currentrun = mob_list.Copy()

	var/list/currentrun = src.currentrun

	while (currentrun.len)
		var/mob/M = currentrun[currentrun.len]
		currentrun.len--

		if (QDELETED(M))
			log_debug("SSmob: QDELETED mob [M || "NULL"] left in processing list!")
			// We can just go ahead and remove them from all the mob lists.
			mob_list -= M
			dead_mob_list_ -= M
			living_mob_list_ -= M

			if (MC_TICK_CHECK)
				return
			continue

		var/time = world.time

		M.Life()

		if (time != world.time && !slept[M.type])
			slept[M.type] = TRUE
			var/diff = world.time - time
			log_debug("SSmob: Type '[M.type]' slept for [diff] ds in Life()! Suppressing further warnings.")

		if (MC_TICK_CHECK)
			return

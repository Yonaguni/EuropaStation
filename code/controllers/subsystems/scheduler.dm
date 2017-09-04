/var/datum/controller/subsystem/scheduler/SSscheduler

/datum/controller/subsystem/scheduler
	name = "Scheduler"
	wait = 5
	flags = SS_KEEP_TIMING | SS_NO_INIT

	var/list/tasks = list()
	var/datum/scheduled_task/head

/datum/controller/subsystem/scheduler/New()
	NEW_SS_GLOBAL(SSscheduler)

/datum/controller/subsystem/scheduler/fire(resumed = 0)
	while (head && !MC_TICK_CHECK)
		if (head.destroyed)
			head = head.next
			tasks -= head
			head.kill()
			continue
		if (head.trigger_time >= world.time)
			return	// Nothing after this will be ready to fire.

		// This one's ready to fire, process it.
		var/datum/scheduled_task/task = head
		head = task.next
		task.pre_process()
		task.process()
		task.post_process()
		if (task.destroyed)	// post_process probably destroyed it.
			tasks -= task
			task.kill()

/datum/controller/subsystem/scheduler/proc/queue(datum/scheduled_task/task)
	if (!task || !task.trigger_time)
		warning("scheduler: Invalid task queued! Ignoring.")
		return
	// Reset this in-case we're doing a rebuild.
	task.next = null
	if (!head && !tasks.len)
		head = task
		tasks += task
		return

	if (!head)	// Head's missing but we still have tasks, rebuild.
		tasks += task
		rebuild_queue()
		return

	var/datum/scheduled_task/curr = head
	while (curr.next && curr.trigger_time < task.trigger_time)
		curr = curr.next

	if (!curr.next)
		// We're at the end of the queue, just append.
		curr.next = task
		tasks += task
		return
	
	// Inserting midway into the list.
	var/old_next = curr.next
	curr.next = task
	task.next = old_next
	tasks += task

/datum/controller/subsystem/scheduler/proc/rebuild_queue()
	log_debug("scheduler: Rebuilding queue.")
	var/list/old_tasks = tasks
	tasks = list()
	if (!old_tasks.len)
		log_debug("scheduler: rebuild was called on empty queue! Aborting.")
		return

	// Find the head.
	for (var/thing in old_tasks)
		var/datum/scheduled_task/task = thing
		if (QDELETED(task))
			old_tasks -= task
			continue

		if (task.destroyed)
			old_tasks -= task
			task.kill()
			continue

		if (!head || task.trigger_time < head.trigger_time)
			head = task

	if (!head)
		log_debug("scheduler: unable to find head! Purging task queue.")
		for (var/thing in old_tasks)
			var/datum/scheduled_task/task = thing
			if (QDELETED(task))
				continue

			task.kill()

		head = null
		return

	// Don't queue the head.
	tasks += head
	old_tasks -= head

	// Now rebuild the queue.
	for (var/thing in old_tasks)
		var/datum/scheduled_task/task = thing

		queue(task)

	log_debug("scheduler: Queue diff is [old_tasks.len - tasks.len].")

/datum/controller/subsystem/scheduler/proc/schedule(datum/scheduled_task/st)
	queue(st)

/datum/controller/subsystem/scheduler/proc/unschedule(datum/scheduled_task/st)
	st.destroyed = TRUE

/proc/schedule_task_in(var/in_time, var/procedure, var/list/arguments = list())
	return schedule_task(world.time + in_time, procedure, arguments)

/proc/schedule_task_with_source_in(var/in_time, var/source, var/procedure, var/list/arguments = list())
	return schedule_task_with_source(world.time + in_time, source, procedure, arguments)

/proc/schedule_task(var/trigger_time, var/procedure, var/list/arguments)
	var/datum/scheduled_task/st = new/datum/scheduled_task(trigger_time, procedure, arguments, /proc/destroy_scheduled_task, list())
	SSscheduler.schedule(st)
	return st

/proc/schedule_task_with_source(var/trigger_time, var/source, var/procedure, var/list/arguments)
	var/datum/scheduled_task/st = new/datum/scheduled_task/source(trigger_time, source, procedure, arguments, /proc/destroy_scheduled_task, list())
	SSscheduler.schedule(st)
	return st

/proc/schedule_repeating_task(var/trigger_time, var/repeat_interval, var/procedure, var/list/arguments)
	var/datum/scheduled_task/st = new/datum/scheduled_task(trigger_time, procedure, arguments, /proc/repeat_scheduled_task, list(repeat_interval))
	SSscheduler.schedule(st)
	return st

/proc/schedule_repeating_task_with_source(var/trigger_time, var/repeat_interval, var/source, var/procedure, var/list/arguments)
	var/datum/scheduled_task/st = new/datum/scheduled_task/source(trigger_time, source, procedure, arguments, /proc/repeat_scheduled_task, list(repeat_interval))
	SSscheduler.schedule(st)
	return st

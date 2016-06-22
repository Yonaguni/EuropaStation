/datum/ai_mob
	var/name                           // Name of the AI datum type (cow etc)
	var/mob/living/attached            // Controlled mob. I do not anticipate needing AI ghosts.
	var/list/speak = list()            // Random things for the mob to say.
	var/panicked = 0                   // If the attached mob is freaking out. Set to -1 for a fearless mob.
	var/enraged = 0                    // If the attached mob is pissed off.
	var/next_process = 0               // Ticker delay based on world_time.
	var/process_delay = 40             // This should be okay.
	var/obstacle_destroyer             // Destroys obstacles.
	var/behavior_type = MOB_AI_GENERIC // General-purpose behavior flag.

/datum/ai_mob/proc/process(var/forced)
	return PROCESS_KILL

/datum/ai_mob/New(var/mob/holder)
	attached = holder
	list_of_ais |= src
	return ..()

/datum/ai_mob/Destroy()
	attached = null
	list_of_ais -= src
	return ..()

/datum/ai_mob/proc/stop_moving()
	walk(attached, 0)
	panicked = initial(panicked)
	enraged = initial(enraged)
	attached.update_icon()

/datum/ai_mob/proc/handle_neighbor_moved(var/mob/neighbor)
	return

/datum/ai_mob/proc/set_kill_target(var/mob/new_kill_target)
	return

/datum/ai_mob/proc/set_ally(var/mob/ally)
	return

/datum/ai_mob/proc/set_enemy(var/mob/enemy)
	return

/datum/ai_mob/proc/receive_friendly_interaction(var/mob/user)
	return (enraged>0 || panicked>0 || !attached.client && attached.stat != DEAD)

/datum/ai_mob/proc/receive_hostile_interaction(var/mob/user)
	return (!attached.client && attached.stat != DEAD)

/datum/ai_mob/proc/receive_neutral_interaction(var/mob/user)
	return (!attached.client && attached.stat != DEAD)


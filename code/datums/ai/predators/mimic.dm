/datum/ai_mob/animal/hostile/mimic
	name = "general mimic"
	obstacle_destroyer = 1
	var/mob/living/creator
	var/wait_for_trigger

/datum/ai_mob/animal/hostile/mimic/process(var/forced)
	if(wait_for_trigger)
		return
	return ..()

/datum/ai_mob/animal/hostile/mimic/receive_friendly_interaction(var/mob/user)
	if(wait_for_trigger)
		wait_for_trigger = 0
		process(forced=1)
		return
	return ..()

/datum/ai_mob/animal/hostile/mimic/receive_hostile_interaction(var/mob/user)
	if(wait_for_trigger)
		wait_for_trigger = 0
		process(forced=1)
		return
	return ..()

/datum/ai_mob/animal/hostile/mimic/receive_neutral_interaction(var/mob/user)
	if(wait_for_trigger)
		wait_for_trigger = 0
		process(forced=1)
		return
	return ..()

/datum/ai_mob/animal/hostile/mimic/set_ally(var/mob/ally)
	creator = ally
	creator.faction = "\ref[creator]"
	attached.faction = creator.faction

/datum/ai_mob/animal/hostile/mimic/crate
	name = "crate mimic"
	wait_for_trigger = 1
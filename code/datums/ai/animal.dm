/datum/ai_mob/animal

	name = "basic animal"

	var/list/idle_emotes = list()
	var/speak_chance = 0
	var/emote_chance = 0
	var/speak_sound

	var/can_be_restrained = 1
	var/wander = 1
	var/wander_prob = 80

	var/list/speech_fleeing = list()
	var/atom/flee_target
	var/atom/move_target

/datum/ai_mob/animal/receive_hostile_interaction(var/atom/aggressor)

	if(!..() || enraged>0 || panicked==-1)
		return

	var/fleedir
	if(aggressor != attached.loc)

		// TODO: Fix get_edge_target_turf() instead of using this block.

		fleedir = get_dir(aggressor, attached)
		if(fleedir == NORTHEAST)
			fleedir = pick(list(NORTH, EAST))
		else if(fleedir == SOUTHEAST)
			fleedir = pick(list(SOUTH, EAST))
		else if(fleedir == NORTHWEST)
			fleedir = pick(list(NORTH, WEST))
		else if(fleedir == SOUTHWEST)
			fleedir = pick(list(SOUTH, WEST))

	if(!fleedir)
		fleedir = pick(cardinal)

	flee_target = get_edge_target_turf(attached,fleedir)

	panicked = rand(5,10) //todo: make this variable based on mob
	attached.update_icon()
	process(forced=1)

	// Pass this on to our neighbors if we're a herd animal.
	if(behavior_type == MOB_AI_HERD)
		for(var/mob/living/animal/M in range(attached, world.view))
			if(!M.mob_ai || M.client || M.stat || M.mob_ai.behavior_type != MOB_AI_HERD || \
			 next_process <= M.mob_ai.next_process || M.mob_ai.enraged>0 || M.faction != attached.faction)
				continue
			M.mob_ai.receive_hostile_interaction(aggressor)

/datum/ai_mob/animal/proc/handle_emotes()
	if(idle_emotes.len && emote_chance && prob(emote_chance))
		attached.custom_emote(1, "[pick(idle_emotes)].")
	else if(speak.len && speak_chance && prob(speak_chance))
		attached.say(pick(speak))
		if(speak_sound)
			playsound(speak_sound, get_turf(attached))

/datum/ai_mob/animal/proc/handle_movement()

	// Rage overrides panic, this will be decremented
	// in the next block and reset panic properly.
	if(enraged>0)
		if(panicked>0)
			panicked = 1
	else if(attached.on_fire && panicked != -1)
		panicked = 15

	var/stationary_target = 0

	if(panicked>0)
		panicked--
		if(panicked<=0)
			panicked = initial(panicked)
			flee_target = null
			move_target = null
			wander = initial(wander)
			attached.update_icon()
		else
			wander = 0
			if(prob(15) && speech_fleeing.len)
				attached.say("[pick(speech_fleeing)]")

		if(flee_target)
			move_target = flee_target
			stationary_target = 1

	if(!move_target && wander && (!wander_prob || prob(wander_prob)) && isturf(attached.loc) && attached.canmove && !attached.resting && \
			 !attached.buckled && (!can_be_restrained || !attached.pulledby))

		attached.set_dir(pick(cardinal))
		var/turf/T = get_step(get_turf(attached),attached.dir)
		if(move_target_is_suitable(T))
			move_target = T
			stationary_target = 1

	if(move_target && istype(attached.loc, /turf))
		if(move_target == attached.loc || attached.Adjacent(move_target))
			move_target = null
			walk(attached, 0)
		else
			walk_to(attached, move_target, (stationary_target ? 0 : 1), ((panicked>0 || enraged>0) ? attached.movement_delay() : (attached.movement_delay()*2)))
	else
		walk(attached, 0)

/datum/ai_mob/animal/proc/handle_special()
	set waitfor = 0
	sleep(5)
	return

/datum/ai_mob/animal/proc/handle_target()
	return

/datum/ai_mob/animal/process(var/forced)

	if(!attached)
		qdel(src)
		return PROCESS_KILL

	if(!forced && world.time < next_process)
		return

	next_process = world.time + process_delay

	if(attached.client)
		stop_moving()
		return

	handle_prelim_behavior()

	if(attached.stat == UNCONSCIOUS)
		handle_unconscious()
	else if(attached.stat == DEAD)
		handle_dead()
	else
		handle_target()
		handle_movement()
		handle_emotes()
		handle_special()

	handle_post_behavior()

/datum/ai_mob/animal/proc/handle_unconscious()
	stop_moving()

/datum/ai_mob/animal/proc/handle_dead()
	stop_moving()

/datum/ai_mob/animal/stop_moving()
	..()
	move_target = null
	flee_target = null
	walk(attached, 0)
	attached.update_icon()

/datum/ai_mob/animal/proc/handle_prelim_behavior()
	return

/datum/ai_mob/animal/proc/handle_post_behavior()
	return

/datum/ai_mob/animal/proc/move_target_is_suitable(var/check_move_target)
	var/turf/T = get_turf(check_move_target)
	if(istype(T))
		if(panicked>0) // Running blindly.
			return 1
		if(T.is_flooded() && !(attached.mob_behavior_flags & SWIMMER))
			return 0
		if(T.open_space && !(attached.mob_behavior_flags & FLIER))
			return 0
		if(T.density && !(attached.mob_behavior_flags & ETHEREAL))
			return 0
		return (attached.mob_behavior_flags & TERRAN)
	return 0

/datum/ai_mob/animal/cow
	name = "cow"

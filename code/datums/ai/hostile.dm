/datum/ai_mob/animal/hostile

	name = "hostile animal"
	process_delay = 15
	wander_prob = 20 //  Hunter mobs process a lot more often, so should wander less.

	var/mob/living/kill_target
	var/list/speech_attacking = list()
	var/list/emote_attacking = list()
	var/list/prey_types = list(/mob/living)
	var/kill_unconscious_targets = 0
	var/savage = 1

/datum/ai_mob/animal/hostile/receive_hostile_interaction(var/atom/aggressor)
	if(!attached.client && attached.stat != DEAD && \
	 savage && enraged==0 && !kill_target && istype(kill_target, /mob/living))
		enraged = 1
		set_kill_target(aggressor)
		attached.update_icon()
		process(force=1)
		return
	return ..()

/datum/ai_mob/animal/hostile/proc/is_suitable_prey(var/mob/living/evaluating)
	if(evaluating.stat == CONSCIOUS || kill_unconscious_targets)
		for(var/preytype in prey_types)
			if(istype(evaluating, preytype))
				return 1
	return 0

/datum/ai_mob/animal/hostile/handle_target()

	if(kill_target && (kill_target.stat == DEAD || (get_dist(get_turf(attached), get_turf(kill_target)) > world.view)))
		set_kill_target()

	if(!kill_target)

		var/list/potential_prey = list()
		for(var/mob/living/prey in range(attached, 7))

			if(prey == attached || (attached.faction && attached.faction != "neutral" && prey.faction == attached.faction))
				continue

			if(is_suitable_prey(prey))
				potential_prey += prey

		if(potential_prey.len)
			var/current_highest_target
			var/current_highest_score

			for(var/mob/living/prey in potential_prey)

				if(!current_highest_target)
					current_highest_target = prey
					current_highest_score = get_threat_score(prey)
					continue

				var/tmp_score = get_threat_score(prey)
				if((tmp_score > current_highest_score) || ((tmp_score == current_highest_score) && prob(50)))
					current_highest_target = prey
					current_highest_score = tmp_score

			set_kill_target(current_highest_target)

	if(kill_target)

		if(enraged==0)
			enraged = 1
			attached.update_icon()

		if(obstacle_destroyer)
			var/turf/simulated/T = get_step(get_turf(attached), get_dir(attached, get_turf(kill_target)))
			if(istype(T))
				if(istype(T, /turf/simulated/wall))
					if(T.density)
						attached.set_dir(get_dir(attached, T))
						attached.UnarmedAttack(T)
				else if(!T.density)
					for(var/obj/structure/S in T)
						if(S.Adjacent(attached) && S.density)
							attached.UnarmedAttack(S)
							break

		if(prob(15))
			var/mob/living/prey = kill_target
			if(!istype(prey))
				return
			if(speech_attacking.len && emote_attacking.len)
				if(prob(50))
					attached.say("[replacetext(pick(speech_attacking), "$PREY", "\the [prey]")]")
				else
					attached.custom_emote(2,"[replacetext(pick(emote_attacking), "$PREY", "\the [prey]")]")
			else if(speech_attacking.len)
				attached.say("[replacetext(pick(speech_attacking), "$PREY", "\the [prey]")]")
			else if(emote_attacking.len)
				attached.custom_emote(2,"[replacetext(pick(emote_attacking), "$PREY", "\the [prey]")]")
	else
		if(enraged>0)
			enraged = initial(enraged)
			attached.update_icon()
		return

/datum/ai_mob/animal/hostile/handle_movement()
	if(panicked<=0)
		if(kill_target)
			wander = 0
			move_target = kill_target
		else
			wander = initial(wander)
	return ..()

/datum/ai_mob/animal/hostile/handle_special()

	..()

	if(attached.stat || attached.resting || attached.buckled)
		return 1

	if(kill_target)

		var/mob/living/prey = kill_target

		if(istype(prey))

			if(prey.Adjacent(attached) && prey.stat != DEAD)
				attached.set_dir(get_dir(attached, prey))
				attached.UnarmedAttack(prey)
				return 1

		if(prey.stat == DEAD)
			set_kill_target()
			move_target = null
			if(enraged>0)
				enraged = initial(enraged)
				attached.update_icon()

/datum/ai_mob/animal/hostile/set_kill_target(var/mob/new_kill_target)
	kill_target = new_kill_target
	if(kill_target && behavior_type == MOB_AI_HERD)
		for(var/mob/living/animal/M in range(attached, world.view))
			if(!M.mob_ai || M.client || M.stat || M.mob_ai.behavior_type != MOB_AI_HERD || next_process <= M.mob_ai.next_process \
			 || M.mob_ai.enraged>0 || M.mob_ai.panicked>0 || M.faction != attached.faction)
				continue
			M.mob_ai.set_kill_target(new_kill_target)
			M.mob_ai.process(forced=1)

/datum/ai_mob/animal/hostile/proc/get_threat_score(var/mob/living/evaluating)
	return 1

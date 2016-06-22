// Cats are -weird-.
/datum/ai_mob/animal/hostile/cat
	name = "cat"
	savage = 0
	speak = list("Meow!","Esp!","Purr!","HSSSSS!")
	speak_chance = 1
	speech_fleeing = list("HSSSSS!")
	speech_attacking = list("MROWWRR!")
	idle_emotes = list("shakes their head", "shivers")
	emote_attacking = list("hisses and spits!","mrowls fiercely!","eyes $PREY hungrily.")
	prey_types = list(/mob/living/animal/mouse)

	var/mob/living/human/friend
	var/befriend_job = null

/datum/ai_mob/animal/hostile/cat/handle_special()

	if(..())
		return // Some other behavior happened, or we're not in a fit state to act.

	if(friend)
		if (get_dist(attached, friend) <= 1)
			if((friend.stat >= DEAD || friend.health <= config.health_threshold_softcrit) && prob((friend.stat < DEAD)? 50 : 15))
				var/use_verb = pick("meows", "mews", "mrowls")
				attached.custom_emote(2, pick("[use_verb] in distress.", "[use_verb] anxiously."))
				return 1
			else if(prob(5))
				attached.custom_emote(1, pick("nuzzles [friend].","brushes against [friend].","rubs against [friend].","purrs."))
				return 1
		else if (friend.health <= 50)
			if (prob(10))
				attached.custom_emote(2, "[pick("meows", "mews", "mrowls")] anxiously.")
				return 1

		 //spooky
		if(prob(2))
			var/mob/dead/observer/spook = locate() in range(attached, 5)
			if(spook)
				var/turf/T = spook.loc
				var/list/visible = list()
				for(var/obj/O in T.contents)
					if(!O.invisibility && O.name)
						visible += O
				if(visible.len)
					var/atom/A = pick(visible)
					attached.custom_emote(1, "suddenly stops and stares at something unseen[istype(A) ? " near [A]":""].")

/datum/ai_mob/animal/hostile/cat/handle_movement()
	if(friend && !(move_target || kill_target || flee_target) && !(enraged || panicked))
		var/follow_dist = rand(3,5)
		if (friend.stat != CONSCIOUS || friend.health <= config.health_threshold_softcrit) //danger
			follow_dist = 1
		else if (friend.stat || friend.health <= 50) //danger or just sleeping
			follow_dist = 2
		var/current_dist = get_dist(attached, friend)
		if(current_dist > follow_dist && (friend in range(attached, 10)))
			move_target = friend

	return ..()

/datum/ai_mob/animal/hostile/cat/receive_friendly_interaction(var/mob/user)

	if(!..() || prob(25))
		return

	var/bellyrub = user.zone_sel.selecting == BP_GROIN
	if(bellyrub || prob(1))
		user << "<span class='danger'>You[bellyrub ? "" : " accidentally"] pet \the [attached]'s belly!</span>"
		attached.set_dir(get_dir(attached, user))
		attached.UnarmedAttack(user)
		receive_hostile_interaction(user)
		return

	sleep(rand(10,20))

	if(!enraged && !panicked && user && attached && attached.Adjacent(user))
		attached.custom_emote(1, pick("nuzzles [user].","brushes against [user].","rubs against [user].","purrs."))

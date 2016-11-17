/decl/psychic_faculty/coercion
	name = PSYCHIC_COERCION
	colour = "#3399ff"
	powers = list(
		/datum/psychic_power/latent,
		/datum/psychic_power/spasm,
		/datum/psychic_power/agony,
		/datum/psychic_power/blindstrike,
		/datum/psychic_power/mindream
		)

/datum/psychic_power/spasm
	name = "Spasm"
	description = "Break their hold on their tools with hand spasms."
	target_ranged = 1
	target_melee = 1
	target_mob_only = 1
	melee_power_cost = 10
	ranged_power_cost = 15
	time_cost = 100

/datum/psychic_power/spasm/do_proximity(var/mob/living/user, var/atom/target)
	if(..())
		cramp(user, target)
		return TRUE
	return FALSE

/datum/psychic_power/spasm/do_ranged(var/mob/living/user, var/atom/target)
	if(..())
		cramp(user, target)
		return TRUE
	return FALSE

/datum/psychic_power/spasm/proc/cramp(var/mob/living/user, var/mob/living/target)

	user << "<span class='danger'>You stab a lance of psipower into \the [target]'s muscles!</span>"

	if(target.stat != CONSCIOUS)
		return

	target << "<span class='danger'>The muscles in your hands cramp horrendously!</span>"
	if(prob(75)) target.emote("scream")
	if(prob(75) && target.l_hand && !target.l_hand.abstract && target.unEquip(target.l_hand))
		target.visible_message("<span class='danger'>\The [target] drops what they were holding as their left hand spasms!</span>")
	if(prob(75) && target.r_hand && !target.r_hand.abstract && target.unEquip(target.r_hand))
		target.visible_message("<span class='danger'>\The [target] drops what they were holding as their right hand spasms!</span>")

/datum/psychic_power/blindstrike
	name = "Blindstrike"
	description = "Strike them deaf and blind."
	target_ranged = 1
	target_melee = 1
	target_mob_only = 1
	melee_power_cost = 8
	ranged_power_cost = 8
	time_cost = 50

/datum/psychic_power/blindstrike/do_proximity(var/mob/living/user, var/atom/target)
	if(..())
		blind(user, target)
		return TRUE
	return FALSE

/datum/psychic_power/blindstrike/do_ranged(var/mob/living/user, var/atom/target)
	if(..())
		blind(user, target)
		return TRUE
	return FALSE

/datum/psychic_power/blindstrike/proc/blind(var/mob/living/user, var/mob/living/target)

	user << "<span class='danger'>You overwhelm \the [target]'s senses with a blast of mental white noise!</span>"

	if(target.stat != CONSCIOUS)
		return

	if(prob(60))
		target.emote("scream")
	target << "<span class='danger'>Your sense are blasted into oblivion by a burst of mental static!</span>"
	target.flash_eyes()
	target.eye_blind = max(target.eye_blind,10)
	target.ear_deaf = max(target.ear_deaf,10)

/datum/psychic_power/agony
	name = "Agony"
	description = "Wrack them with crippling pain."
	target_melee = 1
	target_mob_only = 1
	melee_power_cost = 8
	time_cost = 50

/datum/psychic_power/agony/do_proximity(var/mob/living/user, var/atom/target)
	if(..())
		var/mob/living/M = target
		user.visible_message("<span class='danger'>\The [target] has been struck by \the [user]!</span>")
		playsound(user.loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)
		M.stun_effect_act(0, 60, user.zone_sel.selecting)
		return TRUE
	return FALSE

/datum/psychic_power/mindream
	name = "Mind Ream"
	description = "Make them belong to you, mind and soul."
	target_ranged = 0
	target_melee = 1
	target_mob_only = 1
	time_cost = 9000
	melee_power_cost = 28

/datum/psychic_power/mindream/do_proximity(var/mob/living/user, var/atom/target)
	if(do_redactive_living_check(user, target))
		var/mob/living/M = target

		if(M.stat == DEAD || (M.status_flags & FAKEDEATH))
			user << "<span class='warning'>\The [target] is dead!</span>"
			return FALSE

		if(!M.mind || !M.key)
			user << "<span class='warning'>\The [target] is mindless!</span>"
			return FALSE

		if(thralls.is_antagonist(M.mind))
			user << "<span class='warning'>\The [target] is already in thrall to someone!</span>"
			return FALSE

		if(..())
			user.visible_message("<span class='danger'><i>\The [user] seizes the head of \the [target] in both hands...</i></span>")
			user << "<span class='warning'>You plunge your mentality into that of \the [target]...</span>"
			target << "<span class='danger'>Your mind is invaded by the presence of \the [user]! They are trying to make you a slave!</span>"

			if(!do_after(user, M.stat == CONSCIOUS ? 80 : 40, target, 0, 1))
				user.backblast(rand(25,45)) // Almost certainly going to kill you.
				return TRUE

			user << "<span class='danger'>You sear through \the [target]'s neurons, reshaping as you see fit and leaving them subservient to your will!</span>"
			target << "<span class='danger'>Your defenses have eroded away and \the [user] has made you their mindslave.</span>"
			thralls.add_antagonist(M.mind, new_controller = user)
			return TRUE

	return FALSE

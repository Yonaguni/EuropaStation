/datum/psi_complexus/proc/update(var/force)

	var/last_rating = rating
	var/highest_faculty
	var/combined_rank = 0
	for(var/faculty in ranks)
		var/check_rank = get_rank(faculty)
		if(check_rank <= 0)
			ranks -= faculty
			LAZYREMOVE(latencies, faculty)
		else if(check_rank == 1)
			LAZYADD(latencies, faculty)
		else
			LAZYREMOVE(latencies, faculty)
		combined_rank += check_rank
		if(!highest_faculty || get_rank(highest_faculty) < check_rank)
			highest_faculty = faculty

	UNSETEMPTY(latencies)

	if(force || last_rating != ceil(combined_rank/ranks.len))
		rebuild_power_cache = TRUE
		if(combined_rank > 0)
			owner << 'sound/effects/psi/power_unlock.ogg'
			rating = ceil(combined_rank/ranks.len)
			cost_modifier = 1
			if(rating > 1) cost_modifier -= min(1, max(0.1, (rating-1) / 10))
			if(!ui)
				ui = new(owner)
				if(owner.client)
					owner.client.screen += ui.components
					owner.client.screen += ui
			else
				if(owner.client)
					owner.client.screen |= ui.components
					owner.client.screen |= ui
			owner.verbs |= /mob/living/proc/say_telepathy
			if(!suppressed && owner.client)
				for(var/thing in all_aura_images)
					owner.client.images |= thing

			if(rating >= PSI_RANK_PARAMOUNT) // spooky boosters
				aura_color = "#AAFFAA"
				aura_image.blend_mode = BLEND_SUBTRACT
			else
				aura_image.blend_mode = BLEND_MULTIPLY
				if(highest_faculty == PSI_COERCION)
					aura_color = "#CC3333"
				else if(highest_faculty == PSI_PSYCHOKINESIS)
					aura_color = "#3333CC"
				else if(highest_faculty == PSI_REDACTION)
					aura_color = "#33CC33"
				else if(highest_faculty == PSI_ENERGISTICS)
					aura_color = "#CCCC33"
		else
			qdel(src)

/datum/psi_complexus/process()

	var/update_hud
	if(stun)
		stun--
		if(stun)
			if(!suppressed)
				suppressed = TRUE
				update_hud = TRUE
		else
			to_chat(owner, "<span class='notice'>You have recovered your mental composure.</span>")
			update_hud = TRUE
		return

	if(owner.do_psionics_check())
		if(stamina > 15)
			stamina = max(0, stamina - rand(3,5))
			if(prob(5)) to_chat(owner, "<span class='danger'>You feel your psi-power leeched away into the void...</span>")
		else
			stamina++
		return

	else if(stamina < max_stamina)
		if(owner.stat == CONSCIOUS)
			stamina = min(max_stamina, stamina + rand(1,3))
		else if(owner.stat == UNCONSCIOUS)
			stamina = min(max_stamina, stamina + rand(3,5))

	if(owner.stat == CONSCIOUS && stamina && !suppressed && get_rank(PSI_REDACTION) >= PSI_RANK_OPERANT)
		attempt_regeneration()

	var/next_aura_size = max(1,(stamina/max_stamina)*min(3,rating))
	var/next_aura_alpha = round(((suppressed ? max(0,rating - 2) : rating)/5)*255)

	if(next_aura_alpha != last_aura_alpha || next_aura_size != last_aura_size || aura_color != last_aura_color)
		last_aura_size =  next_aura_size
		last_aura_alpha = next_aura_alpha
		last_aura_color = aura_color
		var/matrix/M = matrix()
		if(next_aura_size != 1)
			M.Scale(next_aura_size)
		animate(aura_image, alpha = next_aura_alpha, transform = M, color = aura_color, time = 3)

	if(update_hud)
		ui.update_icon()

/datum/psi_complexus/proc/attempt_regeneration()

	var/heal_general =  FALSE
	var/heal_poison =   FALSE
	var/heal_bleeding = FALSE
	var/heal_rate =     0
	var/mend_prob =     0

	var/use_rank = get_rank(PSI_REDACTION)
	if(use_rank >= PSI_RANK_PARAMOUNT)
		heal_general = TRUE
		heal_poison = TRUE
		heal_bleeding = TRUE
		mend_prob = 50
		heal_rate = 7
	else if(use_rank == PSI_RANK_GRANDMASTER)
		heal_bleeding = TRUE
		heal_poison = TRUE
		mend_prob = 20
		heal_rate = 5
	else if(use_rank == PSI_RANK_MASTER)
		heal_bleeding = TRUE
		mend_prob = 10
		heal_rate = 3
	else if(use_rank == PSI_RANK_OPERANT)
		heal_bleeding = TRUE
		heal_rate = 1
	else
		return

	if(!heal_rate || stamina < heal_rate)
		return // Don't backblast from trying to heal ourselves thanks.

	if(ishuman(owner))

		var/mob/living/carbon/human/H = owner

		// Mend internal damage.
		if(prob(mend_prob))

			// Heal organ damage.
			for(var/obj/item/organ/I in H.internal_organs)

				if(I.robotic >= ORGAN_ROBOT)
					continue

				if(I.damage > 0 && spend_power(heal_rate))
					I.damage = max(I.damage - heal_rate, 0)
					if(prob(5))
						to_chat(H, "<span class='notice'>Your innards itch as your autoredactive faculty mends your [I.parent_organ].</span>")
					return

			// Heal broken bones.
			if(H.bad_external_organs.len)
				for(var/obj/item/organ/external/E in H.bad_external_organs)

					if(E.robotic >= ORGAN_ROBOT)
						continue

					if ((E.status & ORGAN_BROKEN) && E.damage < (E.min_broken_damage * config.organ_health_multiplier)) // So we don't mend and autobreak.
						if(spend_power(heal_rate))
							if(E.mend_fracture())
								to_chat(H, "<span class='notice'>Your autoredactive faculty coaxes together the shattered bones in your [E.name].</span>")
								return

					if(heal_bleeding)

						for(var/datum/wound/W in E.wounds)

							if(W.internal && spend_power(heal_rate))
								to_chat(H, "<span class='notice'>Your autoredactive faculty mends the torn veins in your [E.name], stemming the internal bleeding.</span>")
								E.wounds -= W
								E.update_damages()
								return

							if(W.bleeding() && spend_power(heal_rate))
								to_chat(H, "<span class='notice'>Your autoredactive faculty knits together severed veins, stemming the bleeding from your [E.name].</span>")
								W.bleed_timer = 0
								E.status &= ~ORGAN_BLEEDING
								return

	// Heal radiation, cloneloss and poisoning.
	if(heal_poison)
		if(owner.radiation && spend_power(heal_rate))
			if(prob(5)) to_chat(owner, "<span class='notice'>Your autoredactive faculty repairs some of the radiation damage to your body.</span>")
			owner.radiation = max(0, owner.radiation - heal_rate)
			return

		if(owner.getCloneLoss() && spend_power(heal_rate))
			if(prob(5)) to_chat(owner, "<span class='notice'>Your autoredactive faculty stitches together some of your mangled DNA.</span>")
			owner.adjustCloneLoss(-heal_rate)
			return

		if(owner.getToxLoss() && spend_power(heal_rate))
			if(prob(5)) to_chat(owner, "<span class='notice'>Your autoredactive faculty purges some of the toxins infusing your body.</span>")
			owner.adjustToxLoss(-heal_rate)
			return

	// Heal everything left.
	if(heal_general && owner.health < owner.maxHealth && spend_power(heal_rate))
		owner.adjustBruteLoss(-(heal_rate))
		owner.adjustFireLoss(-(heal_rate))
		owner.adjustOxyLoss(-(heal_rate))
		if(prob(5)) to_chat(owner, "<span class='notice'>Your skin crawls as your autoredactive faculty heals your body.</span>")
		return

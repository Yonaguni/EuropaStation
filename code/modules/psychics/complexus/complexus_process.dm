/datum/psi_complexus/proc/update(var/force)

	var/last_rating = rating
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
	UNSETEMPTY(latencies)

	if(force || 	last_rating != ceil(combined_rank/ranks.len))
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
		else
			owner.verbs -= /mob/living/proc/say_telepathy
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
	else if(stamina < max_stamina)
		if(owner.stat == CONSCIOUS)
			stamina = min(max_stamina, stamina + rand(1,3))
			//if(stamina && !suppressed && get_rank(PSI_REDACTION) >= PSI_RANK_OPERANT && owner.health < owner.maxHealth)
			//	attempt_autoredaction()
		else if(owner.stat == UNCONSCIOUS)
			stamina = min(max_stamina, stamina + rand(3,5))

	if(update_hud)
		ui.update_icon()

	//if(aura) aura.update_icon(TRUE)

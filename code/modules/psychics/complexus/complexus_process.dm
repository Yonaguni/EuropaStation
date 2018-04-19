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
			if(owner.client)
				for(var/thing in all_aura_images)
					owner.client.images |= thing
		else
			owner.verbs -= /mob/living/proc/say_telepathy
			if(owner.client)
				for(var/thing in all_aura_images)
					owner.client.images -= thing
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
			if(stamina && !suppressed && get_rank(PSI_REDACTION) >= PSI_RANK_OPERANT && owner.health < owner.maxHealth)
				attempt_regeneration()
		else if(owner.stat == UNCONSCIOUS)
			stamina = min(max_stamina, stamina + rand(3,5))

	var/next_aura_size = max(1,(stamina/max_stamina)*rating)
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

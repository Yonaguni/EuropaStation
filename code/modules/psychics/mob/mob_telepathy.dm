/mob/living/proc/say_telepathy(message as text)

	set name = "Broadcast"
	set category = "IC"

	if(client && (client.prefs.muted & MUTE_IC))
		to_chat(src, "<span class='warning'>You cannot speak in IC (Muted).</span>")
		return

	message = sanitize(message)

	if(stat)
		if(stat == DEAD)
			return say_dead(message)
		return

	if(incapacitated())
		return

	if(!psi)
		verbs -= /mob/living/proc/say_telepathy
		return

	var/broadcast_range = 2 + psi.rating
	if(broadcast_range <= 3)
		verbs -= /mob/living/proc/say_telepathy
		return

	if(psi.suppressed)
		to_chat(src, "<span class='warning'>You are suppressing your psi-power and cannot speak telepathically.</span>")
		return

	if(!psi.use_intimate_mode)
		broadcast_range *= 10

	if(psi.use_intimate_mode)
		to_chat(src, "<span class='notice'>You transmit on the intimate telepathic mode, \"[message]\".</span>")
		psi.set_cooldown(20)
	else
		to_chat(src, "<span class='notice'>You broadcast on the declamatory telepathic mode, \"[message]\".</span>")
		psi.set_cooldown(200)

	if(psi.use_intimate_mode)
		message = "<span class='notice'><b>\The [real_name]</b> transmits on the intimate telepathic mode, \"[message]\".</span>"
	else
		message = "<span class='notice'><b>\The [real_name]</b> broadcasts on the declamatory telepathic mode, \"[message]\".</span>"

	for(var/thing in clients)
		var/client/C = thing
		if(C.mob == src)
			continue
		else if(C.mob.stat == DEAD && !istype(C.mob, /mob/new_player))
			if(get_dist(src, C.mob) <= broadcast_range)
				to_chat(C.mob, "<b>[message]</b>")
			else if(C.mob.is_preference_enabled(/datum/client_preference/ghost_ears))
				to_chat(C.mob, "[message]")
		else if(ishuman(C.mob) && get_dist(src, C.mob) <= broadcast_range)
			var/mob/living/H = C.mob
			if(H.stat == CONSCIOUS && H.psi && !H.psi.suppressed && H.psi.rating)
				to_chat(H, message)

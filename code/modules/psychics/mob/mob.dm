/mob/living
	var/datum/psi_complexus/psi

/mob/living/Login()
	. = ..()
	if(psi)
		psi.update(TRUE)

/mob/living/Destroy()
	if(psi) qdel(psi)
	. = ..()

/mob/living/proc/set_psi_rank(var/faculty, var/rank, var/take_larger, var/defer_update, var/temporary)
	if(!psi)
		psi = new(src)
	if(!HAS_ASPECT(src, ASPECT_PSI_ROOT))
		ADD_ASPECT(src, ASPECT_PSI_ROOT)
	var/current_rank = psi.get_rank(faculty)
	if(current_rank != rank && (!take_larger || current_rank < rank))
		psi.set_rank(faculty, rank, defer_update, temporary)

/mob/living/proc/announce_psionics()
	if(client && psi)
		to_chat(src, "<span class='notice'>You are <b>psionic</b>, touched by <b>the Signal</b>, and your mind is capable of manipulating and channeling the <b>Bright Continua</b>.</span>")
		var/latent_only = TRUE
		for(var/rank in psi.base_ranks)
			if(psi.base_ranks[rank] > 1)
				latent_only = FALSE
		if(latent_only)
			to_chat(src, "<span class='notice'>Your powers are <b>latent</b>, shackled behind mental blocks, and only certain kinds of stress will bring them to the surface. This will always come at a cost...</span>")
		else
			to_chat(src, "<span class='notice'>Your powers are <b>operant</b> and are freely usable. <b>Shift-left-click your Psi icon</b> on the bottom right to <b>view a summary of how to use them</b>, or <b>left click</b> it to <b>suppress or unsuppress</b> your psi.</span>")
			to_chat(src, "<span class='notice'>While suppressed, your psionic aura is hidden, and you will appear to be non-operant. However, you will not be able to use your powers in this state.</span>")
			to_chat(src, "<span class='notice'>Beware of overusing your gifts, as draining your psi-stamina too low can have <b>deadly consequences</b>.</span>")

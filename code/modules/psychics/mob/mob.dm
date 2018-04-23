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
			to_chat(src, "<span class='notice'>Your powers are <b>operant</b> and are freely usable. <b>Shift-left-click your Psi icon</b> on the bottom right to <b>view a summary of how to use them</b>, or <b>left click</b> it to <b>suppress or unsuppress</b> your psi. While suppressed, your psionic aura is hidden, but you will not be able to use your powers. Beware of overusing your gifts, as draining your psi-stamina too low can have <b>deadly consequences</b>.</span>")

/mob/living/carbon/human/announce_psionics()
	. = ..()
	if(client && psi)
		var/obj/item/implant/psi_control/imp = new()
		imp.implanted(src)
		imp.forceMove(src)
		imp.imp_in = src
		imp.implanted = 1
		var/obj/item/organ/external/affected = get_organ(BP_HEAD)
		if(affected)
			affected.implants += imp
			imp.part = affected
		ADD_PSI_NULL_ATOM(src, imp)

		to_chat(src, "<span class='danger'>As a registered psionic, you are fitted with a psi-dampening control implant. Using psi-power while the implant is active will result in neural shocks and your violation being reported.</span>")

/mob/living/animal/attackby(var/obj/item/O, var/mob/user)

	if(!O.force)
		visible_message("<span class='notice'>[user] gently taps [src] with \the [O].</span>")
	else
		O.attack(src, user, user.zone_sel.selecting)
		if(mob_ai && !client) mob_ai.receive_hostile_interaction(user)

/mob/living/animal/attack_hand(var/mob/living/human/M)

	..()

	switch(M.a_intent)

		if(I_HELP)
			M.visible_message("<span class='notice'>\The [M] [help_interaction_text] \the [src].</span>")
			if(mob_ai) mob_ai.receive_friendly_interaction(M)

		if(I_DISARM)
			M.visible_message("<span class='notice'>\The [M] [disarm_interaction_text] \the [src].</span>")
			M.do_attack_animation(src)
			if(mob_ai) mob_ai.receive_neutral_interaction(M)

		if(I_GRAB)
			if(M == src || !(status_flags & CANPUSH))
				return
			var/obj/item/weapon/grab/G = new(M, src)
			M.put_in_active_hand(G)
			G.synch()
			G.affecting = src
			LAssailant = M
			M.visible_message("<span class='warning'>\The [M] has grabbed [src] passively!</span>")
			if(mob_ai) mob_ai.receive_neutral_interaction(M)
			M.do_attack_animation(src)

		if(I_HURT)
			M.visible_message("<span class='danger'>\The [M] [harm_interaction_text] \the [src]!</span>")
			if(mob_ai) mob_ai.receive_hostile_interaction(M)
			adjustBruteLoss(rand(3,5)) //todo
			M.do_attack_animation(src)


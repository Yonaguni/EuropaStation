/mob/living/UnarmedAttack(var/atom/A, var/proximity)
	if(psi && psi.can_use())
		for(var/thing in psi.get_melee_powers(intent_to_psi_faculty[a_intent]))
			var/decl/psipower/power = thing
			if(power.use_melee && !power.use_grab && power.invoke(src, A))
				return
	. = ..()

/mob/living/RangedAttack(var/atom/A, var/proximity)
	if(psi && psi.can_use())
		for(var/thing in psi.get_ranged_powers(intent_to_psi_faculty[a_intent]))
			var/decl/psipower/power = thing
			if(power.use_ranged && !power.use_grab && power.invoke(src, A))
				return TRUE
	. = ..()

/mob/living/proc/check_psi_grab(var/obj/item/grab/grab)
	if(psi && psi.can_use() && grab.affecting_mob)
		var/list/psi_powers = psi.get_grab_powers(intent_to_psi_faculty[a_intent])
		for(var/thing in psi_powers)
			var/decl/psipower/power = thing
			if(power.use_grab && power.invoke(src, grab.affecting_mob))
				return TRUE
	return FALSE

/mob/living/attack_empty_hand(var/bp_hand)
	if(psi && psi.can_use())
		for(var/thing in psi.get_manifestations())
			var/decl/psipower/power = thing
			var/obj/item/result = power.invoke(src, src)
			if(istype(result))
				LAZYADD(psi.manifested_items, result)
				put_in_hands(result)
				return TRUE
	. = ..()
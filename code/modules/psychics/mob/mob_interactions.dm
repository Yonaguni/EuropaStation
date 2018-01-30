#define INVOKE_PSI_POWERS(holder, powers, target) \
	if(holder && holder.psi && holder.psi.can_use()) { \
		for(var/thing in powers) { \
			var/decl/psipower/power = thing; \
			var/obj/item/result = power.invoke(holder, target); \
			if(result) { \
				if(istype(result)) { \
					holder << 'sound/effects/psi/power_evoke.ogg'; \
					LAZYADD(holder.psi.manifested_items, result); \
					holder.put_in_hands(result); \
				} \
				return TRUE; \
			} \
		} \
	}

/mob/living/UnarmedAttack(var/atom/A, var/proximity)
	if(psi)
		INVOKE_PSI_POWERS(src, psi.get_melee_powers(intent_to_psi_faculty[a_intent]), A)
	. = ..()

/mob/living/RangedAttack(var/atom/A, var/proximity)
	if(psi)
		INVOKE_PSI_POWERS(src, psi.get_ranged_powers(intent_to_psi_faculty[a_intent]), A)
	. = ..()

/mob/living/proc/check_psi_grab(var/obj/item/grab/grab)
	if(psi && grab.affecting_mob)
		INVOKE_PSI_POWERS(src, psi.get_grab_powers(intent_to_psi_faculty[a_intent]), grab.affecting_mob)
	. = ..()

/mob/living/attack_empty_hand(var/bp_hand)
	if(psi)
		INVOKE_PSI_POWERS(src, psi.get_manifestations(), src)
	. = ..()

#undef INVOKE_PSI_POWERS
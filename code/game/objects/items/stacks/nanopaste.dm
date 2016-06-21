/obj/item/stack/nanopaste
	name = "nanopaste"
	singular_name = "nanite swarm"
	desc = "A tube of paste containing swarms of repair nanites. Very effective in repairing robotic machinery."
	icon = 'icons/obj/nanopaste.dmi'
	icon_state = "tube"
	amount = 10


/obj/item/stack/nanopaste/attack(mob/living/M as mob, mob/user as mob)
	if (!istype(M) || !istype(user))
		return 0

	if (istype(M,/mob/living/human))		//Repairing robolimbs
		var/mob/living/human/H = M
		var/obj/item/organ/external/S = H.get_organ(user.zone_sel.selecting)

		if(S.is_open() == 1)
			if (S && (S.status & ORGAN_ROBOT))
				if(S.get_damage())
					user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
					S.heal_damage(15, 15, robo_repair = 1)
					H.updatehealth()
					use(1)
					user.visible_message("<span class='notice'>\The [user] applies some nanite paste at[user != M ? " \the [M]'s" : " \the"][S.name] with \the [src].</span>",\
					"<span class='notice'>You apply some nanite paste at [user == M ? "your" : "[M]'s"] [S.name].</span>")
				else
					user << "<span class='notice'>Nothing to fix here.</span>"
		else
			if (can_operate(H))
				if (do_surgery(H,user,src))
					return
			else
				user << "<span class='notice'>Nothing to fix in here.</span>"

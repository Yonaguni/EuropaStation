//There has to be a better way to define this shit. ~ Z
//can't equip anything
/mob/living/carbon/alien/attack_ui(slot_id)
	return

/mob/living/carbon/alien/attack_hand(var/mob/living/carbon/M)
	..()
	switch(M.a_intent)
		if (I_HELP)
			help_shake_act(M)
		else
			var/damage = rand(1, 9)
			if(prob(90))
				if(HULK in M.mutations)
					damage += 5
				playsound(loc, "punch", 25, 1, -1)
				visible_message("<span class='danger'>\The [M] punches \the [src]!</span>")
				if(damage > 5)
					visible_message("<span class='danger'>\The [src] is weakened by the blow!</span>")
					Weaken(rand(10,15))
				adjustBruteLoss(damage)
				updatehealth()
				if(HULK in M.mutations)
					Paralyse(1)
					throw_at(get_edge_target_turf(src,M.dir),3,50)
			else
				playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
				visible_message("<span class='danger'>\The [M] misses \the [src]!</span>")
	return
/mob/living/mecha/getarmor(var/def_zone, var/type)
	if(body.armour)
		return isnull(body.armour.armor[type]) ? 0 : body.armour.armor[type]
	return 0

/mob/living/mecha/updatehealth()
	health = body.mech_health - (getFireLoss()+getBruteLoss())

/mob/living/mecha/adjustFireLoss(var/amount)
	apply_damage(amount,BURN)

/mob/living/mecha/adjustBruteLoss(var/amount)
	apply_damage(amount,BRUTE)

/mob/living/mecha/apply_damage(var/damage = 0,var/damagetype = BRUTE, var/def_zone = null, var/blocked = 0, var/used_weapon = null, var/sharp = 0, var/edge = 0)
	if(!damage || damage <= 0 || (blocked >= 2))	return 0
	var/obj/item/mech_component/MC = pick(list(arms, legs, body, head))
	if(damagetype == BRUTE)
		MC.brute_damage += damage
	else if(damagetype == BURN)
		MC.burn_damage += damage
	else
		return
	MC.update_health()
	updatehealth()
	if(prob(damage*2))
		sparks.set_up(3, 0, src)
		sparks.start()

/mob/living/mecha/getFireLoss()
	var/total = 0
	for(var/obj/item/mech_component/MC in list(arms, legs, body, head))
		if(MC)
			total += MC.burn_damage
	return total

/mob/living/mecha/getBruteLoss()
	var/total = 0
	for(var/obj/item/mech_component/MC in list(arms, legs, body, head))
		if(MC)
			total += MC.brute_damage
	return total


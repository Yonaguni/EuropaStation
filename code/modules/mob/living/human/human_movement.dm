/mob/living/human/movement_delay()

	var/tally = 0

	if(species.slowdown)
		tally = species.slowdown

	if (istype(loc, /turf/space)) return -1 // It's hard to be slowed down in space by... anything

	if(embedded_flag)
		handle_embedded_objects() //Moving with objects stuck in you can cause bad times.

	if(CE_SPEEDBOOST in chem_effects)
		return -1

	var/health_deficiency = (maxHealth - health)
	if(health_deficiency >= 40) tally += (health_deficiency / 25)

	if(can_feel_pain())
		if(subdual >= 10) tally += (subdual / 10) //subdual shouldn't slow you down if you can't even feel it

	var/hungry = (500 - nutrition)/5
	if (hungry >= 70) tally += hungry/100
	var/thirsty = (500 - hydration)/5
	if (thirsty >= 70) tally += thirsty/100

	if(wear_suit)
		tally += wear_suit.slowdown

	if(shoes)
		tally += shoes.slowdown
	for(var/organ_name in list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT))
		var/obj/item/organ/external/E = get_organ(organ_name)
		if(!E || E.is_stump())
			tally += 4
		else if(E.status & ORGAN_SPLINTED)
			tally += 0.5
		else if(E.status & ORGAN_BROKEN)
			tally += 1.5

	if(shock_stage >= 10) tally += 3

	if(aiming && aiming.aiming_at) tally += 5 // Iron sights make you slower, it's a well-known fact.

	if (bodytemperature < 283.222)
		tally += (283.222 - bodytemperature) / 10 * 1.75

	tally += max(2 * stance_damage, 0) //damaged/missing feet or legs is slow

	return (tally+config.human_delay)

/mob/living/human/Process_Spacemove(var/check_drift = 0)
	if(restrained())
		return 0
	if(..())
		return 1
	return 0

/mob/living/human/slip_chance(var/prob_slip = 5)
	if(!..())
		return 0

	//Check hands and mod slip
	if(!l_hand)	prob_slip -= 2
	else if(l_hand.w_class <= 2)	prob_slip -= 1
	if (!r_hand)	prob_slip -= 2
	else if(r_hand.w_class <= 2)	prob_slip -= 1

	return prob_slip

/mob/living/human/Check_Shoegrip()
	if(species.flags & NO_SLIP)
		return 1
	if(shoes && (shoes.item_flags & NOSLIP))  //magboots + dense_object = no floating
		return 1
	return 0

/mob/living/human/Move(NewLoc, direct)
	. = ..()
	if(.)
		if(src.nutrition && src.stat != 2)
			src.nutrition -= DEFAULT_HUNGER_FACTOR/10
			src.hydration -= DEFAULT_HUNGER_FACTOR/10
			if(src.m_intent == "run")
				src.nutrition -= DEFAULT_HUNGER_FACTOR/10
				src.hydration -= DEFAULT_HUNGER_FACTOR/10

		// Moving around increases germ_level faster
		if(germ_level < GERM_LEVEL_MOVE_CAP && prob(8))
			germ_level++
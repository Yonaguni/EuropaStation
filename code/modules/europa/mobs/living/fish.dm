/mob/living/simple_animal/europa_fish
	name = "fish"
	desc = "Here, fishy fishy."
	icon = 'icons/mob/europa/aquatic.dmi'
	icon_state = "fish"

	speak_chance = 0
	turns_per_move = 5
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "bitten"
	attack_sound = 'sound/weapons/bite.ogg'
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

/mob/living/simple_animal/europa_fish/can_drown()
	return 0

/mob/living/simple_animal/europa_fish/New()
	..()
	icon_state = "[pick(list("fish","grump","content","judge"))]"
	icon_dead = "[icon_state]_dead"

/mob/living/simple_animal/hostile/retaliate/europa_shark
	name = "shark"
	desc = "We're going to need a bigger submarine."
	icon = 'icons/mob/europa/aquatic.dmi'
	icon_state = "shark"
	icon_dead = "shark_dead"

	speak_chance = 0
	turns_per_move = 5
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "bitten"
	attack_sound = 'sound/weapons/bite.ogg'
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	break_stuff_probability = 0

/mob/living/simple_animal/hostile/retaliate/europa_shark/can_drown()
	return 0

/mob/living/simple_animal/hostile/aquatic/shark
	name = "shark"
	desc = "A ferocious fish with many, many teeth."
	icon_state = "shark"
	icon_living = "shark"
	icon_dead = "shark_dead"
	maxHealth = 25
	health = 25
	meat_amount = 5
	harm_intent_damage = 8
	melee_damage_lower = 15
	melee_damage_upper = 15
	break_stuff_probability = 15
	faction = "sharks"
	meat_type = /obj/item/reagent_containers/food/snacks/meat/fish/shark

/mob/living/simple_animal/hostile/aquatic/shark/huge
	name = "gigacretoxyrhina"
	desc = "That is a lot of shark."
	icon = 'icons/mob/spaceshark.dmi'
	icon_state = "shark"
	icon_living = "shark"
	icon_dead = "shark_dead"
	meat_amount = 10
	turns_per_move = 2
	move_to_delay = 2
	attack_same = 1
	speed = 0
	mob_size = MOB_LARGE
	pixel_x = -16
	health = 150
	maxHealth = 150
	harm_intent_damage = 5
	melee_damage_lower = 20
	melee_damage_upper = 25
	break_stuff_probability = 35

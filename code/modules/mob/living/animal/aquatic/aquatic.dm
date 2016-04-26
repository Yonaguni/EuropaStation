/mob/living/animal/aquatic
	name = "fish"
	desc = "Here, fishy fishy."
	icon = 'icons/mob/creatures/aquatic.dmi'
	icon_state = "grump"
	icon_living = "grump"
	icon_dead = "grump_dead"
	icon_asleep = "grump_dying"
	min_oxygen = null
	meat_amount = 2
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/fillet
	mob_ai_type = /datum/ai_mob/animal/herd/fish
	faction = "small fish"
	mob_behavior_flags = SWIMMER

/mob/living/animal/aquatic/handle_environment()
	if(loc.is_flooded(1))
		paralysis = 0
		return ..(1)
	else
		paralysis = 10
		return ..(0)

/mob/living/animal/aquatic/handle_regular_status_updates()
	var/last_stat = stat
	. = ..()
	if(stat != last_stat)
		if(stat != CONSCIOUS && mob_ai)
			mob_ai.stop_moving()
		update_icon()

/mob/living/animal/aquatic/can_drown()
	return 0

/mob/living/animal/aquatic/random
	maxHealth = 5

/mob/living/animal/aquatic/random/initialize()
	..()
	icon_state = "[pick(list("grump","content","judge"))]"
	icon_living = "[icon_state]"
	icon_dead = "[icon_state]_dead"
	icon_asleep = "[icon_state]_dying"

/mob/living/animal/aquatic/shark
	name = "shark"
	desc = "We're going to need a bigger submarine."
	icon_state = "shark"
	icon_living = "shark"
	icon_dead = "shark_dead"
	icon_asleep = "shark_dying"
	meat_amount = 5
	melee_damage_lower = 16
	melee_damage_upper = 22
	mob_ai_type = /datum/ai_mob/animal/hostile/shark
	faction = "sharks"
	maxHealth = 120

/mob/living/animal/aquatic/carp
	name = "carp"
	desc = "A ferocious fanged fish. They might be too hardcore."
	icon_state = "carp"
	icon_living = "carp"
	icon_dead = "carp_dead"
	icon_asleep = "carp_dying"
	icon_gib = "carp_gib"
	meat_amount = 3
	melee_damage_lower = 6
	melee_damage_upper = 12
	mob_ai_type = /datum/ai_mob/animal/hostile/carp
	faction = "carp"
	maxHealth = 50

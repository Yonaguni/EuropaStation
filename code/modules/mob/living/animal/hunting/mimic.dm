var/global/list/protected_objects = list(
	/obj/structure/table,
	/obj/structure/window
	)

/mob/living/animal/mimic
	name = "crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/storage.dmi'
	icon_state = "crate"
	icon_living = "crate"

	help_interaction_text = "touches"
	disarm_interaction_text = "pushes"
	harm_interaction_text = "hits"
	animal_move_delay = 4
	maxHealth = 250
	melee_damage_lower = 13
	melee_damage_upper = 18

	faction = "mimics"
	mob_ai_type = /datum/ai_mob/animal/hostile/mimic

/mob/living/animal/mimic/death()
	..()
	qdel(src)

//
// Crate Mimic
//

// Aggro when you try to open them. Will also pickup loot when spawns and drop it when dies.
/mob/living/animal/mimic/crate
	attacktext = "bitten"
	mob_ai_type = /datum/ai_mob/animal/hostile/mimic/crate

// Pickup loot
/mob/living/animal/mimic/crate/initialize()
	..()
	for(var/obj/item/I in loc)
		if(!I.anchored)
			I.forceMove(src)

/mob/living/animal/mimic/crate/death()
	var/obj/structure/closet/crate/C = new(get_turf(src))
	// Put loot in crate
	for(var/obj/O in src)
		O.forceMove(C)
	..()

//
// Copy Mimic
//

/mob/living/animal/mimic/copy
	maxHealth = 100

/mob/living/animal/mimic/copy/death()
	for(var/atom/movable/M in src)
		M.forceMove(get_turf(src))
	..()

/mob/living/animal/mimic/copy/proc/copy_object(var/obj/O, var/mob/living/set_creator)

	if((istype(O, /obj/item) || istype(O, /obj/structure)) && !is_type_in_list(O, protected_objects))

		O.forceMove(src)
		name = O.name
		desc = O.desc
		icon = O.icon
		icon_state = O.icon_state
		icon_living = icon_state

		if(istype(O, /obj/structure))
			health = (O.anchored * 50) + 50
			if(O.density && O.anchored)
				melee_damage_lower *= 2
				melee_damage_upper *= 2

		else if(istype(O, /obj/item))
			var/obj/item/I = O
			health = 15 * I.w_class
			melee_damage_lower = 2 + I.force
			melee_damage_upper = 2 + I.force
			animal_move_delay = 2 * I.w_class

		maxHealth = health

		if(set_creator && mob_ai)
			mob_ai.set_ally(set_creator)
			faction = "[set_creator.real_name]"
		return 1
	return

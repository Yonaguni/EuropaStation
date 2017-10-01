/mob/living/simple_animal/aquatic
	icon = 'icons/mob/aquatic.dmi'
	meat_type = /obj/item/reagent_containers/food/snacks/meat/fish
	speak_chance = 1
	turns_per_move = 5
	attacktext = "bitten"
	attack_sound = 'sound/weapons/bite.ogg'
	speed = 4
	mob_size = MOB_SMALL
	emote_see = list("glubs", "blubs", "bloops")
	skin_type = null
	bone_type = null

	// They only really care if there's water around them or not.
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

/mob/living/simple_animal/aquatic/New()
	..()
	default_pixel_x = rand(-12,12)
	default_pixel_y = rand(-12,12)
	pixel_x = default_pixel_x
	pixel_y = default_pixel_y

/mob/living/simple_animal/aquatic/Life()
	if(!loc || !loc.is_flooded(1))
		if(icon_state == icon_living)
			icon_state = "[icon_living]_dying"
		SetStunned(3)
	. = ..()

/mob/living/simple_animal/aquatic/handle_atmos(var/atmos_suitable = 1)
	. = ..(atmos_suitable = (loc && loc.is_flooded(1)))

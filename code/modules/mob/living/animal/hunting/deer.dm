/mob/living/animal/deer
	name = "doe"
	icon_state = "doe"
	icon_living = "doe"
	icon_dead = "doe_dead"
	gender = FEMALE
	desc = "It's open season."
	maxHealth = 25
	meat_amount = 4
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/venison
	skull_type = /obj/item/bone/skull/deer
	faction = "deer"

	mob_ai_type = /datum/ai_mob/animal/herd/deer
	animal_move_delay = 5

/mob/living/animal/deer/initialize()
	..()
	if(prob(30))
		name = "buck"
		gender = MALE
		meat_amount = 6
		icon_state = "buck"
		icon_living = "buck"
		icon_dead = "buck_dead"
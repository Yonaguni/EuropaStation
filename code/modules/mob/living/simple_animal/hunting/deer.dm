/mob/living/simple_animal/deer
	name = "deer"
	icon_state = "doe"
	icon_living = "doe"
	icon_dead = "doe_dead"
	gender = FEMALE
	desc = "It's open season."
	health = 25
	maxHealth = 25
	meat_amount = 4
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/venison
	skull_type = /obj/item/bone/skull/deer

/mob/living/simple_animal/deer/initialize()
	..()
	if(prob(30))
		gender = MALE
		meat_amount = 6
		icon_state = "buck"
		icon_living = "buck"
		icon_dead = "buck_dead"

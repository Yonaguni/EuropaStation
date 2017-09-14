/mob/living/simple_animal/dog/milton
	name = "Milton"
	real_name = "Milton"
	desc = "Awowowo."
	gender = FEMALE

/mob/living/simple_animal/mouse/brain
	name = "\improper Brain"
	real_name = "\improper Brain"
	desc = "A small rodent in a prototype drone chassis. What do you think it's doing tonight?"
	icon_state = "brain"
	item_state = "brain"
	icon_living = "brain"
	icon_dead = "brain_dead"
	density = 1
	holder_type = null
	layer = MOB_LAYER
	sleep_icon = null

/mob/living/simple_animal/mouse/brain/death()
	. = ..()
	holder_type = /obj/item/holder/mouse
	explosion(src.loc, -1, -1, 1, 2)

/mob/living/simple_animal/mouse/brain/New()
	..()
	name = initial(name)
	real_name = initial(real_name)
	icon_state = initial(icon_state)
	desc = initial(desc)

/mob/living/simple_animal/cat/fluff/ganymede
	name = "Ganymede"
	desc = "A ridiculously fluffy cat. Feed him."
	gender = MALE

/mob/living/simple_animal/chicken/murphy
	name = "Murphy"
	desc = "It's giving you a weird look."
	body_color = "brown"
	icon_state = "chicken_brown"
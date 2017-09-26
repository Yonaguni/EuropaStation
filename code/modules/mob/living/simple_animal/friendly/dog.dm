mob/living/simple_animal/dog
	name = "pug"
	real_name = "pug"
	desc = "It's a pug."
	icon_state = "pug"
	icon_living = "pug"
	icon_dead = "pug_dead"
	speak = list("YAP", "Woof!", "Bark!", "AUUUUUU")
	speak_emote = list("barks", "woofs")
	emote_hear = list("barks", "woofs", "yaps","pants")
	emote_see = list("shakes its head", "shivers")
	speak_chance = 1
	turns_per_move = 10
	meat_type = /obj/item/reagent_containers/food/snacks/meat/dog
	meat_amount = 3
	response_help  = "pets"
	response_disarm = "bops"
	response_harm   = "kicks"
	see_in_dark = 5
	mob_size = 8
	possession_candidate = 1
	gender = NEUTER

	var/next_food = 0
	var/next_puppy = 0
	var/obj/movement_target
	var/puppy_type
	var/puppies = 0

/mob/living/simple_animal/dog/New()
	..()
	if(gender == NEUTER)
		gender = pick(MALE, FEMALE)
		update_icon()

/mob/living/simple_animal/dog/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/newspaper))
		user.visible_message("<span class='notice'>\The [user] smacks \the [src] on the nose with the rolled-up [O.name].</span>")
		dance()
	else
		..()

/mob/living/simple_animal/dog/proc/dance()
	set waitfor = 0
	for(var/i in list(1,2,4,8,4,2,1,2))
		set_dir(i)
		sleep(1)

/mob/living/simple_animal/dog/Life()

	..()

	if(stat || resting || buckled)
		return

	if(world.time >= next_food)
		next_food = world.time + 10 SECONDS
		if((movement_target) && !(isturf(movement_target.loc) || ishuman(movement_target.loc) ))
			movement_target = null
			stop_automated_movement = 0
		if( !movement_target || !(movement_target.loc in oview(src, 3)) )
			movement_target = null
			stop_automated_movement = 0
			for(var/obj/item/reagent_containers/food/snacks/S in oview(src,3))
				if(isturf(S.loc) || ishuman(S.loc))
					movement_target = S
					break
		if(movement_target)
			stop_automated_movement = 1
			step_to(src,movement_target,1)
			sleep(3)
			step_to(src,movement_target,1)
			sleep(3)
			step_to(src,movement_target,1)

			if(movement_target)		//Not redundant due to sleeps, Item can be gone in 6 decisecomds
				if (movement_target.loc.x < src.x)
					set_dir(WEST)
				else if (movement_target.loc.x > src.x)
					set_dir(EAST)
				else if (movement_target.loc.y < src.y)
					set_dir(SOUTH)
				else if (movement_target.loc.y > src.y)
					set_dir(NORTH)
				else
					set_dir(SOUTH)

				if(isturf(movement_target.loc) )
					UnarmedAttack(movement_target)
				else if(ishuman(movement_target.loc) && prob(20))
					visible_emote("stares at \the [movement_target.loc]'s [movement_target.name] with sad puppy eyes.")
			return

	if(gender == FEMALE && puppy_type && world.time >= next_puppy)
		next_puppy = world.time + 30 SECONDS
		var/alone = 1
		var/ian = 0
		for(var/mob/M in oviewers(7, src))
			if(M.client)
				alone = 0
				break
			if(istype(M, type))
				ian = M
				break

		if(alone && ian && puppies < 4)
			if(near_camera(src) || near_camera(ian))
				return
			new puppy_type(loc)
			return

	if(prob(1))
		if(gender == FEMALE) // I swear there was a gender datum in the code.
			visible_emote(pick("dances around.","chases her tail."))
		else if(gender == MALE)
			visible_emote(pick("dances around.","chases his tail."))
		else
			visible_emote(pick("dances around.","chases their tail."))
		dance()

/obj/item/reagent_containers/food/snacks/meat/dog
	name = "dog meat"
	desc = "Tastes like loyalty."

/mob/living/simple_animal/dog/corgi
	name = "corgi"
	real_name = "corgi"
	desc = "It's a corgi."
	icon_state = "corgi"
	icon_living = "corgi"
	icon_dead = "corgi_dead"
	puppy_type = /mob/living/simple_animal/dog/corgi/puppy

/mob/living/simple_animal/dog/corgi/update_icon()
	..()
	if(gender == MALE)
		icon_state = "corgi"
		icon_living = "corgi"
		icon_dead = "corgi_dead"
	else if(gender == FEMALE)
		icon_state = "lisa"
		icon_living = "lisa"
		icon_dead = "lisa_dead"

/mob/living/simple_animal/dog/corgi/puppy
	name = "corgi puppy"
	real_name = "corgi"
	desc = "It's a corgi puppy."
	icon_state = "puppy"
	icon_living = "puppy"
	icon_dead = "puppy_dead"

/obj/item/dog_basket
	name = "dog basket"
	desc = "Looks comfy."
	icon = 'icons/obj/furniture.dmi'
	icon_state = "dogbed"
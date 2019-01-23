// Generic damage proc (slimes and monkeys).
/atom/proc/attack_generic(mob/user as mob)
	return 0

/*
	Humans:
	Adds an exception for gloves, to allow special glove types like the ninja ones.

	Otherwise pretty standard.
*/
/mob/living/carbon/human/UnarmedAttack(var/atom/A, var/proximity)

	if(!..())
		return

	// Special glove functions:
	// If the gloves do anything, have them return 1 to stop
	// normal attack_hand() here.
	var/obj/item/clothing/gloves/G = gloves // not typecast specifically enough in defines
	if(istype(G) && G.Touch(A,1))
		return

	A.attack_hand(src)

/atom/proc/attack_hand(mob/user as mob)
	return

/mob/living/carbon/human/RestrainedClickOn(var/atom/A)
	return

/mob/living/carbon/human/RangedAttack(var/atom/A)
	//Climbing up open spaces
	if((istype(A, /turf/simulated/floor) || istype(A, /turf/unsimulated/floor) || istype(A, /obj/structure/lattice) || istype(A, /obj/structure/catwalk)) && isturf(loc) && shadow && !is_physically_disabled()) //Climbing through openspace
		var/turf/T = get_turf(A)
		var/turf/above = shadow.loc
		if(T.Adjacent(shadow) && above.CanZPass(src, UP)) //Certain structures will block passage from below, others not

			var/area/location = get_area(loc)
			if(location.has_gravity && !can_overcome_gravity())
				return

			visible_message("<span class='notice'>[src] starts climbing onto \the [A]!</span>", "<span class='notice'>You start climbing onto \the [A]!</span>")
			shadow.visible_message("<span class='notice'>[shadow] starts climbing onto \the [A]!</span>")
			if(do_after(src, 50, A))
				visible_message("<span class='notice'>[src] climbs onto \the [A]!</span>", "<span class='notice'>You climb onto \the [A]!</span>")
				shadow.visible_message("<span class='notice'>[shadow] climbs onto \the [A]!</span>")
				src.Move(T)
			else
				visible_message("<span class='warning'>[src] gives up on trying to climb onto \the [A]!</span>", "<span class='warning'>You give up on trying to climb onto \the [A]!</span>")
				shadow.visible_message("<span class='warning'>[shadow] gives up on trying to climb onto \the [A]!</span>")
			return

	if(!gloves && !mutations.len) return
	var/obj/item/clothing/gloves/G = gloves
	if((MUTATION_LASER in mutations) && a_intent == I_HURT)
		LaserEyes(A) // moved into a proc below

	else if(istype(G) && G.Touch(A,0)) // for magic gloves
		return

	else if(MUTATION_TK in mutations)
		A.attack_tk(src)

/mob/living/RestrainedClickOn(var/atom/A)
	return

/*
	New Players:
	Have no reason to click on anything at all.
*/
/mob/new_player/ClickOn()
	return

/*
	Animals
*/
/mob/living/simple_animal/UnarmedAttack(var/atom/A, var/proximity)

	if(!..())
		return
	if(istype(A,/mob/living))
		if(melee_damage_upper == 0)
			custom_emote(1,"[friendly] [A]!")
			return
		if(ckey)
			admin_attack_log(src, A, "Has [attacktext] its victim.", "Has been [attacktext] by its attacker.", attacktext)
	setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	var/damage = rand(melee_damage_lower, melee_damage_upper)
	if(A.attack_generic(src, damage, attacktext, environment_smash, damtype, defense) && loc && attack_sound)
		playsound(loc, attack_sound, 50, 1, 1)
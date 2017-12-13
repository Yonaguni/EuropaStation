/obj/item/tank/jetpack/verb/moveup()
	set name = "Move Upwards"
	set category = "Object"

	. = 1
	if(!allow_thrust(0.01, usr))
		to_chat(usr, "<span class='warning'>\The [src] is disabled.</span>")
		return

	var/turf/above = GetAbove(src)
	if(!istype(above))
		to_chat(usr, "<span class='notice'>There is nothing of interest in this direction.</span>")
		return

	if(!above.open_space)
		to_chat(usr, "<span class='warning'>You bump against \the [above].</span>")
		return

	for(var/atom/A in above)
		if(A.density)
			to_chat(usr, "<span class='warning'>\The [A] blocks you.</span>")
			return

	usr.Move(above)
	to_chat(usr, "<span class='notice'>You move upwards.</span>")

/obj/item/tank/jetpack/verb/movedown()
	set name = "Move Downwards"
	set category = "Object"

	. = 1
	if(!allow_thrust(0.01, usr))
		to_chat(usr, "<span class='warning'>\The [src] is disabled.</span>")
		return

	var/turf/below = GetBelow(src)
	if(!istype(below))
		to_chat(usr, "<span class='notice'>There is nothing of interest in this direction.</span>")
		return

	if(below.density)
		to_chat(usr, "<span class='warning'>You bump against \the [below].</span>")
		return

	for(var/atom/A in below)
		if(A.density)
			to_chat(usr, "<span class='warning'>\The [A] blocks you.</span>")
			return

	usr.Move(below)
	to_chat(usr, "<span class='notice'>You move downwards.</span>")

/mob/observer/verb/zup()
	set name = "Move Up"
	set category = "IC"

	var/turf/above = GetAbove(src)
	if(!istype(above))
		to_chat(usr, "<span class='notice'>There is nothing of interest in this direction.</span>")
		return

	usr.Move(above)
	to_chat(usr, "<span class='notice'>You move upwards.</span>")

/mob/observer/verb/zdown()
	set name = "Move Down"
	set category = "IC"

	var/turf/below = GetBelow(src)
	if(!istype(below))
		to_chat(usr, "<span class='notice'>There is nothing of interest in this direction.</span>")
		return
	usr.Move(below)
	to_chat(usr, "<span class='notice'>You move downwards.</span>")

#define CLIMBABLE_IMPOSSIBLE "impossible"
#define CLIMBABLE_EASY "rough"
#define CLIMBABLE_HARD "smooth"

/turf/var/climbable = CLIMBABLE_IMPOSSIBLE
/turf/simulated/wall/climbable = CLIMBABLE_HARD
/turf/simulated/mineral/climbable = CLIMBABLE_EASY

/mob/living/verb/zup()
	set name = "Climb Up"
	set category = "IC"

	var/turf/above = GetAbove(src)
	if(!istype(above) || !above.open_space)
		to_chat(usr, "<span class='warning'>You cannot scale any of the nearby walls.</span>")
		return

	for(var/turf/T in trange(1, get_turf(src)))
		if(T.density && can_climb(T.climbable))
			above = GetAbove(T)
			if(istype(above) && !above.density)
				var/climb_failed
				for(var/atom/A in above)
					if(A.density)
						climb_failed = TRUE
						break
				if(!climb_failed)
					usr.forceMove(above)
					to_chat(usr, "<span class='notice'>You climb upwards.</span>")
					return
	to_chat(usr, "<span class='warning'>You cannot scale any of the nearby walls.</span>")

/mob/living/verb/zdown()
	set name = "Climb Down"
	set category = "IC"

	var/turf/below = GetBelow(src)
	if(!istype(below))
		to_chat(usr, "<span class='warning'>You cannot descend any of the nearby walls.</span>")
		return

	var/turf/immediate_below = GetBelow(src)
	if(immediate_below && immediate_below.density && can_climb(immediate_below.climbable))
		for(var/turf/T in trange(1, get_turf(src)))
			if(T.open_space)
				below = GetBelow(T)
				if(below && !below.density)
					var/climb_failed
					for(var/atom/A in below)
						if(A.density)
							climb_failed = TRUE
							break
					if(!climb_failed)
						usr.forceMove(below)
						to_chat(usr, "<span class='notice'>You climb downwards.</span>")
						return
	to_chat(usr, "<span class='warning'>You cannot descend from this position.</span>")

/mob/living/proc/can_climb(var/climb_degree)
	return (climb_degree == CLIMBABLE_EASY)

/obj/item/clothing/shoes/var/climbing_effectiveness = 0
/obj/item/clothing/gloves/var/climbing_effectiveness = 0

/datum/species/proc/can_climb_unaided(climb_degree)
	return FALSE

/mob/living/carbon/human/can_climb(var/climb_degree)

	if(species.can_climb_unaided(climb_degree))
		return TRUE

	if(climb_degree == CLIMBABLE_IMPOSSIBLE)
		return FALSE

	var/climb_score = 0
	var/obj/item/clothing/shoes/S = shoes
	var/obj/item/clothing/gloves/G = gloves

	if(istype(G)) climb_score += G.climbing_effectiveness
	if(istype(S)) climb_score += S.climbing_effectiveness

	switch(climb_degree)
		if(CLIMBABLE_HARD)
			return climb_score >= 2
		if(CLIMBABLE_EASY)
			return climb_score >= 1

	return FALSE

#undef CLIMBABLE_NEVER
#undef CLIMBABLE_EASY
#undef CLIMBABLE_HARD

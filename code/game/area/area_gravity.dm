/area
	var/has_gravity = 1 // Do mobs in this area experience gravity?

/area/proc/gravitychange(var/gravitystate = 0, var/area/A)
	A.has_gravity = gravitystate

	for(var/mob/M in A)
		if(has_gravity)
			thunk(M)
		M.update_floating( M.Check_Dense_Object() )

/area/proc/thunk(mob)
	if(istype(get_turf(mob), /turf/space)) // Can't fall onto nothing.
		return

	if(istype(mob,/mob/living/human/))
		var/mob/living/human/H = mob
		if(istype(H.shoes, /obj/item/clothing/shoes/magboots) && (H.shoes.item_flags & NOSLIP))
			return

		if(H.m_intent == "run")
			H.AdjustStunned(2)
			H.AdjustWeakened(2)
		else
			H.AdjustStunned(1)
			H.AdjustWeakened(1)
		mob << "<span class='notice'>The sudden appearance of gravity makes you fall to the floor!</span>"

/area/proc/has_gravity()
	return has_gravity

/proc/has_gravity(atom/AT, turf/T)
	if(!T)
		T = get_turf(AT)
	var/area/A = get_area(T)
	if(A && A.has_gravity())
		return 1
	return 0

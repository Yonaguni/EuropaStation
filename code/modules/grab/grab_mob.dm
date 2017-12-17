/mob/living/proc/try_grab(var/atom/movable/grabbing)

	if(grabbing == src || a_intent != I_GRAB || !istype(grabbing) || !Adjacent(grabbing))
		return FALSE

	var/atom/movable/AM = grabbing
	if(!istype(AM.loc, /turf))
		return FALSE

	if(!AM.can_be_dragged_by(src))
		if(holder_type && ishuman(AM))
			var/mob/living/carbon/human/H = AM
			if(!H.lying && !(H.r_hand && H.l_hand))
				get_scooped(H, TRUE)
				return TRUE
		to_chat(src, "<span class='warning'>You can't budge \the [AM].</span>")
		return FALSE

	var/mob/M = AM
	if(istype(M))

		if(M.buckled)
			to_chat(src, "<span class='warning'>You cannot grab \the [M], \he is buckled in!</span>")
			return FALSE

		for(var/obj/item/grab/G in M.grabbed_by)
			if(G.assailant == src)
				to_chat(src, "<span class='warning'>You have already grabbed \the [M].</span>")
				return FALSE

		if(isliving(M) && ishuman(src) && !lying && !issmall(src))
			var/mob/living/L = M
			if(L.holder_type)
				L.get_scooped(src)
				return TRUE

	var/obj/item/grab/G = new(src, AM)
	G.synch()
	playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	visible_message("<span class='notice'>\The [src] has grabbed \the [AM] passively.</span>")
	return G

/mob/living/carbon/human/try_grab(var/atom/movable/grabbing)
	if(istype(grabbing, /obj/item)) return FALSE
	. = ..()
	if(istype(., /obj/item/grab))
		put_in_active_hand(.)

/mob/living/silicon/robot/try_grab(var/atom/movable/grabbing)
	if(current_grab) return FALSE
	. = ..()
	if(istype(., /obj/item/grab))
		current_grab = .

/mob/proc/get_grabs()
	return list()

/mob/living/get_grabs()
	. = ..()
	if(istype(l_hand, /obj/item/grab))
		. += l_hand
	if(istype(r_hand, /obj/item/grab))
		. += r_hand

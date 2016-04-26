/mob/living/animal/hitby(atom/movable/AM)
	. = ..()
	if(mob_ai && !client) mob_ai.receive_hostile_interaction(AM.thrower? AM.thrower : get_turf(src))

/mob/living/animal/attack_generic(var/mob/user, var/damage)
	. = ..()
	if(damage && mob_ai) mob_ai.receive_hostile_interaction(user)
	return .

/mob/living/animal/HasProximity(var/atom/movable/AM)
	if(client || stat)
		return
	if(!istype(AM, /mob/living))
		return
	if(mob_ai)
		mob_ai.handle_neighbor_moved(AM)

/mob/living/animal/get_pulled(var/mob/pulled_by)
	. = ..()
	if(!client)
		walk(src, 0)

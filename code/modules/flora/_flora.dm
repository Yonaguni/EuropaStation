/obj/structure/flora
	name = "generic flora"
	anchored = 1

	var/harvest_ticks = 1
	var/harvest_tool
	var/harvest_result
	var/harvest_amount = 1
	var/harvest_message = "harvests from"
	var/harvest_fail_message = "fails to harvest from"

	var/seed_prob = 0
	var/seed_type

/obj/structure/flora/ex_act(severity)
	..()
	if(severity < 3 || prob(60))
		qdel(src)

// Weeding!
/obj/structure/flora/attack_hand(var/mob/user)
	if(seed_type)
		if(seed_prob && prob(seed_prob))
			var/obj/item/seeds/G = new seed_type(get_turf(src))
			user.put_in_hands(G)
		visible_message("<span class='notice'>\The [user] rips out \the [src].</span>")
		qdel(src)
		return
	return ..()

/obj/structure/flora/attackby(var/obj/item/thing, var/mob/user)
	if(harvest_tool && harvest_result)
		if(istype(thing, harvest_tool))
			harvest_ticks--
			if(harvest_ticks>0)
				fail_harvest(user, thing)
				return
			do_harvest(user, thing)
			return
	return ..()

/obj/structure/flora/proc/fail_harvest(var/mob/user, var/obj/item/thing)
	user.visible_message("<span class='notice'>\The [user] [harvest_fail_message] \the [src] with \the [thing].</span>")

/obj/structure/flora/proc/do_harvest(var/mob/user, var/obj/item/thing)
	var/turf/T = get_turf(src)
	var/list/results = list()

	var/effective_harvest_amount = harvest_amount //(HAS_ASPECT(user, ASPECT_GREENTHUMB) ? round(harvest_amount*1.5) : harvest_amount)
	for(var/x = 1 to effective_harvest_amount)
		results += new harvest_result(T)
	user.visible_message("<span class='notice'>\The [user] [harvest_message] \the [src] with \the [thing].</span>")
	qdel(src)
	return results
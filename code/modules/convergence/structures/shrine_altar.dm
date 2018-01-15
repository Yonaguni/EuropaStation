/obj/structure/shrine/altar
	name = "altar"
	icon_state = "altar"
	unfinished = FALSE

/obj/structure/shrine/altar/New()
	..()
	LAZYADD(sanctified_to.altars, src)

/obj/structure/shrine/altar/update_strings()
	name = sanctified_to.presence.altar_name
	desc = sanctified_to.presence.altar_desc
	icon_state = sanctified_to.presence.altar_icon

/obj/structure/shrine/altar/MouseDrop_T(var/mob/living/target, var/mob/living/user)
	if(!istype(user) || !istype(target) || user.incapacitated() || user.restrained() || \
	 !target.Adjacent(src) || !user.Adjacent(src) || !user.Adjacent(target))
		return ..()
	accept_victim(user, target)

/obj/structure/shrine/altar/proc/accept_victim(var/mob/living/user, var/mob/living/target)

	if(locate(/mob/living) in loc)
		to_chat(user, "<span class='warning'>There is no room on \the [src] for another offering.</span>")
		return

	if(user == target)
		visible_message("<span class='notice'>\The [user] climbs onto \the [src].</span>")
	else
		visible_message("<span class='danger'>\The [target] has been laid upon \the [src] by \the [user].</span>")

	target.resting = TRUE
	target.forceMove(get_turf(src))
	add_fingerprint(user)

/obj/structure/shrine/altar/attackby(var/obj/item/W, var/mob/living/carbon/user)
	if(istype(W, /obj/item/grab))
		var/obj/item/grab/G = W
		if(isliving(G.affecting_mob))
			accept_victim(user, G.affecting_mob)
			user.drop_from_inventory(G)
			return
	. = ..()

/obj/structure/shrine/altar/proc/try_force_convert(var/mob/user, var/mob/victim)
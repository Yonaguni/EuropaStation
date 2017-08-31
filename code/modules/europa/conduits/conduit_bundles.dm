/obj/item/stack/conduit
	name = "feed conduit bundle"
	desc = "A bundle of heavy pipes."
	icon = 'icons/obj/conduits.dmi'
	icon_state = "conduits"
	max_amount = 30
	amount = 30

	var/build_path = /obj/structure/conduit
	var/place_row = 0
	var/max_row = 6

/obj/item/stack/conduit/New()
	..()
	update_icon()

/obj/item/stack/conduit/attack_self(var/mob/user)
	if(!update_row(user))
		return ..()

/obj/item/stack/conduit/proc/update_row(var/mob/user)
	place_row++
	if(place_row > max_row)
		place_row = 0
	if(user)
		to_chat(user, "<span class='notice'>You will now place [singular_name]\s in row [place_row+1].</span>")
	update_icon()
	return 1

/obj/item/stack/conduit/afterattack(var/atom/target, var/mob/living/user, proximity, params)
	if(proximity && can_build_on(user, target))
		new build_path(get_turf(target), place_row)
		use(1)

/obj/item/stack/conduit/proc/can_build_on(var/mob/user, var/turf/target)
	if(!istype(target))
		return 0
	for(var/obj/structure/conduit/C in target.contents)
		if(C.feed_layer == place_row)
			to_chat(user, "<span class='warning'>There is \a [C] in row [place_row+1] at that location.</span>")
			return 0
	return 1

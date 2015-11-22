/obj/item/stack/conduit
	name = "feed conduit bundle"
	desc = "A bundle of heavy pipes."
	icon = 'icons/obj/europa/items/conduits.dmi'
	icon_state = "conduits"
	color = "#FF0000"
	max_amount = 30
	amount = 30

	var/build_type = "conduit"
	var/build_path = /obj/structure/conduit
	var/row_type = "feed conduits"
	var/place_row = 0
	var/max_row = 6

/obj/item/stack/conduit/attack_self(var/mob/user)
	place_row++
	if(place_row > max_row)
		place_row = 0
	user << "<span class='notice'>You will now place [row_type] in row [place_row+1].</span>"
	return

/obj/item/stack/conduit/afterattack(var/atom/target, var/mob/living/user, proximity, params)
	if(!proximity || !istype(target, /turf))
		return

	var/turf/T = target
	for(var/obj/structure/conduit/C in T.contents)
		if(C.feed_layer == place_row && C.feed_type == build_type)
			user << "<span class='warning'>There is already \a [build_type] in row [place_row+1] at that location.</span>"
			return
	var/obj/structure/thing = new build_path(T, place_row)
	thing.color = color

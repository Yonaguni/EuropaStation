/obj/structure/sign/poster
	name = "poster"
	desc = "A large piece of space-resistant printed paper."
	icon = 'icons/obj/posters.dmi'
	dismantle_type = /obj/item/sign/poster
	copy_donor = FALSE
	var/poster_type
	var/ruined

/obj/structure/sign/poster/New(var/newloc, var/_poster_type)
	..(newloc)
	if(!poster_type && _poster_type) poster_type = _poster_type
	var/datum/poster/design = poster_designs[poster_type]
	if(istype(design))
		name = "[initial(name)] - [design.name]"
		desc = "[initial(desc)] [design.desc]"
		icon_state = design.icon_state
	else
		qdel(src)

/obj/structure/sign/poster/attackby(var/obj/item/W, var/mob/user)
	if(W.iswirecutter())
		playsound(loc, 'sound/items/Wirecutter.ogg', 100, 1)
		if(ruined)
			to_chat(user, "<span class='notice'>You remove the remnants of the poster.</span>")
			qdel(src)
		else
			to_chat(user, "<span class='notice'>You carefully remove the poster from the wall.</span>")
			dismount()
		return

/obj/structure/sign/poster/attack_hand(var/mob/user)
	if(user.a_intent == I_HURT && !ruined)
		visible_message("<span class='warning'>\The [user] rips \the [src] in a single, decisive motion!</span>" )
		playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, 1)
		ruined = TRUE
		icon_state = "poster_ripped"
		name = "ripped poster"
		desc = "You can't make out anything from the poster's original print. It's ruined."
		add_fingerprint(user)

/obj/structure/sign/poster/dismount()
	if(!ruined)
		. = new /obj/item/sign/poster(get_turf(src), poster_type)
	qdel(src)

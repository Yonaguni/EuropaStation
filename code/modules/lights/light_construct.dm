/obj/machinery/light_construct
	name = "light fixture frame"
	desc = "A light fixture under construction."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tube-construct-stage1"
	anchored = 1
	layer = 5

	var/stage = 1
	var/fixture_type = /obj/machinery/light
	var/sheets_refunded = 2

/obj/machinery/light_construct/New(atom/newloc, var/newdir, atom/fixture = null)
	..(newloc)
	if(newdir) set_dir(newdir)
	if(istype(fixture))
		if(istype(fixture, /obj/machinery/light))
			fixture_type = fixture.type
		fixture.transfer_fingerprints_to(src)
		stage = 2

	update_icon()

/obj/machinery/light_construct/update_icon()
	switch(stage)
		if(1) icon_state = "tube-construct-stage1"
		if(2) icon_state = "tube-construct-stage2"
		if(3) icon_state = "tube-empty"

/obj/machinery/light_construct/examine(mob/user)
	if(!..(user, 2))
		return

	switch(stage)
		if(1) to_chat(user, "It's an empty frame.")
		if(2) to_chat(user, "It's wired.")
		if(3) to_chat(user, "The casing is closed.")

/obj/machinery/light_construct/attackby(var/obj/item/W, var/mob/user)
	add_fingerprint(user)
	if (W.iswrench())
		if (stage == 1)
			playsound(loc, 'sound/items/Ratchet.ogg', 75, 1)
			to_chat(user, "<span class='notice'>You begin deconstructing \the [src].</span>")
			if (!do_after(usr, 30,src))
				return
			new /obj/item/stack/material/steel( get_turf(loc), sheets_refunded )
			user.visible_message("<span class='notice'>\The [user] deconstructs \the [src].</span>")
			playsound(loc, 'sound/items/Deconstruct.ogg', 75, 1)
			qdel(src)
		if (stage == 2)
			to_chat(user, "<span class='warning'>You have to remove the wires first.</span>")
			return

		if (stage == 3)
			to_chat(user, "<span class='warning'>You have to unscrew the case first.</span>")
			return

	if(W.iswirecutter())
		if (stage != 2) return
		stage = 1
		update_icon()
		new /obj/item/stack/cable_coil(get_turf(loc), 1, "red")
		user.visible_message("<span class='notice'>\The [user] removes the wiring from \the [src].</span>")
		playsound(loc, 'sound/items/Wirecutter.ogg', 100, 1)
		return

	if(W.iscoil())
		if (stage != 1) return
		var/obj/item/stack/cable_coil/coil = W
		if (coil.use(1))
			stage = 2
			update_icon()
			user.visible_message("<span class='notice'>\The [user] adds wires to \the [src].</span>")
		return

	if(W.isscrewdriver())
		if (stage == 2)
			stage = 3
			update_icon()
			user.visible_message("<span class='notice'>\The [user] closes the casing of \the [src].</span>")
			playsound(loc, 'sound/items/Screwdriver.ogg', 75, 1)
			var/obj/machinery/light/newlight = new fixture_type(loc, src)
			newlight.set_dir(dir)
			transfer_fingerprints_to(newlight)
			qdel(src)
			return
	..()

/obj/machinery/light_construct/small
	name = "small light fixture frame"
	desc = "A small light fixture under construction."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "bulb-construct-stage1"
	anchored = 1
	layer = 5
	stage = 1
	fixture_type = /obj/machinery/light/small
	sheets_refunded = 1

/obj/machinery/light_construct/small/update_icon()
	switch(stage)
		if(1) icon_state = "bulb-construct-stage1"
		if(2) icon_state = "bulb-construct-stage2"
		if(3) icon_state = "bulb-empty"

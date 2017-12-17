/obj/item/light
	icon = 'icons/obj/lighting.dmi'
	force = 2
	throwforce = 5
	w_class = 1
	matter = list("steel" = 10, "glass" = 60)

	var/status = 0      // LIGHT_OK, LIGHT_BURNED or LIGHT_BROKEN
	var/switchcount = 0 // number of times switched
	var/rigged

	var/brightness_range = 6
	var/brightness_power = 5
	var/brightness_color = null

/obj/item/light/throw_impact(atom/hit_atom)
	. = ..()
	shatter()

// update the icon state and description of the light
/obj/item/light/update_icon()
	switch(status)
		if(LIGHT_OK)
			icon_state = initial(icon_state)
			desc = "A replacement [name]."
		if(LIGHT_BURNED)
			icon_state = "[initial(icon_state)]-burned"
			desc = "A burnt-out [name]."
		if(LIGHT_BROKEN)
			icon_state = "[initial(icon_state)]-broken"
			desc = "A broken [name]."

// attack bulb/tube with object
// if a syringe, can inject fuel to make it explode
/obj/item/light/attackby(var/obj/item/I, var/mob/user)
	if(istype(I, /obj/item/reagent_containers/syringe))
		var/obj/item/reagent_containers/syringe/S = I
		to_chat(user, "<span class='danger'>You inject the solution into the [src].</span>")
		if(S.reagents.has_reagent("fuel", 5))
			log_admin("LOG: [user.name] ([user.ckey]) injected a light with fuel, rigging it to explode.")
			message_admins("LOG: [user.name] ([user.ckey]) injected a light with fuel, rigging it to explode.")
			rigged = 1
		S.reagents.clear_reagents()
	else
		. = ..()

// called after an attack with a light item
// shatter light, unless it was an attempt to put it in a light socket
// now only shatter if the intent was harm
/obj/item/light/afterattack(var/atom/target, var/mob/user, var/proximity)
	if(proximity && !istype(target, /obj/machinery/light) && user.a_intent == I_HURT)
		shatter()

/obj/item/light/proc/shatter()
	if(status == LIGHT_OK || status == LIGHT_BURNED)
		loc.visible_message("<span class='danger'>\The [src] shatters!</span>")
		status = LIGHT_BROKEN
		force = 5
		sharp = 1
		playsound(src.loc, 'sound/effects/Glasshit.ogg', 75, 1)
		update_icon()

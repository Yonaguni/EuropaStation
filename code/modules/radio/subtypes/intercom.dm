/obj/item/device/radio/intercom
	name = "station intercom (General)"
	desc = "Talk through this."
	icon_state = "intercom"
	anchored = 1
	canhear_range = 5
	flags = CONDUCT | NOBLOODY
	var/last_tick //used to delay the powercheck

/obj/item/device/radio/intercom/New()
	..()
	processing_objects += src

/obj/item/device/radio/intercom/Destroy()
	processing_objects -= src
	return ..()

/obj/item/device/radio/intercom/attack_ai(mob/user as mob)
	attack_self(user)

// This should just be onpowerchange.
/obj/item/device/radio/intercom/process()
	var/ticktime = (world.timeofday - last_tick)
	if(ticktime < 50)
		return
	last_tick = world.timeofday
	if(!src.loc)
		on = 0
	else
		var/area/A = get_area(src)
		if(!A)
			on = 0
		else
			on = A.powered(EQUIP) // set "on" to the power status
	update_icon()

/obj/item/device/radio/intercom/update_icon()
	if(!on)
		icon_state = "intercom-p"
	else
		icon_state = "intercom"

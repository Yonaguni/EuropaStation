/obj/item/device/radio/intercom
	name = "intercom (General)"
	desc = "Talk through this."
	icon_state = "intercom"
	randpixel = 0
	anchored = 1
	w_class = ITEM_SIZE_HUGE
	canhear_range = 2
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_NO_BLOOD
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	layer = ABOVE_WINDOW_LAYER
	cell = null
	power_usage = 0
	var/number = 0
	var/last_tick //used to delay the powercheck

/obj/item/device/radio/intercom/get_storage_cost()
	return ITEM_SIZE_NO_CONTAINER

/obj/item/device/radio/intercom/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/device/radio/intercom/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/device/radio/intercom/attack_ai(mob/user as mob)
	src.add_fingerprint(user)
	spawn (0)
		attack_self(user)

/obj/item/device/radio/intercom/attack_hand(mob/user as mob)
	src.add_fingerprint(user)
	spawn (0)
		attack_self(user)

/obj/item/device/radio/intercom/receive_range(freq, level)
	if (!on)
		return -1
	if(!(0 in level))
		var/turf/position = get_turf(src)
		if(isnull(position) || !(position.z in level))
			return -1
	if (!src.listening)
		return -1
	if(freq in ANTAG_FREQS)
		if(!(src.syndie))
			return -1//Prevents broadcast of messages over devices lacking the encryption

	return canhear_range

/obj/item/device/radio/intercom/Process()
	if(((world.timeofday - last_tick) > 30) || ((world.timeofday - last_tick) < 0))
		last_tick = world.timeofday

		if(!src.loc)
			on = 0
		else
			var/area/A = get_area(src)
			if(!A)
				on = 0
			else
				on = A.powered(EQUIP) // set "on" to the power status

		if(!on)
			icon_state = "intercom-p"
		else
			icon_state = "intercom"

/obj/item/device/radio/intercom/broadcasting
	broadcasting = 1

/obj/item/device/radio/intercom/locked
	var/locked_frequency

/obj/item/device/radio/intercom/locked/set_frequency()
	..(locked_frequency)

/obj/item/device/radio/intercom/locked/list_channels()
	return ""

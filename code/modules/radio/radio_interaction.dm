/obj/item/device/radio/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/weapon/screwdriver))
		if(!encryption_keys.len)
			user << "<span class='warning'>\The [src] has no encryption keys installed.</span>"
			return
		user << "<span class='notice'.You pop [encryption_keys.len] key[encryption_keys.len == 1 ? "" : "s"] out of \the [src].</span>"
		for(var/obj/item/ekey in encryption_keys)
			ekey.forceMove(get_turf(src))
		encryption_keys.Cut()
		update_channels()
		return
	if(istype(thing, /obj/item/device/encryptionkey))
		if(encryption_keys.len >= max_keys)
			user << "<span class='warning'>\The [src] cannot accept another key.</span>"
			return
		user.unEquip(thing)
		thing.forceMove(src)
		encryption_keys += thing
		update_channels()
		return
	return ..()

/obj/item/device/radio/attack_hand(var/mob/user)
	if(anchored)
		return attack_self(user)
	return ..()

/obj/item/device/radio/attack_self(var/mob/user)
	if(!config_options.len)
		return
	var/choice = config_options[1]
	if(config_options.len > 1)
		choice = input("What do you wish to change?") as null|anything in config_options
	switch(choice)
		if("Microphone")
			toggle_microphone(user)
		if("Loudspeaker")
			toggle_loudspeaker(user)
		if("Frequency")
			get_frequency(user)
	return
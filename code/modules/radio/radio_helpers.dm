/obj/item/device/radio/proc/set_frequency(var/freq)
	frequency = freq
	if(frequency < HEADSET_LOW_FREQ)
		frequency = HEADSET_LOW_FREQ
	else if(frequency > HEADSET_HIGH_FREQ)
		frequency = HEADSET_HIGH_FREQ
	return

/obj/item/device/radio/proc/toggle_loudspeaker(var/mob/user)
	loudspeaker = !loudspeaker
	if(user) user << "<span class='notice'>You [loudspeaker ? "en" : "dis"]able \the [src]'s loudspeaker.</span>"

/obj/item/device/radio/proc/toggle_microphone(var/mob/user)
	microphone = !microphone
	if(user) user << "<span class='notice'>You [microphone ? "en" : "dis"]able \the [src]'s microphone.</span>"

/obj/item/device/radio/proc/get_frequency(var/mob/user)
	var/newfreq = input("Specify a frequency between [HEADSET_LOW_FREQ] and [HEADSET_HIGH_FREQ].","Radio Frequency") as num
	if(newfreq)
		var/turf/T = get_turf(src)
		if(T.Adjacent(get_turf(user)))
			set_frequency(newfreq)

/obj/item/device/radio/proc/get_radio_range()
	if(on && loudspeaker)
		return canhear_range
	return 0

/obj/item/device/radio/proc/update_channels()

	channels.Cut()
	translate_hive = 0
	translate_binary = 0

	for(var/obj/item/device/encryptionkey/key in encryption_keys)
		channels |= key.channels
		if(key.translate_binary)
			translate_binary = 1
		if(key.translate_hive)
			translate_hive = 1

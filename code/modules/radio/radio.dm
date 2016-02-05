/obj/item/device/radio
	icon = 'icons/obj/radio.dmi'
	name = "radio"
	icon_state = "walkietalkie"
	item_state = "walkietalkie"
	throw_speed = 2
	throw_range = 9
	w_class = 2
	slot_flags = SLOT_BELT
	show_messages = 1
	matter = list("glass" = 25, DEFAULT_WALL_MATERIAL = 75)

	var/on = 1 // 0 for off
	var/frequency = CHANNEL_PUBIC
	var/canhear_range = 3 // the range which mobs can hear this radio from
	var/loudspeaker = 1
	var/microphone =  0
	var/list/channels = list() // [1] is a "default" for :h
	var/radio_desc = ""

	var/max_keys = 1
	var/list/starting_keys = list()
	var/list/encryption_keys = list()
	var/translate_binary
	var/translate_hive
	var/list/config_options = list("Microphone", "Loudspeaker", "Frequency")

/obj/item/device/radio/New()
	all_radios += src
	..()

/obj/item/device/radio/Destroy()
	set_frequency(frequency)
	all_radios -= src
	for(var/thing in contents)
		qdel(thing)
	encryption_keys.Cut()
	return ..()

/obj/item/device/radio/initialize()
	..()
	for(var/keytype in starting_keys)
		encryption_keys += new keytype(src)
	update_channels()

/obj/item/device/radio/examine()
	..()
	if(src in usr)
		if(channels.len)
			usr << "<span class='notice'>The following channels are available (:h will default to the first):</span>"
			for(var/freq in channels)

				var/freq_text =      radio_freq_to_name["[freq]"]
				var/freq_formatted = "[round(freq / 10)].[freq % 10]"
				var/freq_key =       radio_freq_to_key["[freq]"] ? radio_freq_to_key["[freq]"] : ":?"

				if(freq_text)
					usr << "[freq_key] - [freq_text] ([freq_formatted])"
				else
					usr << "[freq_key] - [freq_formatted]"
		else
			usr << "<span class='notice'>There are no special channels available on this headset.</span>"
		if(translate_binary || translate_hive)
			usr << "<span class='notice'>Special broadcast capabiliy is available using :+.</span>"


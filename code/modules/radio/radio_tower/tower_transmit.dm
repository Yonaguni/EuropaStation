/obj/machinery/radio_receiver/proc/receive_message_signal(var/from, var/message, var/datum/language/speaking, var/speech_verb = "says", var/channel)

	// Get the proper channel name or change the frequency format.
	var/use_channel = radio_freq_to_name["[channel]"]
	if(!use_channel) use_channel = "[round(channel / 10)].[channel % 10]"

	// Get formatting info.
	var/channel_style = radio_freq_to_span["[channel]"]
	if(!channel_style) channel_style = "radio"

	// Update message for language strings.
	var/scrambled = message
	if(speaking)
		if(speaking.colour != DEFAULT_SAY_CLASS)
			scrambled = "<span class='[speaking.colour]'>[speaking.scramble(scrambled)]</span>"
			message = "<span class='[speaking.colour]'>[message]</span>"
		else
			scrambled = "<span class='[channel_style]'>[speaking.scramble(scrambled)]</span>"
			message = "<span class='[channel_style]'>[message]</span>"

	// Actually broadcast the message.
	var/list/shown_mobs = list()
	for(var/obj/item/device/radio/R in all_radios)
		// We are level-locked and cannot universal broadcast.
		var/turf/T = get_turf(R)
		if(!T || (T.z != src.z && (!bluespace_relay || !universal_broadcast["[R.z]"])))
			continue
		// Check if we actually have access to this channel.
		if(channel != R.frequency && (channel in encrypted_channels) && !(channel in R.channels))
			continue
		// Check if the radio is turned on.
		if(!R.on) // Turned off or otherwise disabled.
			continue
		for(var/mob/M in range(get_turf(R), R.get_radio_range()))
			if(M in shown_mobs)
				continue
			shown_mobs += M
			if(M.client)
				var/result = "\icon[R] <span class='[channel_style]'><b>\[[use_channel]\] [from]</b> [speech_verb], \"</span>"
				if(M.say_understands(M, speaking))
					result =  "[result][message]"
				else
					result =  "[result][scrambled]"
				M << "[result]<span class='[channel_style]'>\"</span>"
	return

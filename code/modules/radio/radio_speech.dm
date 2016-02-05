/obj/item/device/radio/hear_talk(var/mob/M, var/msg, var/speech_verb = "says", var/datum/language/speaking = null)
	if(!microphone)
		return
	if(get_dist(get_turf(src), get_turf(M)) > get_radio_range())
		return
	talk_into(M, msg, null, speech_verb, speaking)

/obj/item/device/radio/talk_into(var/mob/living/speaker, var/message, var/channel, var/speech_verb = "says", var/datum/language/speaking = null)

	// Sanity/restrictions.
	if(!message)
		return 0

	// Handle aiming/hostage mode.
	if(!istype(speaker))
		return 0
	speaker.trigger_aiming(TARGET_CAN_RADIO)

	if(!on) return 0 // Well done, you didn't turn your radio on.

	// Determine frequency from supplied message mode.
	var/freq = frequency
	if(channel && channel != "headset")
		// Check for non-radio special things.
		if (channel == "special")
			if (translate_binary)
				var/datum/language/binary = all_languages["Robot Talk"]
				binary.broadcast(speaker, message)
			if (translate_hive)
				var/datum/language/hivemind = all_languages["Hivemind"]
				hivemind.broadcast(speaker, message)
			return // We're done, don't bother doing anything else.

		// If a channel is specified, look for it.
		if(channels && channels.len > 0)
			// Default frequency for the headset (:h).
			if(channel == "department")
				freq =  channels[1]
			// Some other provided channel key, look it up.
			else
				freq = radio_name_to_freq[channel]

	// Finally, try and broadcast to the target channel.
	if(freq) do_broadcast(speaker, message, speaking, speech_verb, freq)

/obj/item/device/radio/proc/autosay(var/message, var/from, var/channel)
	do_simple_broadcast(from, src.z, message, null, "says", channel)
	return

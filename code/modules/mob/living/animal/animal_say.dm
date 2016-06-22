/mob/living/animal/say_quote(var/message, var/datum/language/speaking = null)
	if(speaking)
		return speaking.get_spoken_verb(copytext(message, length(message)))
	else if (speech_verbs.len)
		return pick(speech_verbs)
	return "says"

/mob/living/animal/garble_message(var/message)
	// This is to ensure that everyone sees the same garbled message when the mob speaks.
	if(speech_masks && speech_masks.len && (world.time >= next_update_speech_mask || !current_speech_mask))
		current_speech_mask = pick(speech_masks)
		next_update_speech_mask = world.time + 30
	return (current_speech_mask ? current_speech_mask : ..(message))
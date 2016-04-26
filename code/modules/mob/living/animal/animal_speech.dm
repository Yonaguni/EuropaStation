/mob/living/animal/say(var/message)
	var/use_verb = "says"
	if(speak_emote.len)
		use_verb = pick(speak_emote)
	message = sanitize(message)
	..(message, null, use_verb)

/mob/living/animal/get_speech_ending(var/verb, var/ending)
	return verb

/datum/presence_power/manifest/whisper
	name = "Whisper"
	description = "Whisper in the ear of a chosen follower."
	header_text = "Manifestations"
	use_cost = 5
	children = list(/datum/presence_power/manifest/tome, /datum/presence_power/manifest/altar)

/datum/presence_power/manifest/whisper/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)

	if(invoker.client && (invoker.client.prefs.muted & MUTE_IC))
		to_chat(invoker, "<span class='warning'>You cannot speak in IC (Muted).</span>")
		return

	var/mob/M = target
	if(!istype(M) || M.stat)
		to_chat(invoker, "<span class='warning'>This power is only usable on living, conscious entities.</span>")
		return FALSE

	if(!patron.believers[M])
		to_chat(invoker, "<span class='warning'>This power is only usable on your loyal followers.</span>")
		return FALSE

	var/message = sanitize(input("Enter a message to send.", "Whisper"), MAX_MESSAGE_LEN)
	if(!message || !target || !patron.believers[target])
		return FALSE

	. = ..()
	if(!.)
		return FALSE

	to_chat(invoker, "<span class='notice'>You whisper in <b>[target]'s</b> mind, \"[message]\".</span>")
	to_chat(target, "<span class='notice'><b>\The [invoker]</b> whispers in your mind, \"[message]\".</span>")
	return TRUE

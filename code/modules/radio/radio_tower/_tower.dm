var/list/all_recievers =  list() // Refs.
var/list/all_radio_nets = list() // Assoc by zlevel.
var/list/all_radios =     list() // All radio objects.

/proc/do_broadcast(var/mob/speaker, var/message, var/datum/language/speaking, var/speech_verb = "says", var/channel)

	// Do some var processing. Exciting.
	var/use_name = speaker.get_radio_voice()
	var/use_z = speaker.z

	// Pass it off for actual broadcast.
	do_simple_broadcast(use_name, use_z, message, speaking, speech_verb, channel)

/proc/do_simple_broadcast(var/from, var/from_z, var/message, var/datum/language/speaking, var/speech_verb = "says", var/channel)
	var/datum/radio_net/RN = all_radio_nets["[from_z]"]
	if(!RN)
		return

	sleep(1) // Signal propagation! Actually this just makes the radio message show up after the speech.
	for(var/obj/machinery/radio_receiver/R in RN.towers)
		if(R.use_power && !(R.stat & BROKEN))
			R.receive_message_signal(from, message, speaking, speech_verb, channel)
			return
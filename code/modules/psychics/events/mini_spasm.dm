/datum/event/minispasm
	startWhen = 60
	endWhen = 90
	var/static/list/psi_operancy_messages = list(
		"There's something in your skull!",
		"Something is eating your thoughts!",
		"You can feel your brain being rewritten!",
		"Something is crawling over your frontal lobe!",
		"<b>THE SIGNAL THE SIGNAL THE SIGNAL THE SIGNAL</b>"
		)

/datum/event/minispasm/announce()
	priority_announcement.Announce( \
		"PRIORITY ALERT: SIGMA-[rand(50,80)] SAGGITARIUS SIGNAL LOCAL TRAMISSION DETECTED (97% MATCH, NONVARIANT) \
		(SIGNAL SOURCE TRIANGULATED [rand(300,800)]KM BELOW LOCAL SITE): All personnel are advised to avoid \
		exposure to active audio transmission equipment including radio headsets and intercoms \
		for the duration of the signal broadcast.", \
		"Cuchulain Sensor Array Automated Message" \
		)

/datum/event/minispasm/start()
	var/list/victims = list()
	for(var/obj/item/radio/radio in listening_objects)
		if(radio.on)
			for(var/mob/living/victim in range(radio.canhear_range, radio.loc))
				if(isnull(victims[victim]) && victim.stat == CONSCIOUS && !victim.ear_deaf)
					victims[victim] = radio
	for(var/thing in victims)
		var/mob/living/victim = thing
		var/obj/item/radio/source = victims[victim]
		do_spasm(victim, source)

/datum/event/minispasm/proc/do_spasm(var/mob/living/victim, var/obj/item/radio/source)
	set waitfor = 0

	var/list/disabilities = list(ASPECT_CLUMSY, ASPECT_EPILEPTIC, ASPECT_ASTHMATIC, ASPECT_NEARSIGHTED, ASPECT_NERVOUS, ASPECT_DEAF, ASPECT_BLIND)
	for(var/disability in disabilities)
		if(HAS_ASPECT(victim, disability))
			disabilities -= disability
	if(disabilities.len)
		ADD_ASPECT(victim, pick(disabilities))

	if(victim.psi)
		to_chat(victim, "<span class='danger'>A hauntingly familiar sound hisses from \icon[source] \the [source], and your vision flickers!</span>")
		victim.psi.backblast(rand(5,15))
		victim.Paralyse(5)
		victim.make_jittery(100)
	else
		to_chat(victim, "<span class='danger'>An indescribable, brain-tearing sound hisses from \icon[source] \the [source], and you collapse in a seizure!</span>")
		victim.Paralyse(30)
		victim.make_jittery(500)
		var/new_latencies = rand(1,3)
		var/list/faculties = list("[PSI_COERCION]", "[PSI_REDACTION]", "[PSI_ENERGISTICS]", "[PSI_PSYCHOKINESIS]")
		for(var/i = 1 to new_latencies)
			to_chat(victim, "<span class='warning'>[pick(psi_operancy_messages)]</span>")
			victim.adjustBrainLoss(rand(10,20))
			victim.set_psi_rank(pick_n_take(faculties), 1)
			sleep(30)
		victim.psi.update()
	sleep(45)
	victim.psi.check_latency_trigger(100, "the Signal", redactive = TRUE)

/datum/event/minispasm/end()
	priority_announcement.Announce( \
		"PRIORITY ALERT: SIGNAL BROADCAST HAS CEASED. Personnel are cleared to resume use of non-hardened radio transmission equipment. Have a nice day.", \
		"Cuchulain Sensor Array Automated Message" \
		)

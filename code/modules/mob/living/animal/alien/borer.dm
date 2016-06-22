/mob/living/animal/borer

	name = "cortical borer"
	desc = "A small, quivering sluglike creature."

	universal_understand = 1
	holder_type = /obj/item/weapon/holder
	speech_verbs = list("chirrups")
	help_interaction_text = "nudges"
	harm_interaction_text = "stomps on"
	icon_state = "brainslug"
	icon_living = "brainslug"
	icon_dead = "brainslug_dead"
	animal_move_delay = 5
	attacktext = "nipped"
	friendly_interaction = "prods"
	melee_damage_lower = 1
	melee_damage_upper = 3
	mob_ai_type = /datum/ai_mob/animal/borer

	var/used_dominate
	var/chemicals = 10                      // Chemicals used for reproduction and spitting neurotoxin.
	var/mob/living/human/host        // Human host for the brain worm.
	var/truename                            // Name used for brainworm-speak.
	var/mob/living/captive_brain/host_brain // Used for swapping control of the body back and forth.
	var/controlling                         // Used in human death check.
	var/docile = 0                          // Sugar can stop borers from acting.
	var/has_reproduced
	var/roundstart

/mob/living/animal/borer/roundstart
	roundstart = 1

/mob/living/animal/borer/can_drown()
	return 0

/mob/living/animal/borer/New()
	..()

	add_language("Cortical Link")
	verbs += /mob/living/proc/ventcrawl
	verbs += /mob/living/proc/hide

	truename = "[pick("Primary","Secondary","Tertiary","Quaternary")] [rand(1000,9999)]"
	if(!roundstart) request_player()

/mob/living/animal/borer/Life()

	..()
	if(host && stat != DEAD && host.stat != DEAD)
		if(host.reagents.has_reagent(REAGENT_ID_SUGAR))
			if(!docile)
				if(controlling)
					host << "<span class='notice'>You feel the soporific flow of sugar in your host's blood, lulling you into docility.</span>"
				else
					src << "<span class='notice'>You feel the soporific flow of sugar in your host's blood, lulling you into docility.</span>"
				docile = 1
		else
			if(docile)
				if(controlling)
					host << "<span class='notice'>You shake off your lethargy as the sugar leaves your host's blood.</span>"
				else
					src << "<span class='notice'>You shake off your lethargy as the sugar leaves your host's blood.</span>"
				docile = 0

		if(chemicals < 250)
			chemicals++

		if(controlling)
			if(docile)
				host << "<span class='notice'>You are feeling far too docile to continue controlling your host...</span>"
				host.release_control()
				return

			if(prob(5))
				host.adjustBrainLoss(0.1)

			if(prob(host.brainloss/20))
				host.say("*[pick(list("blink","blink_r","choke","aflap","drool","twitch","twitch_s","gasp"))]")

/mob/living/animal/borer/Stat()
	..()
	statpanel("Status")

	if(emergency_shuttle)
		var/eta_status = emergency_shuttle.get_status_panel_eta()
		if(eta_status)
			stat(null, eta_status)

	if (client.statpanel == "Status")
		stat("Chemicals", chemicals)

/mob/living/animal/borer/proc/detatch()

	if(!host || !controlling) return

	if(istype(host,/mob/living/human))
		var/mob/living/human/H = host
		var/obj/item/organ/external/head = H.get_organ(BP_HEAD)
		head.implants -= src

	controlling = 0

	host.remove_language("Cortical Link")
	host.verbs -= /mob/living/proc/release_control
	host.verbs -= /mob/living/proc/punish_host
	host.verbs -= /mob/living/proc/spawn_larvae

	if(host_brain)

		// these are here so bans and multikey warnings are not triggered on the wrong people when ckey is changed.
		// computer_id and IP are not updated magically on their own in offline mobs -walter0o

		// host -> self
		var/h2s_id = host.computer_id
		var/h2s_ip= host.lastKnownIP
		host.computer_id = null
		host.lastKnownIP = null

		src.ckey = host.ckey

		if(!src.computer_id)
			src.computer_id = h2s_id

		if(!host_brain.lastKnownIP)
			src.lastKnownIP = h2s_ip

		// brain -> host
		var/b2h_id = host_brain.computer_id
		var/b2h_ip= host_brain.lastKnownIP
		host_brain.computer_id = null
		host_brain.lastKnownIP = null

		host.ckey = host_brain.ckey

		if(!host.computer_id)
			host.computer_id = b2h_id

		if(!host.lastKnownIP)
			host.lastKnownIP = b2h_ip

	qdel(host_brain)

/mob/living/animal/borer/proc/leave_host()

	if(!host) return

	src.loc = get_turf(host)

	reset_view(null)
	machine = null

	host.reset_view(null)
	host.machine = null

	var/mob/living/H = host
	H.status_flags &= ~PASSEMOTES
	host = null
	return

//Procs for grabbing players.
/mob/living/animal/borer/proc/request_player()
	var/datum/ghosttrap/G = get_ghost_trap("cortical borer")
	G.request_player(src, "A cortical borer needs a player.")

/mob/living/animal/borer/cannot_use_vents()
	return

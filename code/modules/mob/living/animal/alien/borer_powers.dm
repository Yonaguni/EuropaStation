/mob/living/animal/borer/proc/can_do_borer_ability(var/check_host=1, var/check_docile=1)

	if(check_host && !host)
		src << "<span class='warning'>You are not inside a host body.</span>"
		return

	if(stat)
		src << "You cannot do that in your current state."

	if(check_docile && docile)
		src << "<span class='notice'>You are feeling far too docile to do that.</span>"
		return

/mob/living/animal/borer/verb/release_host()
	set category = "Abilities"
	set name = "Release Host"
	set desc = "Slither out of your host."

	if(!can_do_borer_ability())
		return

	if(!host || !src) return

	src << "You begin disconnecting from [host]'s synapses and prodding at their internal ear canal."

	if(!host.stat)
		host << "An odd, uncomfortable pressure begins to build inside your skull, behind your ear..."

	spawn(100)

		if(!host || !src) return

		if(src.stat)
			src << "You cannot release your host in your current state."
			return

		src << "You wiggle out of [host]'s ear and plop to the ground."
		if(host.mind)
			if(!host.stat)
				host << "<span class='danger'>Something slimy wiggles out of your ear and plops to the ground!</span>"
			host << "<span class='danger'>As though waking from a dream, you shake off the insidious mind control of the brain worm. Your thoughts are your own again.</span>"

		detatch()
		leave_host()

/mob/living/animal/borer/verb/infest()
	set category = "Abilities"
	set name = "Infest"
	set desc = "Infest a suitable humanoid host."

	if(host)
		src << "<span class='warning'>You are already within a host.</span>"
		return

	if(stat)
		src << "<span class='warning'>You cannot infest a target in your current state.</span>"
		return

	var/list/choices = list()
	for(var/mob/living/human/C in view(1,src))
		if(src.Adjacent(C))
			choices += C

	if(!choices.len)
		src << "<span class='warning'>There are no viable hosts within range.</span>"
		return

	var/mob/living/human/M = input(src,"Who do you wish to infest?") in null|choices

	if(!M || !src) return

	if(!(src.Adjacent(M))) return

	if(M.has_brain_worms())
		src << "<span class='warning'>You cannot infest someone who is already infested!</span>"
		return

	if(istype(M,/mob/living/human))
		var/mob/living/human/H = M

		var/obj/item/organ/external/E = H.organs_by_name[BP_HEAD]
		if(!E || E.is_stump())
			src << "<span class='warning'>\The [H] does not have a head!</span>"

		if(!H.should_have_organ("brain"))
			src << "<span class='warning'>\The [H] does not seem to have an ear canal to breach.</span>"
			return

		if(H.check_head_coverage())
			src << "<span class='warning'>You cannot get through that host's protective gear.</span>"
			return

	M << "<span class='notice'>Something slimy begins probing at the opening of your ear canal...</span>"
	src << "<span class='notice'>You slither up [M] and begin probing at their ear canal...</span>"

	if(!do_after(src,30))
		src << "<span class='danger'>As [M] moves away, you are dislodged and fall to the ground.</span>"
		return

	if(!M || !src) return

	if(src.stat)
		src << "<span class='warning'>You cannot infest a target in your current state.</span>"
		return

	if(M in view(1, src))
		src << "<span class = 'notice'>You wiggle into [M]'s ear.</span>"
		if(!M.stat)
			M << "<span class='danger'>Something disgusting and slimy wiggles into your ear!</span>"

		src.host = M
		src.host.status_flags |= PASSEMOTES
		src.loc = M

		if(istype(M,/mob/living/human))
			var/mob/living/human/H = M
			var/obj/item/organ/I = H.internal_organs_by_name["brain"]
			if(!I) // No brain organ, so the borer moves in and replaces it permanently.
				replace_brain()
			else
				// If they're in normally, implant removal can get them out.
				var/obj/item/organ/external/head = H.get_organ(BP_HEAD)
				head.implants += src

		return
	else
		src << "<span class='warning'>They are no longer in range!</span>"
		return

/mob/living/animal/borer/verb/devour_brain()
	set category = "Abilities"
	set name = "Devour Brain"
	set desc = "Take permanent control of a dead host."

	if(!can_do_borer_ability())
		return

	if(host.stat != DEAD)
		src << "<span class='warning'>Your host is still alive.</span>"
		return

	src << "<span class='notice'>It only takes a few moments to render the dead host brain down into a nutrient-rich slurry...</span>"
	replace_brain()


// BRAIN WORM ZOMBIES AAAAH.
/mob/living/animal/borer/proc/replace_brain()

	var/mob/living/human/H = host

	if(!istype(host))
		src << "<span class='warning'>This host does not have a suitable brain.</span>"
		return

	src << "<span class='notice'>You settle into the empty brainpan and begin to expand, fusing inextricably with the dead flesh of [H].</span>"

	H.add_language("Cortical Link")

	if(host.stat == 2)
		H.verbs |= /mob/living/human/proc/jumpstart

	H.verbs |= /mob/living/human/proc/psychic_whisper
	H.verbs |= /mob/living/human/proc/tackle
	H.verbs |= /mob/living/proc/spawn_larvae

	if(H.client)
		H.ghostize(0)

	if(src.mind)
		src.mind.special_role = "Borer Husk"
		src.mind.transfer_to(host)

	H.ChangeToHusk()

	var/obj/item/organ/internal/borer/B = new(H)
	H.internal_organs_by_name["brain"] = B
	H.internal_organs |= B

	var/obj/item/organ/external/affecting = H.get_organ(BP_HEAD)
	affecting.implants -= src

	var/s2h_id = src.computer_id
	var/s2h_ip= src.lastKnownIP
	src.computer_id = null
	src.lastKnownIP = null

	if(!H.computer_id)
		H.computer_id = s2h_id

	if(!H.lastKnownIP)
		H.lastKnownIP = s2h_ip

/mob/living/animal/borer/verb/secrete_chemicals()
	set category = "Abilities"
	set name = "Secrete Chemicals"
	set desc = "Push some chemicals into your host's bloodstream."

	if(!can_do_borer_ability())
		return

	if(chemicals < 50)
		src << "<span class='warning'>You don't have enough chemicals!</span>"

	var/chem = input("Select a chemical to secrete.", "Chemicals") as null|anything in list(REAGENT_ID_JUMPSTART,REAGENT_ID_MORPHINE)

	if(!chem || chemicals < 50 || !host || controlling || !src || stat) //Sanity check.
		return

	src << "<span class='notice'>You squirt a measure of [chem] from your reservoirs into [host]'s bloodstream.</span>"
	host.reagents.add_reagent(chem, 10)
	chemicals -= 50

/mob/living/animal/borer/verb/dominate_victim()
	set category = "Abilities"
	set name = "Paralyze Victim"
	set desc = "Freeze the limbs of a potential host with supernatural fear."

	if(world.time - used_dominate < 150)
		src << "<span class='warning'>You cannot use that ability again so soon.</span>"
		return

	if(!can_do_borer_ability(0,0))
		return

	if(host)
		src << "<span class='warning'>You cannot do that from within a host body.</span>"
		return

	var/list/choices = list()
	for(var/mob/living/human/C in view(3,src))
		if(C.stat != 2)
			choices += C

	if(world.time - used_dominate < 150)
		src << "<span class='warning'>You cannot use that ability again so soon.</span>"
		return

	var/mob/living/human/M = input(src,"Who do you wish to dominate?") in null|choices

	if(!M || !src) return

	if(M.has_brain_worms())
		src << "<span class='warning'>You cannot dominate someone who is already infested!</span>"
		return

	src << "<span class='danger'>You focus your psychic lance on [M] and freeze their limbs with a wave of terrible dread.</span>"
	M << "<span class='danger'>You feel a creeping, horrible sense of dread come over you, freezing your limbs and setting your heart racing.</span>"
	M.Weaken(10)

	used_dominate = world.time

/mob/living/animal/borer/verb/bond_brain()
	set category = "Abilities"
	set name = "Assume Control"
	set desc = "Fully connect to the brain of your host."

	if(!can_do_borer_ability())
		return

	src << "<span class='notice'>You begin delicately adjusting your connection to the host brain...</span>"

	spawn(100+(host.brainloss*5))

		if(!host || !src || controlling)
			return
		else

			src << "<span class='danger'>You plunge your probosci deep into the cortex of the host brain, interfacing directly with their nervous system.</span>"
			host << "<span class='danger'>You feel a strange shifting sensation behind your eyes as an alien consciousness displaces yours.</span>"
			host.add_language("Cortical Link")

			// host -> brain
			var/h2b_id = host.computer_id
			var/h2b_ip= host.lastKnownIP
			host.computer_id = null
			host.lastKnownIP = null

			qdel(host_brain)
			host_brain = new(src)

			host_brain.ckey = host.ckey

			host_brain.name = host.name

			if(!host_brain.computer_id)
				host_brain.computer_id = h2b_id

			if(!host_brain.lastKnownIP)
				host_brain.lastKnownIP = h2b_ip

			// self -> host
			var/s2h_id = src.computer_id
			var/s2h_ip= src.lastKnownIP
			src.computer_id = null
			src.lastKnownIP = null

			host.ckey = src.ckey

			if(!host.computer_id)
				host.computer_id = s2h_id

			if(!host.lastKnownIP)
				host.lastKnownIP = s2h_ip

			controlling = 1

			host.verbs += /mob/living/proc/release_control
			host.verbs += /mob/living/proc/punish_host
			host.verbs += /mob/living/proc/spawn_larvae

			return

/mob/living/human/proc/jumpstart()
	set category = "Abilities"
	set name = "Revive Host"
	set desc = "Send a jolt of electricity through your host, reviving them."

	if(stat != 2)
		usr << "<span class='warning'>Your host is already alive.</span>"
		return

	verbs -= /mob/living/human/proc/jumpstart
	visible_message("<span class='danger'>With a hideous, rattling moan, \the [src] shudders back to life!</span>")

	rejuvenate()
	restore_blood()
	fixblood()
	update_canmove()
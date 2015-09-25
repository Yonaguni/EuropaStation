/obj/item/device/mmi
	name = "man-machine interface"
	desc = "A neat assemblage of clamshell plastics and neural circuitry intended to interface a brain with a machine."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "mmi_empty"
	w_class = 3
	origin_tech = list(TECH_BIO = 3)
	req_access = list(access_robotics)

	var/locked = 0
	var/icon_occupied = "mmi_full"
	var/mob/living/carbon/brain/brainmob = null //The current occupant.
	var/obj/item/organ/brain/brainobj = null	//The current brain organ.

/obj/item/device/mmi/attackby(var/obj/item/O as obj, var/mob/user as mob)

	// Installing a new brain.
	if(istype(O,/obj/item/organ/brain) && !brainmob) //Time to stick a brain in it --NEO

		var/obj/item/organ/brain/B = O
		if(B.health <= 0)
			user << "<span class='warning'>That brain is well and truly dead.</span>"
			return
		else if(!B.brainmob)
			user << "<span class='warning'>You aren't sure where this brain came from, but you're pretty sure it's a useless brain.</span>"
			return
		if(istype(src, /obj/item/device/mmi/digital))
			if(B.status & ORGAN_ROBOT)
				user << "<span class='warning'>There's no point putting a cyberbrain in an MMI.</span>"
				return
		else
			if(!(B.status & ORGAN_ROBOT))
				user << "<span class='warning'>There's no point putting a meat brain in a dgital interface.</span>"
				return

		user.visible_message("<span class='notice'>\The [user] installs \the [O] into \the [src].</span>")
		user.unEquip(O)
		move_inside(O)
		return

	// Locking or unlocking the container.
	if((istype(O,/obj/item/weapon/card/id)||istype(O,/obj/item/device/pda)) && brainmob)
		if(allowed(user))
			locked = !locked
			user << "<span class='notice'>You [locked ? "lock" : "unlock"] \the [src].</span>"
		else
			user << "<span class='warning'>Access denied.</span>"
		return

	// Everything else.
	if(brainmob)
		O.attack(brainmob, user)
		return
	return ..()

/obj/item/device/mmi/proc/move_inside(var/obj/item/organ/brain/person)

	brainobj = person
	brainobj.loc = src
	brainmob = person.brainmob
	person.brainmob = null
	brainmob.loc = src
	brainmob.container = src

	if(brainmob.stat == DEAD)
		brainmob.stat = 0
		dead_mob_list -= brainmob//Update dem lists
		living_mob_list |= brainmob

	set_occupied()
	feedback_inc("cyborg_mmis_filled",1)

/obj/item/device/mmi/attack_self(mob/user as mob)

	if(!brainmob)
		user << "<span class='warning'>There is nothing in \the [src].</span>"
		return
	if(locked)
		user << "<span class='warning'>The brain in \the [src] is clamped in place.</span>"
		return

	user << "<span class='notice'>You remove the brain from \the [src].</span>"
	var/obj/item/organ/brain/brain
	if (brainobj)	//Pull brain organ out of MMI.
		brainobj.loc = user.loc
		brain = brainobj
		brainobj = null
	else	//Or make a new one if empty.
		brain = new(user.loc)

	brainmob.container = null // Reset brainmob mmi var.
	brainmob.loc = brain      // Throw mob into brain.
	brain.brainmob = brainmob // Set the brain to use the brainmob
	set_unoccupied()
	user.put_in_hands(brain)

/obj/item/device/mmi/proc/transfer_identity(var/mob/living/carbon/human/H)
	brainmob = new(src)
	brainmob.name = H.real_name
	brainmob.real_name = H.real_name
	brainmob.dna = H.dna
	brainmob.container = src
	set_occupied()
	return

/obj/item/device/mmi/proc/set_occupied()
	name = "[initial(name)] ([brainmob.real_name])"
	icon_state = icon_occupied
	locked = 1

/obj/item/device/mmi/proc/set_unoccupied()
	brainmob = null
	icon_state = initial(icon_state)
	name = initial(name)

/obj/item/device/mmi/transfer_identity(var/mob/living/carbon/H)
	brainmob.dna = H.dna
	brainmob.timeofhostdeath = H.timeofdeath
	brainmob.stat = 0
	if(H.mind)
		H.mind.transfer_to(brainmob)
	return

/obj/item/device/mmi/relaymove(var/mob/user, var/direction)
	if(user.stat || user.stunned)
		return
	var/obj/item/weapon/rig/rig = src.get_rig()
	if(rig)
		rig.forced_move(direction, user)

/obj/item/device/mmi/Destroy()
	if(isrobot(loc))
		var/mob/living/silicon/robot/borg = loc
		borg.mmi = null
	if(brainmob)
		qdel(brainmob)
		brainmob = null
	..()

/obj/item/device/mmi/emp_act(severity)
	if(brainmob) brainmob.emp_act(severity)

// These are similar to regular MMIs but they are intended for mounting a robot brain in a machine.
/obj/item/device/mmi/digital
	name = "cyberbrain mounting bracket"
	desc = "A universal interface for robot brains. It just looks like a complex cube of circuitry."
	origin_tech = list(TECH_DATA = 3)

	// TEMPORARY ICONS.
	icon_state = "posibrain"
	icon_occupied = "posibrain_occupied"

	var/searching = 1 // Used when looking for a player.
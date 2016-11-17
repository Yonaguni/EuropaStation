// Inspired by/advised by the spell hand_item.
/obj/item/psychic_power
	name = "Psychic Power"
	icon = 'icons/obj/psychic_powers.dmi'
	flags = 0

	abstract = 1
	simulated = 0
	anchored = 1
	flags = NOBLUDGEON

	var/use_like_weapon
	var/mob/living/owner
	var/datum/psychic_power/power

/obj/item/psychic_power/attack_hand(var/mob/user)
	qdel(src)

/obj/item/psychic_power/attack_self(var/mob/user)
	qdel(src)

/obj/item/psychic_power/attack(var/mob/living/target, var/mob/living/user)
	if(user.mind)
		if(user.Adjacent(target) && use_like_weapon)
			if(power.next_psy > world.time)
				user << "<span class='warning'>You cannot use this power again so soon.</span>"
				return
			if(user.mind.spend_psychic_power(power.melee_power_cost, power))
				power.set_next_psy(world.time + power.time_cost)
				return ..()
		else
			afterattack(target, user, user.Adjacent(target))
	return 1

/obj/item/psychic_power/afterattack(var/atom/movable/target, var/mob/living/user, var/proximity)

	if(!power)
		qdel(src)
		return 1

	if(power.next_psy > world.time)
		user << "<span class='warning'>You cannot use this power again so soon.</span>"
		return 1

	if(use_like_weapon)
		return ..()

	if(target == user)
		if(power.target_self)
			if(!power.do_proximity(user, target))
				return 1
		else
			user << "<span class='warning'>You cannot use this power on yourself.</span>"
			return 1

	else if(proximity)
		if(power.target_melee)
			if(!power.do_proximity(user, target))
				return 1
		else
			user << "<span class='warning'>You cannot use this power at close range.</span>"
			return 1
	else
		if(power.target_ranged)
			if(!power.do_ranged(user, target))
				return 1
		else
			user << "<span class='warning'>You cannot use this power at a distance.</span>"
			return 1

	power.set_next_psy(world.time + power.time_cost)
	return 1

/obj/item/psychic_power/dropped()
	. = ..()
	loc = null
	if(!deleted(src))
		qdel(src)

/obj/item/psychic_power/forceMove()
	. = ..()
	if(loc != owner && !deleted(src))
		loc = null
		qdel(src)

/obj/item/psychic_power/throw_at()
	loc = null
	qdel(src)

/obj/item/psychic_power/New(var/mob/living/_owner, var/datum/psychic_power/_power)
	. = ..()
	owner = _owner
	power = _power
	update_from_power()
	processing_objects += src
	set_light()

/obj/item/psychic_power/Destroy()
	if(power)
		power.cancelled(owner, src)
		power = null
	owner = null
	processing_objects -= src
	. = ..()

/obj/item/psychic_power/proc/update_from_power()
	name = "evoked power ([power.name])"
	desc = power.description
	light_range = power.rank+1
	light_power = power.rank+1
	light_color = power.associated_faculty.colour
	color = light_color
	icon_state = power.item_icon_state

/obj/item/psychic_power/process()
	if(loc != owner || (owner.r_hand != src && owner.l_hand != src))
		qdel(src)
		return 0
	return 1

/obj/item/psychic_power/kinesis
	use_like_weapon = TRUE
	force = 5

/obj/item/psychic_power/kinesis/tinker/iswirecutter()
	return TRUE

/obj/item/psychic_power/spark
	use_like_weapon = TRUE
	force = 1

/obj/item/psychic_power/spark/ismultitool()
	return 1

/obj/item/psychic_power/kinesis/tinker
	force = 1
	var/emulating = "crowbar"

/obj/item/psychic_power/kinesis/tinker/iscrowbar()
	return emulating == "Crowbar"

/obj/item/psychic_power/kinesis/tinker/iswrench()
	return emulating == "Wrench"

/obj/item/psychic_power/kinesis/tinker/isscrewdriver()
	return emulating == "Screwdriver"

/obj/item/psychic_power/kinesis/tinker/iswirecutter()
	return emulating == "Wirecutters"

/obj/item/psychic_power/kinesis/tinker/update_from_power()
	. = ..()
	name = "evoked power (psychic [emulating])"

/obj/item/psychic_power/kinesis/tinker/attack_self()

	if(!owner || loc != owner || !power)
		qdel(src)
		return

	var/choice = input("Select a tool to emulate.","Power") as null|anything in list("Crowbar","Wrench","Screwdriver","Wirecutters","Dismiss Power")
	if(!choice)
		return

	if(!owner || loc != owner || !power)
		qdel(src)
		return

	if(choice == "Dismiss Power")
		return ..()

	emulating = choice
	name = "evoked power (psychic [emulating])"
	owner << "<span class='notice'>You begin emulating \a [lowertext(emulating)].</span>"
	owner << 'sound/effects/psi/power_fabrication.ogg'

/obj/item/psychic_power/kinesis
	flags = 0
	var/min_force = 1
	var/max_force = 3

/obj/item/psychic_power/kinesis/update_from_power()
	. = ..()
	name = "\proper [owner.name]'s bare hands"
	force = rand(min_force, max_force)

/obj/item/psychic_power/kinesis/iscrowbar()
	return TRUE

/obj/item/psychic_power/kinesis/lesser
	attack_verb = list("battered", "bludgeoned")
	min_force = 5
	max_force = 15

/obj/item/psychic_power/kinesis/process()
	. = ..()
	if(.)
		force = rand(min_force, max_force)

/obj/item/psychic_power/kinesis/paramount
	attack_verb = list("rended", "ripped", "torn")
	min_force = 35
	max_force = 70

//Psi-boosting item (antag only)
/obj/item/clothing/head/helmet/space/paramount
	name = "cerebro-energetic enhancement rig"
	desc = "A crown-of-thorns cerebro-energetic enhancer. Kind of looks like a tiara having sex with an industrial robot."
	icon_state = "amp"
	action_button_name = "Install Boosters"
	flags_inv = 0

	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet",
		)

	var/list/boosted_faculties = list()
	var/static/list/boostable_faculties = list(
		"Farsensing" =    PSYCHIC_FARSENSE,
		"Coercion" =      PSYCHIC_COERCION,
		"Psychokinesis" = PSYCHIC_PSYCHOKINESIS,
		"Redaction" =     PSYCHIC_REDACTION,
		"Creativity" =    PSYCHIC_CREATIVITY
		)
	var/boosted_rank = 5
	var/unboosted_rank = 3
	var/max_boosted_faculties = 3
	var/boosted_psipower = 120

/obj/item/clothing/head/helmet/space/paramount/New()
	..()
	verbs += /obj/item/clothing/head/helmet/space/paramount/proc/integrate

/obj/item/clothing/head/helmet/space/paramount/attack_self(var/mob/user)
	if(boosted_faculties.len >= max_boosted_faculties)
		integrate()
		return
	var/choice = input("Select a brainboard to install.","CE Rig") as null|anything in boostable_faculties
	if(!choice || !boostable_faculties[choice] || (boostable_faculties[choice] in boosted_faculties))
		return ..()
	boosted_faculties += boostable_faculties[choice]
	var/slots_left = max_boosted_faculties-boosted_faculties.len
	user << "<span class='notice'>You install the [choice] brainboard in \the [src]. There [slots_left!=1 ? "are" : "is"] [slots_left] slot\s left.</span>"

/obj/item/clothing/head/helmet/space/paramount/proc/integrate()

	set name = "Integrate CE Rig"
	set desc = "Enhance your brainpower."
	set category = "Abilities"
	set src in usr

	if(!canremove || !usr.mind)
		return

	if(boosted_faculties.len < max_boosted_faculties)
		usr << "<span class='notice'>You still have [max_boosted_faculties-boosted_faculties.len] facult[boosted_faculties.len == 1 ? "y" : "ies"] to select. Use \the [src] in-hand to select them.</span>"
		return

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.head != src)
		usr << "<span class='warning'>\The [src] must be worn on your head in order to be activated.</span>"
		return

	canremove = FALSE
	verbs -= /obj/item/clothing/head/helmet/space/paramount/proc/integrate
	action_button_name = null
	H.update_action_buttons()

	H << "<span class='warning'>You feel a series of sharp pinpricks as \the [src] anaesthetises your scalp before drilling down into your brain...</span>"
	playsound(H, 'sound/weapons/circsawhit.ogg', 50, 1, -1)

	sleep(80)

	for(var/thing in H.mind.psychic_faculties)
		qdel(H.mind.psychic_faculties[thing])
	H.mind.psychic_faculties.Cut()
	for(var/pname in all_psychic_faculties)
		var/datum/psychic_power_assay/assay = new(H.mind, all_psychic_faculties[pname])
		H.mind.psychic_faculties[assay.associated_faculty.name] = assay
		assay.set_rank((pname in boosted_faculties) ? boosted_rank : unboosted_rank)
		sleep(25)

	H.mind.max_psychic_power = boosted_psipower
	H.mind.psychic_power = H.mind.max_psychic_power

	H << "<span class='notice'>\The [src] chimes quietly as it finishes boosting your brain.</span>"
	set_light(1, 1, "#880000")

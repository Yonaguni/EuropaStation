// Inspired by/advised by the spell hand_item.
/obj/item/psychic_power
	name = "Psychic Power"
	icon = 'icons/obj/psychic_powers.dmi'
	flags = 0

	light_range = 1
	abstract = 1
	simulated = 0
	anchored = 1
	flags = NOBLUDGEON

	var/use_like_weapon
	var/mob/living/owner
	var/datum/psychic_power/power

/obj/item/psychic_power/attack_hand(var/mob/user)
	if(power)
		var/datum/psychic_power/temp_power = power
		power = null
		temp_power.cancelled(owner, src)

/obj/item/psychic_power/attack_self(var/mob/user)
	if(power)
		var/datum/psychic_power/temp_power = power
		power = null
		temp_power.cancelled(owner, src)

/obj/item/psychic_power/attack(var/mob/living/target, var/mob/living/user)
	if(!power)
		return 0
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

	if(power)
		power.set_next_psy(world.time + power.time_cost)
	return 1

/obj/item/psychic_power/dropped()
	if(power)
		var/datum/psychic_power/temp_power = power
		power = null
		temp_power.cancelled(owner, src)

/obj/item/psychic_power/forceMove()
	. = ..()
	if(loc != owner && power)
		var/datum/psychic_power/temp_power = power
		power = null
		temp_power.cancelled(owner, src)

/obj/item/psychic_power/throw_at()
	return

/obj/item/psychic_power/New(var/mob/living/_owner, var/datum/psychic_power/_power)
	. = ..()
	owner = _owner
	power = _power
	update_from_power()
	processing_objects += src
	set_light()

/obj/item/psychic_power/Destroy()
	power = null
	owner = null
	processing_objects -= src
	. = ..()

/obj/item/psychic_power/proc/update_from_power()
	name = "evoked power ([power.name])"
	desc = power.description
	light_power = power.rank+1
	light_color = power.associated_faculty.colour
	color = light_color
	icon_state = power.item_icon_state

/obj/item/psychic_power/process()
	if(loc != owner || (owner.r_hand != src && owner.l_hand != src))
		if(power)
			var/datum/psychic_power/temp_power = power
			power = null
			temp_power.cancelled(owner, src)
		return 0
	return 1

/obj/item/psychic_power/spark
	force = 1

/obj/item/psychic_power/spark/ismultitool()
	return 1

/obj/item/psychic_power/kinesis
	use_like_weapon = TRUE
	force = 5

/obj/item/psychic_power/kinesis/tinker
	force = 1
	var/emulating = "Crowbar"

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
		return

	var/choice = input("Select a tool to emulate.","Power") as null|anything in list("Crowbar","Wrench","Screwdriver","Wirecutters","Dismiss Power")
	if(!choice)
		return

	if(!owner || loc != owner || !power)
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

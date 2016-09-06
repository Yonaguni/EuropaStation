// Inspired by/advised by the spell hand_item.
/obj/item/psychic_power
	name = "Psychic Power"
	icon = 'icons/obj/psychic_powers.dmi'
	abstract = 1
	simulated = 0
	flags = NOBLUDGEON
	var/mob/living/owner
	var/decl/psychic_power/power

/obj/item/psychic_power/attack_hand(var/mob/user)
	attack_self(user)

/obj/item/psychic_power/attack_self(var/mob/user)
	if(!power)
		user.drop_from_inventory(src)
		return
	power.cancelled(user, src)

/obj/item/psychic_power/attack(var/mob/living/target, var/mob/living/user)
	afterattack(target, user, user.Adjacent(target))
	return 1

/obj/item/psychic_power/afterattack(var/atom/movable/target, var/mob/living/user, var/proximity)

	if(!power)
		qdel(src)
		return

	if(user.next_psy > world.time)
		user << "<span class='warning'>You cannot use this power again so soon.</span>"
		return

	if(target == user)
		if(power.target_self)
			if(!power.do_proximity(user, target))
				return
		else
			user << "<span class='warning'>You cannot use this power on yourself.</span>"
			return
	else if(proximity)
		if(power.target_melee)
			if(!power.do_proximity(user, target))
				return
		else
			user << "<span class='warning'>You cannot use this power at close range.</span>"
			return
	else
		if(power.target_ranged)
			if(!power.do_ranged(user, target))
				return
		else
			user << "<span class='warning'>You cannot use this power at a distance.</span>"
			return

	user.next_psy = world.time + (power ? power.time_cost : 10)
	return 1

/obj/item/psychic_power/dropped()
	if(power) attack_self(owner)

/obj/item/psychic_power/throw_at()
	if(power) attack_self(owner)

/obj/item/psychic_power/New(var/mob/living/_owner, var/decl/psychic_power/_power)
	. = ..()
	owner = _owner
	power = _power
	update_from_power()
	processing_objects += src
	set_light()

/obj/item/psychic_power/Destroy()
	var/mob/M = loc
	if(istype(M))
		M.drop_from_inventory(src)
	owner = null
	power = null
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
		attack_self(owner)
		return 0
	return 1

/* POWERS */
/datum/psychic_power

	var/name = "Psychic Power"
	var/description = "A mental power."
	var/time_cost = 10
	var/passive_cost = 2
	var/melee_power_cost = 6
	var/ranged_power_cost = 10
	var/datum/mind/owner
	var/obj/screen/psi/power/hud_element
	var/decl/psychic_faculty/associated_faculty

	var/active = FALSE
	var/visible = 1
	var/item_path = /obj/item/psychic_power
	var/passive_path = /datum/maintained_power
	var/item_icon_state
	var/rank = 1
	var/next_psy = 0

	var/passive
	var/target_ranged
	var/target_melee
	var/target_self
	var/target_mob_only

/datum/psychic_power/New(var/datum/mind/_owner, var/_associated_faculty, var/_rank)
	. = ..()
	associated_faculty = _associated_faculty
	rank = _rank
	owner = _owner
	owner.psychic_powers += src

/datum/psychic_power/proc/set_next_psy(var/amt)
	set waitfor = 0
	set background = 1
	next_psy = amt
	hud_element.update_from_power()
	sleep((amt+1)-world.time)
	hud_element.update_from_power()

/datum/psychic_power/proc/evoke(var/mob/living/user)

	if(!user.mind)
		return

	var/turf/T = get_turf(user)

	if(T.is_psi_null())
		user << "<span class='warning'>You feel your psi-power bleeding away into \the [T]...</span>"
		return

	if(passive)
		for(var/datum/maintained_power/mpower in user.mind.maintaining_powers)
			if(mpower.power == src)
				mpower.power.cancelled(user)
				return
		user << "<span class='notice'>You bend your will to manifesting [name]...</span>"
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>[user.real_name] ([user.ckey]) passively manifested [name].</font>")
		active = TRUE
		new passive_path(user, src)
	else
		var/obj/item/psychic_power/power_holder = new item_path(user, src)
		if(user.put_in_hands(power_holder))
			user << "<span class='notice'>You bend your will to manifesting [name]...</span>"
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>[user.real_name] ([user.ckey]) actively manifested [name].</font>")
			active = TRUE
		else
			user << "<span class='warning'>You do not have a free hand to direct the flow of power.</span>"
			qdel(power_holder)
			return

	for(var/mob/living/M in viewers(world.view, user)-user)
		if(M.stat == CONSCIOUS && M.mind && M.mind.check_psychic_faculty(PSYCHIC_FARSENSE, 1) && prob(M.mind.get_psychic_faculty_rank(PSYCHIC_FARSENSE)*20))
			M << "<span class='warning'>You feel the psi-lattices sing as \the [user] evokes the power of [name]!</span>"
			M << 'sound/effects/psi/power_evoke.ogg'
	user << 'sound/effects/psi/power_evoke.ogg'
	hud_element.update_from_power()

/datum/psychic_power/proc/cancelled(var/mob/living/user, var/obj/item/psychic_power/caller)

	if(!user.mind)
		return

	for(var/mob/living/M in viewers(world.view, user)-user)
		if(M.stat == CONSCIOUS && M.mind && M.mind.check_psychic_faculty(PSYCHIC_FARSENSE, 1) && prob(M.mind.get_psychic_faculty_rank(PSYCHIC_FARSENSE)*20))
			M << "<span class='notice'>You feel the tension of the psi-lattices ease as \the [user] ceases manifesting the power of [name].</span>"
			M << 'sound/effects/psi/power_fail.ogg'
	user << 'sound/effects/psi/power_fail.ogg'
	for(var/datum/maintained_power/mpower in user.mind.maintaining_powers)
		if(mpower.power == src) mpower.fail(skip_cancel=1)
	if(!caller)
		for(var/obj/item/psychic_power/check in user)
			if(check.power == src)
				caller = check
				break
	if(caller)
		caller.power = null
		if(caller.owner && caller.loc == caller.owner)
			caller.owner.drop_from_inventory(caller)
		qdel(caller)
	user << "<span class='notice'>You cease manifesting [name].</span>"
	active = FALSE
	hud_element.update_from_power()

/datum/psychic_power/proc/tick(var/mob/living/user)
	return

/datum/psychic_power/proc/do_proximity(var/mob/living/user, var/atom/target)
	if(!user.mind)
		return 0
	var/datum/psychic_power_assay/user_power = user.mind.psychic_faculties[associated_faculty.name]
	if(!user_power)
		return 0
	if(target_mob_only && !istype(target, /mob/living))
		user << "<span class='warning'>This power only influences living creatures.</span>"
		return 0
	user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
	user.setMoveCooldown(DEFAULT_QUICK_COOLDOWN)
	return user.mind.spend_psychic_power(melee_power_cost, src)

/datum/psychic_power/proc/do_ranged(var/mob/living/user, var/atom/target)
	if(!user.mind)
		return 0
	var/datum/psychic_power_assay/user_power = user.mind.psychic_faculties[associated_faculty.name]
	if(!user_power)
		return 0
	if(target_mob_only && !istype(target, /mob/living))
		user << "<span class='warning'>This power only influences living creatures.</span>"
		return 0
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	user.setMoveCooldown(DEFAULT_ATTACK_COOLDOWN)
	return user.mind.spend_psychic_power(ranged_power_cost, src)

/datum/psychic_power/latent
	name = "Latency"
	visible = 0

/datum/psychic_power/latent/evoke(var/mob/living/user)
	if(!user.mind)
		return
	var/datum/psychic_power_assay/power_assay = user.mind.psychic_faculties[associated_faculty.name]
	if(istype(power_assay) && power_assay.rank == 1)
		power_assay.set_rank(min(5,max(power_assay.rank+1,pick(list(2,2,2,3,3,3,3,3,4,4,4,4,5)))))

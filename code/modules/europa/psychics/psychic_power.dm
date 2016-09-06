/* POWERS */
/decl/psychic_power

	var/name = "Psychic Power"
	var/description = "A mental power."
	var/time_cost = 10
	var/passive_cost = 2
	var/melee_power_cost = 6
	var/ranged_power_cost = 10

	var/decl/psychic_faculty/associated_faculty

	var/visible = 1
	var/item_path = /obj/item/psychic_power
	var/passive_path = /datum/maintained_power
	var/item_icon_state
	var/rank = 1

	var/passive
	var/target_ranged
	var/target_melee
	var/target_self
	var/target_mob_only

/decl/psychic_power/New(var/_associated_faculty, var/_rank)
	. = ..()
	associated_faculty = _associated_faculty
	rank = _rank

/decl/psychic_power/proc/evoke(var/mob/living/user)

	if(passive)
		for(var/datum/maintained_power/mpower in user.maintaining_powers)
			if(mpower.power == src)
				mpower.power.cancelled(user)
				return
		user << "<span class='notice'>You bend your will to manifesting [name]...</span>"
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>[user.real_name] ([user.ckey]) passively manifested [name].</font>")
		new passive_path(user, src)
	else
		var/obj/item/psychic_power/power_holder = new item_path(user, src)
		if(user.put_in_hands(power_holder))
			user << "<span class='notice'>You bend your will to manifesting [name]...</span>"
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>[user.real_name] ([user.ckey]) actively manifested [name].</font>")
		else
			user << "<span class='warning'>You do not have a free hand to direct the flow of power.</span>"
			qdel(power_holder)
			return

	for(var/mob/living/M in viewers(world.view, user)-user)
		if(M.stat == CONSCIOUS && M.check_psychic_faculty(PSYCHIC_FARSENSE, 1) && prob(M.get_psychic_faculty_rank(PSYCHIC_FARSENSE)*20))
			M << "<span class='warning'>You feel the psi-lattices sing as \the [user] evokes the power of [name]!</span>"
			M << 'sound/effects/psi/power_evoke.ogg'
	user << 'sound/effects/psi/power_evoke.ogg'

/decl/psychic_power/proc/cancelled(var/mob/living/user, var/obj/item/psychic_power/caller)

	for(var/mob/living/M in viewers(world.view, user)-user)
		if(M.stat == CONSCIOUS && M.check_psychic_faculty(PSYCHIC_FARSENSE, 1) && prob(M.get_psychic_faculty_rank(PSYCHIC_FARSENSE)*20))
			M << "<span class='notice'>You feel the tension of the psi-lattices ease as \the [user] ceases manifesting the power of [name].</span>"
			M << 'sound/effects/psi/power_fail.ogg'
	user << 'sound/effects/psi/power_fail.ogg'

	for(var/datum/maintained_power/mpower in user.maintaining_powers)
		if(mpower.power == src) mpower.fail(skip_cancel=1)
	if(caller)
		caller.power = null
		user.drop_from_inventory(caller)
		qdel(caller)
	user << "<span class='notice'>You cease manifesting [name].</span>"

/decl/psychic_power/proc/tick(var/mob/living/user)
	return

/decl/psychic_power/proc/do_proximity(var/mob/living/user, var/atom/target)
	var/datum/psychic_power_assay/user_power = user.psychic_faculties[associated_faculty.name]
	if(!user_power)
		return 0
	if(target_mob_only && !istype(target, /mob/living))
		user << "<span class='warning'>This power only influences living creatures.</span>"
		return 0
	user.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
	user.setMoveCooldown(DEFAULT_QUICK_COOLDOWN)
	return user.spend_psychic_power(melee_power_cost, src)

/decl/psychic_power/proc/do_ranged(var/mob/living/user, var/atom/target)
	var/datum/psychic_power_assay/user_power = user.psychic_faculties[associated_faculty.name]
	if(!user_power)
		return 0
	if(target_mob_only && !istype(target, /mob/living))
		user << "<span class='warning'>This power only influences living creatures.</span>"
		return 0
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	user.setMoveCooldown(DEFAULT_ATTACK_COOLDOWN)
	return user.spend_psychic_power(ranged_power_cost, src)

/decl/psychic_power/latent
	name = "Latency"
	visible = 0

/decl/psychic_power/latent/evoke(var/mob/living/user)
	var/datum/psychic_power_assay/power_assay = user.psychic_faculties[associated_faculty.name]
	if(istype(power_assay) && power_assay.rank == 1)
		power_assay.set_rank(min(5,max(power_assay.rank+1,pick(list(2,2,2,3,3,3,3,3,4,4,4,4,5)))))

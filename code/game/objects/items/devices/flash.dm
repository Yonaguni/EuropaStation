/obj/item/flash
	name = "flash"
	desc = "Used for blinding and being an asshole."
	icon_state = "flash"
	item_state = "flashtool"
	throwforce = 5
	w_class = 2
	throw_speed = 4
	throw_range = 10
	flags = CONDUCT

	var/max_uses_per_minute = 5    // Number of times used per minute before burnout is possible.
	var/broken                     // Whether or not it has burned out.
	var/recharge_period            // ds between uses.
	var/next_recharge = 0          // Next time uses will decrease.
	var/times_used_this_minute = 0 // Number of times used this minute.
	var/last_flash_noise = 0       // Last time we went BWEE, to prevent spamming.

/obj/item/flash/New()
	..()
	recharge_period = Floor((1 MINUTE) / max_uses_per_minute)

/obj/item/flash/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/obj/item/flash/process()
	if(broken || times_used_this_minute <= 0)
		STOP_PROCESSING(SSprocessing, src)
	else if(world.time > next_recharge)
		next_recharge = world.time + recharge_period
		times_used_this_minute--

/obj/item/flash/proc/expend_charge(var/mob/user)
	times_used_this_minute++
	START_PROCESSING_NO_DUPLICATES(SSprocessing, src)
	if(broken)
		return FALSE
	if(times_used_this_minute > max_uses_per_minute)
		if(prob(times_used_this_minute))
			break_flash(user)
		else if(user)
			to_chat(user, "<span class='warning'>*click* *click*</span>")
			return FALSE
	return TRUE

/obj/item/flash/proc/break_flash(var/mob/user)
	if(!broken)
		icon_state = "flashburnt"
		broken = TRUE
		STOP_PROCESSING(SSprocessing, src)
		if(user) to_chat(user, "<span class='danger'>The bulb has burnt out!</span>")

/obj/item/flash/proc/attempt_use_flash(var/mob/user)
	if(user)
		if(broken)
			to_chat(user, "<span class='warning'>\The [src] is broken.</span>")
			return FALSE
		if(expend_charge(user))
			return TRUE
	return FALSE

/obj/item/flash/emp_act(severity)
	if(!broken)
		if(expend_charge() && istype(loc, /mob/living))
			try_flash(loc, silent = TRUE)
	. = ..()

/obj/item/flash/proc/try_flash(var/mob/living/victim, var/mob/living/user, var/silent)

	if(!istype(victim))
		return

	if(world.time > last_flash_noise + 20)
		last_flash_noise = world.time + 20
		playsound(victim.loc, 'sound/weapons/flash.ogg', 100, 1)

	if(user)
		admin_attack_log(user, victim, "flashed", "was flashed by", "flashed")
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		user.do_attack_animation(victim)

	var/flash_strength = 0
	if(victim.stat != DEAD)
		if(iscarbon(victim))
			var/mob/living/carbon/C = victim
			if(C.eyecheck() < FLASH_PROTECTION_MODERATE)
				flash_strength = 10
				if(ishuman(C))
					var/mob/living/carbon/human/H = C
					flash_strength *= H.species.flash_mod
		else if(issilicon(victim))
			flash_strength = rand(5,10)

	var/use_message = "\The [user] fails to blind \the [victim] with \the [src]!"
	if(flash_strength > 0)
		victim.Weaken(flash_strength)
		victim.flash_eyes()
		flick("flash2", src)
		if(issilicon(victim))
			use_message = "\The [user] overloads \the [victim]'s sensors with \the [src]!"
		else
			use_message = "\The [user] blinds \the [victim] with \the [src]!"

	if(!silent)
		loc.visible_message("<span class='danger'>[use_message]</span>")

/obj/item/flash/attack(var/mob/living/M, var/mob/living/user, var/target_zone)
	if(istype(M) && attempt_use_flash(user))
		try_flash(M, user)

/obj/item/flash/attack_self(var/mob/living/carbon/user, var/flag)
	if(attempt_use_flash(user))
		for(var/mob/living/carbon/M in oviewers(3, loc))
			try_flash(M, user, silent = TRUE)
		try_flash(user, silent = TRUE)

/obj/item/flash/synthetic
	name = "synthetic flash"
	desc = "When a problem arises, SCIENCE is the solution."
	icon_state = "sflash"

/obj/item/flash/synthetic/expend_charge(var/mob/user)
	if(!broken)
		break_flash(user)
		return TRUE
	return FALSE

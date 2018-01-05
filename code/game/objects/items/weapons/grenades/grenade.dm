/obj/item/grenade
	name = "grenade"
	desc = "A hand held grenade, with an adjustable timer."
	w_class = 2.0
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade"
	item_state = "grenade"
	throw_speed = 4
	throw_range = 20
	flags = CONDUCT
	slot_flags = SLOT_BELT
	var/active = 0
	var/det_time = 50
	var/arm_sound = 'sound/weapons/armbomb.ogg'

/obj/item/grenade/examine(mob/user)
	if(..(user, 0))
		if(det_time > 1)
			user << "The timer is set to [det_time/10] seconds."
			return
		if(det_time == null)
			return
		user << "\The [src] is set for instant detonation."


/obj/item/grenade/attack_self(var/mob/user)
	if(!active)
		user << "<span class='warning'>You prime \the [name]! [det_time/10] seconds!</span>"
		activate(user)
		add_fingerprint(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_on()

/obj/item/grenade/proc/activate(var/mob/user)
	if(active)
		return

	if(user)
		msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

	icon_state = initial(icon_state) + "_active"
	active = 1
	playsound(loc, arm_sound, 75, 0, -3)

	spawn(det_time)
		detonate()
		return


/obj/item/grenade/proc/detonate()
//	playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
	var/turf/T = get_turf(src)
	if(T)
		T.hotspot_expose(700,125)


/obj/item/grenade/attackby(var/obj/item/W, var/mob/user)
	if(W.isscrewdriver())
		switch(det_time)
			if (1)
				det_time = 10
				user << "<span class='notice'>You set the [name] for 1 second detonation time.</span>"
			if (10)
				det_time = 30
				user << "<span class='notice'>You set the [name] for 3 second detonation time.</span>"
			if (30)
				det_time = 50
				user << "<span class='notice'>You set the [name] for 5 second detonation time.</span>"
			if (50)
				det_time = 1
				user << "<span class='notice'>You set the [name] for instant detonation.</span>"
		add_fingerprint(user)
	..()
	return

/obj/item/grenade/attack_hand()
	walk(src, null, null)
	..()
	return


/obj/item/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian, its very presence disrupts and dampens the powers of paranormal phenomenae."
	icon_state = "nullrod"
	item_state = "nullrod"
	slot_flags = SLOT_BELT
	force = 15
	throw_speed = 1
	throw_range = 4
	throwforce = 10
	w_class = 2

/obj/item/nullrod/attack(var/mob/M, var/mob/living/user) //Paste from old-code to decult with a null rod.

	M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been attacked with [src.name] by [user.name] ([user.ckey])</font>")
	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to attack [M.name] ([M.ckey])</font>")

	msg_admin_attack("[user.name] ([user.ckey]) attacked [M.name] ([M.ckey]) with [src.name] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	user.do_attack_animation(M)

	if (!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		user << "<span class='danger'>You don't have the dexterity to do this!</span>"
		return

/obj/item/energy_net
	name = "energy net"
	desc = "It's a net made of green energy."
	icon = 'icons/effects/effects.dmi'
	icon_state = "energynet"
	throwforce = 0
	force = 0
	var/net_type = /obj/effect/energy_net

/obj/item/energy_net/dropped()
	..()
	spawn(10)
		if(src) qdel(src)

/obj/item/energy_net/throw_impact(atom/hit_atom)
	..()

	var/mob/living/M = hit_atom

	if(!istype(M) || locate(/obj/effect/energy_net) in M.loc)
		qdel(src)
		return 0

	var/turf/T = get_turf(M)
	if(T)
		var/obj/effect/energy_net/net = new net_type(T)
		net.capture_mob(M)
		qdel(src)

	// If we miss or hit an obstacle, we still want to delete the net.
	spawn(10)
		if(src) qdel(src)

/obj/effect/energy_net
	name = "energy net"
	desc = "It's a net made of green energy."
	icon = 'icons/effects/effects.dmi'
	icon_state = "energynet"

	density = 1
	opacity = 0
	mouse_opacity = 1
	anchored = 1
	can_buckle = 0 //no manual buckling or unbuckling

	var/health = 25
	var/countdown = -1

/obj/effect/energy_net/teleport
	countdown = 60

/obj/effect/energy_net/proc/capture_mob(mob/living/M)
	if(M.buckled)
		M.buckled.unbuckle_mob()
	buckle_mob(M)

/obj/effect/energy_net/post_buckle_mob(mob/living/M)
	if(buckled_mob)
		layer = M.layer+1
		visible_message("\The [M] was caught in an energy net!")
	else
		M << "You are free of the net!"
		layer = initial(layer)
		qdel(src)

/obj/effect/energy_net/proc/healthcheck()
	if(health <=0)
		density = 0
		src.visible_message("The energy net is torn apart!")
		unbuckle_mob()

/obj/effect/energy_net/bullet_act(var/obj/item/projectile/Proj)
	health -= Proj.get_structure_damage()
	healthcheck()
	Proj.on_hit(src, 0)
	return 0

/obj/effect/energy_net/ex_act()
	health = 0
	healthcheck()

/obj/effect/energy_net/attack_hand(var/mob/user)

	var/mob/living/carbon/human/H = user
	if(istype(H))
		if(H.species.can_shred(H))
			playsound(src.loc, 'sound/weapons/slash.ogg', 80, 1)
			health -= rand(10, 20)
		else
			health -= rand(1,3)
	else
		health -= rand(5,8)

	H << "<span class='danger'>You claw at the energy net.</span>"

	healthcheck()
	return

/obj/effect/energy_net/attackby(var/obj/item/W, var/mob/user)
	health -= W.force
	healthcheck()
	..()


/obj/structure/closet/crate/secure
	desc = "A secure crate."
	name = "Secure crate"
	icon_state = "securecrate"
	icon_opened = "securecrateopen"
	icon_closed = "securecrate"
	var/redlight = "securecrater"
	var/greenlight = "securecrateg"
	var/sparks = "securecratesparks"
	var/emag = "securecrateemag"
	var/broken = 0
	var/locked = 1

/obj/structure/closet/crate/secure/New()
	..()
	if(locked)
		overlays.Cut()
		overlays += redlight
	else
		overlays.Cut()
		overlays += greenlight

/obj/structure/closet/crate/secure/can_open()
	return !locked

/obj/structure/closet/crate/secure/proc/togglelock(mob/user as mob)
	if(src.opened)
		user << "<span class='notice'>Close the crate first.</span>"
		return
	if(src.broken)
		user << "<span class='warning'>The crate appears to be broken.</span>"
		return
	if(src.allowed(user))
		set_locked(!locked, user)
	else
		user << "<span class='notice'>Access Denied</span>"

/obj/structure/closet/crate/secure/proc/set_locked(var/newlocked, mob/user = null)
	if(locked == newlocked) return

	locked = newlocked
	if(user)
		for(var/mob/O in viewers(user, 3))
			O.show_message( "<span class='notice'>The crate has been [locked ? null : "un"]locked by [user].</span>", 1)
	overlays.Cut()
	overlays += locked ? redlight : greenlight

/obj/structure/closet/crate/secure/verb/verb_togglelock()
	set src in oview(1) // One square distance
	set category = "Object"
	set name = "Toggle Lock"

	if(!usr.canmove || usr.stat || usr.restrained()) // Don't use it if you're not able to! Checks for stuns, ghost and restrain
		return

	if(ishuman(usr))
		src.add_fingerprint(usr)
		src.togglelock(usr)
	else
		usr << "<span class='warning'>This mob type can't use this verb.</span>"

/obj/structure/closet/crate/secure/attack_hand(mob/user as mob)
	src.add_fingerprint(user)
	if(locked)
		src.togglelock(user)
	else
		src.toggle(user)

/obj/structure/closet/crate/secure/attackby(obj/item/W as obj, mob/user as mob)
	if(is_type_in_list(W, list(/obj/item/stack/conduit/power, /obj/item/wirecutters)))
		return ..()
	if(!opened)
		src.togglelock(user)
		return
	return ..()

/obj/structure/closet/crate/secure/emp_act(severity)
	for(var/obj/O in src)
		O.emp_act(severity)
	if(!broken && !opened  && prob(50/severity))
		if(!locked)
			src.locked = 1
			overlays.Cut()
			overlays += redlight
		else
			overlays.Cut()
			overlays += emag
			overlays += sparks
			spawn(6) overlays -= sparks //Tried lots of stuff but nothing works right. so i have to use this *sadface*
			playsound(src.loc, 'sound/effects/sparks4.ogg', 75, 1)
			src.locked = 0
	if(!opened && prob(20/severity))
		if(!locked)
			open()
		else
			src.req_access = list()
			src.req_access += pick(get_all_station_access())
	..()

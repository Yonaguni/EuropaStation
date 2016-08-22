/obj/structure/crate/attack_hand(var/mob/user)
	add_fingerprint(user)
	toggle(user)

/obj/structure/crate/attack_generic(var/mob/user)
	attack_hand(user)

/obj/structure/crate/attackby(var/obj/item/W, var/mob/user)
	if(opened)
		if(store_mobs && istype(W, /obj/item/grab))
			var/obj/item/grab/G = W
			user.show_viewers("<span class='danger'>[user] stuffs \the [G.affecting] into \the [src]!</span>")
			G.affecting.forceMove(get_turf(src))
			return 0
		if(istype(W, /obj/item/weldingtool))
			var/obj/item/weldingtool/WT = W
			if(!WT.remove_fuel(0,user))
				if(!WT.isOn())
					return
				else
					user << "<span class='notice'>You need more welding fuel to complete this task.</span>"
					return
			new /obj/item/stack/material/steel(src.loc)
			for(var/mob/M in viewers(src))
				M.show_message("<span class='notice'>\The [src] has been cut apart by [user] with \the [WT].</span>", 3, "You hear welding.", 2)
			qdel(src)
			return
		if(W.loc != user) // This should stop mounted modules ending up outside the module.
			return
		user.drop_from_inventory(W)
		W.forceMove(src.loc)
	else if(can_weld && istype(W, /obj/item/weldingtool))
		var/obj/item/weldingtool/WT = W
		if(!WT.remove_fuel(0,user))
			if(!WT.isOn())
				return
			else
				user << "<span class='notice'>You need more welding fuel to complete this task.</span>"
				return
		welded = !src.welded
		src.update_icon()
		user.visible_message("<span class='danger'>\The [src] has been [welded ? "welded shut" : "unwelded"] by [user.name].</span>")
	else
		src.attack_hand(user)
	return

/obj/structure/crate/AltClick(var/mob/user)
	if(can_lock)
		add_fingerprint(user)
		toggle_lock(user)

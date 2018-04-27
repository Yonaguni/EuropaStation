/obj/item/gun/launcher/crossbow/speargun
	name = "speargun"
	desc = "A sleek black electrokinetic speargun for use by divers. Functions very poorly outside of an aquatic environment."
	icon = 'icons/obj/speargun.dmi'
	icon_state = "speargun"
	item_state = "cshotgun"
	base_icon = "speargun"
	slot_flags = SLOT_BELT
	var/obj/item/stack/rods/loaded_rods

/obj/item/gun/launcher/crossbow/speargun/Destroy()
	if(loaded_rods)
		qdel(loaded_rods)
		loaded_rods = null
	. = ..()

/obj/item/gun/launcher/crossbow/speargun/New()
	..()
	cell = new /obj/item/cell/high(src)

/obj/item/gun/launcher/crossbow/speargun/examine(var/mob/user)
	. = ..()
	if(.) to_chat(user, "It has [loaded_rods ? loaded_rods.amount : 0] shots remaining.")

/obj/item/gun/launcher/crossbow/speargun/update_icon()
	if(bolt)
		icon_state = "[base_icon]_loaded"
	else
		icon_state = "[base_icon]"

/obj/item/gun/launcher/crossbow/speargun/draw(var/mob/user)

	if(!cell || !cell.check_charge(50))
		to_chat(user, "<span class='warning'>\The [src] is out of battery charge.</span>")
		return

	if(bolt)
		to_chat(user, "<span class='warning'>\The [src] is already ready to fire.</span>")
		return
	if(loaded_rods)
		bolt = new /obj/item/arrow/rod(src)
		loaded_rods.use(1)
		if(loaded_rods.amount <= 0)
			loaded_rods = null
		playsound(user, 'sound/weapons/shotgunpump.ogg', 60, 1)
		to_chat(user, "<span class='notice'>You pump \the [src].</span>")
		update_icon()
	else
		handle_click_empty(user)

/obj/item/gun/launcher/crossbow/speargun/attackby(var/obj/item/W, var/mob/user)
	if(istype(W,/obj/item/stack/rods))
		var/obj/item/stack/rods/loading_rods = W
		if(loaded_rods)
			if(loaded_rods.amount < loaded_rods.max_amount)
				var/removing = min(loading_rods.amount, loaded_rods.max_amount - loaded_rods.amount)
				user.visible_message("<span class='notice'>\The [user] reloads \the [src] from \the [loading_rods].</span>")
				to_chat(user, "<span class='notice'>You loaded [removing] rod\s into \the [src].</span>")
				loaded_rods.add(removing)
				loading_rods.use(removing)
			else
				to_chat(user, "<span class='warning'>\The [src] is full.</span>")
			return
		else
			user.drop_from_inventory(loading_rods)
			loading_rods.forceMove(src)
			loaded_rods = loading_rods
			user.visible_message("<span class='notice'>\The [user] loads \the [src] with \the [loading_rods].</span>")
		return
	. = ..()

/obj/item/gun/launcher/crossbow/speargun/attack_self(var/mob/living/user)
	draw(user)

/obj/item/gun/launcher/crossbow/speargun/superheat_rod(var/mob/user)
	return

/obj/item/gun/launcher/crossbow/speargun/consume_next_projectile(mob/user=null)
	var/turf/T = get_turf(src)
	if(T && T.is_flooded() && cell && cell.check_charge(50))
		cell.use(50)
		tension = TRUE
		. = ..()

/obj/item/gun/launcher/crossbow/speargun/update_release_force()
	release_force = 20
	return release_force
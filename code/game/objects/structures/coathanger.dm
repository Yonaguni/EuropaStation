/obj/structure/coatrack
	name = "coat rack"
	desc = "Rack that holds coats."
	icon_state = "coatrack0"
	var/obj/item/clothing/suit/coat
	var/list/allowed = list(/obj/item/clothing/suit/storage)

/obj/structure/coatrack/attack_hand(mob/user as mob)
	user.visible_message("[user] takes [coat] off \the [src].", "You take [coat] off the \the [src]")
	if(!user.put_in_active_hand(coat))
		coat.loc = get_turf(user)
	coat = null
	update_icon()

/obj/structure/coatrack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	var/can_hang = 0
	for (var/T in allowed)
		if(istype(W,T))
			can_hang = 1
	if (can_hang && !coat)
		user.visible_message("[user] hangs [W] on \the [src].", "You hang [W] on the \the [src]")
		coat = W
		user.drop_from_inventory(coat, src)
		update_icon()
	else
		user << "<span class='notice'>You cannot hang [W] on [src]</span>"
		return ..()

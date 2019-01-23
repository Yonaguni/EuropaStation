/obj/item/clothing/accessory/storage
	name = "load bearing equipment"
	desc = "Used to hold things when you don't have enough hands."
	icon_state = "webbing"
	slot = ACCESSORY_SLOT_UTILITY
	var/slots = 3
	var/max_w_class = ITEM_SIZE_SMALL //pocket sized
	var/obj/item/weapon/storage/internal/pockets/hold
	w_class = ITEM_SIZE_NORMAL
	high_visibility = 1

/obj/item/clothing/accessory/storage/Initialize()
	. = ..()
	create_storage()

/obj/item/clothing/accessory/storage/proc/create_storage()
	hold = new/obj/item/weapon/storage/internal/pockets(src, slots, max_w_class)

/obj/item/clothing/accessory/storage/attack_hand(mob/user as mob)
	if(has_suit && hold)	//if we are part of a suit
		hold.open(user)
		return

	if(hold && hold.handle_attack_hand(user))	//otherwise interact as a regular storage item
		..(user)

/obj/item/clothing/accessory/storage/MouseDrop(obj/over_object as obj)
	if(has_suit)
		return

	if(hold && hold.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/accessory/storage/attackby(obj/item/W as obj, mob/user as mob)
	if(hold)
		return hold.attackby(W, user)

/obj/item/clothing/accessory/storage/emp_act(severity)
	if(hold)
		hold.emp_act(severity)
		..()

/obj/item/clothing/accessory/storage/attack_self(mob/user as mob)
	to_chat(user, "<span class='notice'>You empty [src].</span>")
	var/turf/T = get_turf(src)
	hold.hide_from(usr)
	for(var/obj/item/I in hold)
		hold.remove_from_storage(I, T, 1)
	hold.finish_bulk_removal()
	src.add_fingerprint(user)

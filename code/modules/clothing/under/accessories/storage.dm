/obj/item/clothing/accessory/storage
	name = "load bearing equipment"
	desc = "Used to hold things when you don't have enough hands."
	icon_state = "webbing"
	slot = "utility"
	show_messages = 1

	var/slots = 3
	var/obj/item/weapon/storage/internal/hold
	w_class = 3.0

/obj/item/clothing/accessory/storage/New()
	..()
	hold = new/obj/item/weapon/storage/internal(src)
	hold.storage_slots = slots

/obj/item/clothing/accessory/storage/attack_hand(mob/user as mob)
	if (has_suit)	//if we are part of a suit
		hold.open(user)
		return

	if (hold.handle_attack_hand(user))	//otherwise interact as a regular storage item
		..(user)

/obj/item/clothing/accessory/storage/MouseDrop(obj/over_object as obj)
	if (has_suit)
		return

	if (hold.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/accessory/storage/attackby(obj/item/W as obj, mob/user as mob)
	return hold.attackby(W, user)

/obj/item/clothing/accessory/storage/emp_act(severity)
	hold.emp_act(severity)
	..()

/obj/item/clothing/accessory/storage/attack_self(mob/user as mob)
	user << "<span class='notice'>You empty [src].</span>"
	var/turf/T = get_turf(src)
	hold.hide_from(usr)
	for(var/obj/item/I in hold.contents)
		hold.remove_from_storage(I, T)
	src.add_fingerprint(user)

/obj/item/clothing/accessory/storage/webbing
	name = "webbing"
	desc = "Sturdy mess of synthcotton belts and buckles, ready to share your burden."
	icon_state = "webbing"

/obj/item/clothing/accessory/storage/black_vest
	name = "black webbing vest"
	desc = "Robust black synthcotton vest with lots of pockets to hold whatever you need, but cannot hold in hands."
	icon_state = "vest_black"
	slots = 5

/obj/item/clothing/accessory/storage/brown_vest
	name = "brown webbing vest"
	desc = "Worn brownish synthcotton vest with lots of pockets to unload your hands."
	icon_state = "vest_brown"
	slots = 5

/obj/item/clothing/accessory/storage/knifeharness
	name = "decorated harness"
	desc = "A heavily decorated harness of sinew and leather with two knife-loops."
	icon_state = "unathiharness2"
	slots = 2

/obj/item/clothing/accessory/storage/knifeharness/New()
	..()
	hold.max_storage_space = 4
	hold.can_hold = list(/obj/item/weapon/material/hatchet/unathiknife,\
	/obj/item/weapon/material/kitchen/utensil/knife,\
	/obj/item/weapon/material/kitchen/utensil/knife/plastic,\
	/obj/item/weapon/material/knife)

	new /obj/item/weapon/material/hatchet/unathiknife(hold)
	new /obj/item/weapon/material/hatchet/unathiknife(hold)

/obj/item/clothing/accessory/storage/bandolier
	name = "bandollier"
	desc = "Magazines are for pansies. Sling it over the shoulder or wear like a belt."
	icon_state = "bandolier"
	item_state = "bandolier"
	slots = 18
	slot_flags = SLOT_BELT|SLOT_TIE
	description_info = "Can be worn as a belt or as a clothing accessory. \
						Can only hold shells. Alt-click on it (or clothing it's attached to) \
						to remove one shell quickly."

/obj/item/clothing/accessory/storage/New()
	..()
	hold.max_w_class = 1
	hold.can_hold = list(/obj/item/ammo_casing)

/obj/item/clothing/accessory/storage/bandolier/AltClick(var/mob/user)
	if(!Adjacent(user))
		return ..()
	if(user.get_active_hand())
		user << "<span class='warning'>You need a free hand for that.</span>"
		return ..()
	var/list/ammo = hold.return_inv()
	if(!ammo.len)
		user << "<span class='warning'>\The [src] is empty.</span>"
		return ..()
	var/obj/removed = ammo[1]
	if(hold.remove_from_storage(removed,user))
		user << "<span class='notice'>You take \the [removed] out of \the [src].</span>"
		user.put_in_hands(removed)

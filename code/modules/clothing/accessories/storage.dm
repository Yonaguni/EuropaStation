/obj/item/clothing/accessory/storage
	name = "load bearing equipment"
	desc = "Used to hold things when you don't have enough hands."
	icon_state = "webbing"
	slot = "utility"
	var/slots = 3
	var/max_w_class = 2 //pocket sized
	var/obj/item/storage/internal/pockets/hold
	w_class = 3

/obj/item/clothing/accessory/storage/New()
	..()
	hold = new/obj/item/storage/internal/pockets(src, slots, max_w_class)

/obj/item/clothing/accessory/storage/attack_hand(var/mob/user)
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

/obj/item/clothing/accessory/storage/attackby(obj/item/W as obj, var/mob/user)
	return hold.attackby(W, user)

/obj/item/clothing/accessory/storage/emp_act(severity)
	hold.emp_act(severity)
	..()

/obj/item/clothing/accessory/storage/attack_self(var/mob/user)
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

/obj/item/clothing/accessory/storage/webbing_large
	name = "large webbing"
	desc = "A large collection of synthcotton pockets and pouches."
	icon_state = "webbing_large"
	slots = 4

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

/obj/item/clothing/accessory/storage/white_vest
	name = "white webbing vest"
	desc = "Durable white synthcotton vest with lots of pockets to carry essentials."
	icon_state = "vest_white"
	slots = 5

/obj/item/clothing/accessory/storage/knifeharness
	name = "decorated harness"
	desc = "A heavily decorated harness of sinew and leather with two knife-loops."
	icon_state = "unathiharness2"
	slots = 2
	max_w_class = 3 //for knives

/obj/item/clothing/accessory/storage/knifeharness/New()
	..()
	hold.can_hold = list(
		/obj/item/material/hatchet,
		/obj/item/material/kitchen/utensil/knife,
		/obj/item/material/knife,
		/obj/item/material/butterfly,
	)

	new /obj/item/material/hatchet/duellingknife(hold)
	new /obj/item/material/hatchet/duellingknife(hold)

/obj/item/clothing/accessory/storage/bandolier
	name = "bandolier"
	desc = "A lightweight synthethic bandolier with straps for holding ammunition or other small objects."
	icon_state = "bandolier"
	slots = 10
	max_w_class = 3

/obj/item/clothing/accessory/storage/bandolier/New()
	..()
	hold.can_hold = list(
		/obj/item/ammo_casing,
		/obj/item/grenade,
		/obj/item/material/hatchet/tacknife,
		/obj/item/material/kitchen/utensil/knife,
		/obj/item/material/knife,
		/obj/item/material/star,
		/obj/item/rcd_ammo,
		/obj/item/reagent_containers/syringe,
		/obj/item/syringe_cartridge,
		/obj/item/plastique,
		/obj/item/clothing/mask/smokable
	)


/obj/structure/closet/secure_closet/security
	name = "officer's locker"
	req_access = list(access_brig)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_broken = "secbroken"
	icon_off = "secoff"

	New()
		..()
		new /obj/item/storage/backpack/dufflebag/sec(src)
		new /obj/item/clothing/suit/armour(src)
		new /obj/item/clothing/head/helmet(src)
		new /obj/item/storage/belt/security(src)
		new /obj/item/flash(src)
		new /obj/item/reagent_containers/spray/pepper(src)
		new /obj/item/grenade/chem_grenade/teargas(src)
		new /obj/item/melee/baton/loaded(src)
		new /obj/item/clothing/glasses/sunglasses/sechud(src)
		new /obj/item/taperoll/police(src)
		new /obj/item/hailer(src)
		new /obj/item/clothing/head/soft(src)
		new /obj/item/clothing/under/jumpsuit/red(src)
		new /obj/item/gun/composite/premade/taser_pistol(src)
		new /obj/item/clothing/accessory/holster/armpit(src)

/obj/structure/closet/secure_closet/security/police
	icon_state =  "pol1"
	icon_closed = "pol"
	icon_locked = "pol1"
	icon_opened = "polopen"
	icon_broken = "polbroken"
	icon_off =    "poloff"

/obj/structure/closet/secure_closet/wall
	name = "wall locker"
	req_access = list(access_security)
	icon_state = "wall-locker1"
	density = 1
	icon_closed = "wall-locker"
	icon_locked = "wall-locker1"
	icon_opened = "wall-lockeropen"
	icon_broken = "wall-lockerbroken"
	icon_off = "wall-lockeroff"

	//too small to put a man in
	large = 0

/obj/structure/closet/secure_closet/wall/update_icon()
	if(broken)
		icon_state = icon_broken
	else
		if(!opened)
			if(locked)
				icon_state = icon_locked
			else
				icon_state = icon_closed
		else
			icon_state = icon_opened

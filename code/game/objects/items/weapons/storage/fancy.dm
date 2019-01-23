/*
 * The 'fancy' path is for objects like candle boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldnt think of a better one.
 *
 *
 * Contains:
 *		Egg Box
 *		Crayon Box
 *		Cigarette Box
 */

/obj/item/weapon/storage/fancy
	item_state = "syringe_kit" //placeholder, many of these don't have inhands
	opened = 0 //if an item has been removed from this container
	var/obj/item/key_type //path of the key item that this "fancy" container is meant to store

/obj/item/weapon/storage/fancy/on_update_icon()
	if(!opened)
		src.icon_state = initial(icon_state)
	else
		var/key_count = count_by_type(contents, key_type)
		src.icon_state = "[initial(icon_state)][key_count]"

/obj/item/weapon/storage/fancy/examine(mob/user)
	if(!..(user, 1))
		return

	var/key_name = initial(key_type.name)
	if(!contents.len)
		to_chat(user, "There are no [key_name]s left in the box.")
	else
		var/key_count = count_by_type(contents, key_type)
		to_chat(user, "There [key_count == 1? "is" : "are"] [key_count] [key_name]\s in the box.")

/*
 * Egg Box
 */

/obj/item/weapon/storage/fancy/egg_box
	icon = 'icons/obj/food.dmi'
	icon_state = "eggbox"
	name = "egg box"
	storage_slots = 12
	max_w_class = ITEM_SIZE_SMALL
	w_class = ITEM_SIZE_NORMAL

	key_type = /obj/item/weapon/reagent_containers/food/snacks/egg
	can_hold = list(
		/obj/item/weapon/reagent_containers/food/snacks/egg,
		/obj/item/weapon/reagent_containers/food/snacks/boiledegg
		)

	startswith = list(/obj/item/weapon/reagent_containers/food/snacks/egg = 12)

/obj/item/weapon/storage/fancy/egg_box/empty
	startswith = null

/*
 * Cracker Packet
 */

/obj/item/weapon/storage/fancy/crackers
	name = "\improper Getmore Crackers"
	icon = 'icons/obj/food.dmi'
	icon_state = "crackerbag"
	storage_slots = 6
	max_w_class = ITEM_SIZE_TINY
	w_class = ITEM_SIZE_SMALL
	key_type = /obj/item/weapon/reagent_containers/food/snacks/cracker
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/cracker)
	startswith = list(/obj/item/weapon/reagent_containers/food/snacks/cracker = 6)

/*
 * Crayon Box
 */

/obj/item/weapon/storage/fancy/crayons
	name = "box of crayons"
	desc = "A box of crayons for all your rune drawing needs."
	icon = 'icons/obj/crayons.dmi'
	icon_state = "crayonbox"
	w_class = ITEM_SIZE_SMALL
	max_w_class = ITEM_SIZE_TINY
	max_storage_space = 6

	key_type = /obj/item/weapon/pen/crayon
	startswith = list(
		/obj/item/weapon/pen/crayon/red,
		/obj/item/weapon/pen/crayon/orange,
		/obj/item/weapon/pen/crayon/yellow,
		/obj/item/weapon/pen/crayon/green,
		/obj/item/weapon/pen/crayon/blue,
		/obj/item/weapon/pen/crayon/purple,
		)

/obj/item/weapon/storage/fancy/crayons/on_update_icon()
	overlays = list() //resets list
	overlays += image('icons/obj/crayons.dmi',"crayonbox")
	for(var/obj/item/weapon/pen/crayon/crayon in contents)
		overlays += image('icons/obj/crayons.dmi',crayon.colourName)

////////////
//CIG PACK//
////////////
/obj/item/weapon/storage/fancy/cigarettes
	name = "pack of Trans-Stellar Duty-frees"
	desc = "A ubiquitous brand of cigarettes, found in the facilities of every major spacefaring corporation in the universe. As mild and flavorless as it gets."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigpacket"
	item_state = "cigpacket"
	w_class = ITEM_SIZE_SMALL
	max_w_class = ITEM_SIZE_TINY
	max_storage_space = 6
	throwforce = 2
	slot_flags = SLOT_BELT

	key_type = /obj/item/clothing/mask/smokable/cigarette
	startswith = list(/obj/item/clothing/mask/smokable/cigarette = 6)

/obj/item/weapon/storage/fancy/cigarettes/New()
	..()
	atom_flags |= ATOM_FLAG_NO_REACT|ATOM_FLAG_OPEN_CONTAINER
	create_reagents(5 * max_storage_space)//so people can inject cigarettes without opening a packet, now with being able to inject the whole one

/obj/item/weapon/storage/fancy/cigarettes/remove_from_storage(obj/item/W as obj, atom/new_location)
	// Don't try to transfer reagents to lighters
	if(istype(W, /obj/item/clothing/mask/smokable/cigarette))
		var/obj/item/clothing/mask/smokable/cigarette/C = W
		reagents.trans_to_obj(C, (reagents.total_volume/contents.len))
	..()

/obj/item/weapon/storage/fancy/cigarettes/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return

	if(M == user && user.zone_sel.selecting == BP_MOUTH && contents.len > 0 && !user.wear_mask)
		// Find ourselves a cig. Note that we could be full of lighters.
		var/obj/item/clothing/mask/smokable/cigarette/cig = null
		for(var/obj/item/clothing/mask/smokable/cigarette/C in contents)
			cig = C
			break

		if(cig == null)
			to_chat(user, "<span class='notice'>Looks like the packet is out of cigarettes.</span>")
			return

		// Instead of running equip_to_slot_if_possible() we check here first,
		// to avoid dousing cig with reagents if we're not going to equip it
		if(!cig.mob_can_equip(user, slot_wear_mask))
			return

		// We call remove_from_storage first to manage the reagent transfer and
		// UI updates.
		remove_from_storage(cig, null)
		user.equip_to_slot(cig, slot_wear_mask)

		reagents.maximum_volume = 5 * contents.len
		to_chat(user, "<span class='notice'>You take a cigarette out of the pack.</span>")
		update_icon()
	else
		..()

/*
 * Vial Box
 */

/obj/item/weapon/storage/fancy/vials
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox"
	name = "vial storage box"
	w_class = ITEM_SIZE_NORMAL
	max_w_class = ITEM_SIZE_TINY
	storage_slots = 12

	key_type = /obj/item/weapon/reagent_containers/glass/beaker/vial
	startswith = list(/obj/item/weapon/reagent_containers/glass/beaker/vial = 12)

/obj/item/weapon/storage/fancy/vials/on_update_icon()
	var/key_count = count_by_type(contents, key_type)
	src.icon_state = "[initial(icon_state)][Floor(key_count/2)]"

/*
 * Not actually a "fancy" storage...
 */
/obj/item/weapon/storage/lockbox/vials
	name = "secure vial storage box"
	desc = "A locked box for keeping things away from children."
	icon = 'icons/obj/vialbox.dmi'
	icon_state = "vialbox0"
	item_state = "syringe_kit"
	w_class = ITEM_SIZE_NORMAL
	max_w_class = ITEM_SIZE_TINY
	max_storage_space = null
	storage_slots = 12
	req_access = list(access_medical)

/obj/item/weapon/storage/lockbox/vials/New()
	..()
	update_icon()

/obj/item/weapon/storage/lockbox/vials/on_update_icon()
	var/total_contents = count_by_type(contents, /obj/item/weapon/reagent_containers/glass/beaker/vial)
	src.icon_state = "vialbox[Floor(total_contents/2)]"
	src.overlays.Cut()
	if (!broken)
		overlays += image(icon, src, "led[locked]")
		if(locked)
			overlays += image(icon, src, "cover")
	else
		overlays += image(icon, src, "ledb")
	return

/obj/item/weapon/storage/lockbox/vials/attackby(obj/item/weapon/W as obj, mob/user as mob)
	. = ..()
	update_icon()

/*
 *	Everything derived from the common cardboard box.
 *	Basically everything except the original is a kit (starts full).
 *
 *	Contains:
 *		Empty box, starter boxes (survival/engineer),
 *		Latex glove and sterile mask boxes,
 *		Syringe, beaker, dna injector boxes,
 *		Blanks, flashbangs, and EMP grenade boxes,
 *		Tracking and chemical implant boxes,
 *		Prescription glasses and drinking glass boxes,
 *		Condiment bottle and silly cup boxes,
 *		Donkpocket and monkeycube boxes,
 *		ID and security PDA cart boxes,
 *		Handcuff, mousetrap, and pillbottle boxes,
 *		Snap-pops and matchboxes,
 *		Replacement light boxes.
 *
 *		For syndicate call-ins see uplink_kits.dm
 */

/obj/item/weapon/storage/box
	name = "box"
	desc = "It's just an ordinary box."
	icon_state = "box"
	item_state = "syringe_kit"
	max_storage_space = DEFAULT_BOX_STORAGE
	use_sound = 'sound/effects/storage/box.ogg'
	var/foldable = /obj/item/stack/material/cardboard	// BubbleWrap - if set, can be folded (when empty) into a sheet of cardboard

/obj/item/weapon/storage/box/large
	name = "large box"
	icon_state = "largebox"
	w_class = ITEM_SIZE_LARGE
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = DEFAULT_LARGEBOX_STORAGE

/obj/item/weapon/storage/box/union_cards
	name = "box of union cards"
	desc = "A box of spare unsigned union membership cards."
	startswith = list(/obj/item/weapon/card/union = 7)

/obj/item/weapon/storage/box/large/union_cards
	name = "large box of union cards"
	desc = "A large box of spare unsigned union membership cards."
	startswith = list(/obj/item/weapon/card/union = 14)

// BubbleWrap - A box can be folded up to make card
/obj/item/weapon/storage/box/attack_self(mob/user as mob)
	if(..()) return

	//try to fold it.
	if ( contents.len )
		return

	if ( !ispath(src.foldable) )
		return
	var/found = 0
	// Close any open UI windows first
	for(var/mob/M in range(1))
		if (M.s_active == src)
			src.close(M)
		if ( M == user )
			found = 1
	if ( !found )	// User is too far away
		return
	// Now make the cardboard
	to_chat(user, "<span class='notice'>You fold [src] flat.</span>")
	if(ispath(foldable, /obj/item/stack))
		var/stack_amt = max(2**(w_class - 3), 1)
		new src.foldable(get_turf(src), stack_amt)
	else
		new src.foldable(get_turf(src))
	qdel(src)

/obj/item/weapon/storage/box/make_exact_fit()
	..()
	foldable = null //special form fitted boxes should not be foldable.

/obj/item/weapon/storage/box/survival
	name = "crew survival kit"
	desc = "A box decorated in warning colors that contains a limited supply of survival tools. The panel and white stripe indicate this one contains oxygen."
	icon_state = "survival"
	startswith = list(/obj/item/clothing/mask/breath = 1,
					/obj/item/weapon/tank/emergency/oxygen = 1,
					/obj/item/weapon/reagent_containers/hypospray/autoinjector = 1,
					/obj/item/stack/medical/bruise_pack = 1,
					/obj/item/device/flashlight/flare/glowstick = 1,
					/obj/item/weapon/reagent_containers/food/snacks/candy/proteinbar = 1,
					/obj/item/device/oxycandle = 1)

/obj/item/weapon/storage/box/freezer
	name = "portable freezer"
	desc = "This nifty shock-resistant device will keep your 'groceries' nice and non-spoiled."
	icon = 'icons/obj/storage.dmi'
	icon_state = "portafreezer"
	item_state = "medicalpack"
	foldable = null
	max_w_class = ITEM_SIZE_NORMAL
	w_class = ITEM_SIZE_HUGE
	can_hold = list(/obj/item/organ, /obj/item/weapon/reagent_containers/food, /obj/item/weapon/reagent_containers/glass)
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	use_to_pickup = 1 // for picking up broken bulbs, not that most people will try
	temperature = -16 CELCIUS

/obj/item/weapon/storage/box/freezer/ProcessAtomTemperature()
	return PROCESS_KILL

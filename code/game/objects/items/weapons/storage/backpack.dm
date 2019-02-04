
/*
 * Backpack
 */

/obj/item/weapon/storage/backpack
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_backpacks.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_backpacks.dmi',
		)
	icon_state = "backpack"
	item_state = null
	//most backpacks use the default backpack state for inhand overlays
	item_state_slots = list(
		slot_l_hand_str = "backpack",
		slot_r_hand_str = "backpack",
		)
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BACK
	max_w_class = ITEM_SIZE_LARGE
	max_storage_space = DEFAULT_BACKPACK_STORAGE

/obj/item/weapon/storage/backpack/equipped()
	if(!has_extension(src, /datum/extension/appearance))
		set_extension(src, /datum/extension/appearance, /datum/extension/appearance/cardborg)
	..()

/obj/item/weapon/storage/backpack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	return ..()

/obj/item/weapon/storage/backpack/equipped(var/mob/user, var/slot)
	if (slot == slot_back && src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	..(user, slot)

/*
 * Duffle Types
 */
/obj/item/weapon/storage/backpack/dufflebag
	name = "dufflebag"
	desc = "A large dufflebag for holding extra things."
	icon_state = "duffle"
	item_state_slots = null
	w_class = ITEM_SIZE_HUGE
	max_storage_space = DEFAULT_BACKPACK_STORAGE + 10

/obj/item/weapon/storage/backpack/dufflebag/New()
	..()
	slowdown_per_slot[slot_back] = 3
	slowdown_per_slot[slot_r_hand] = 1
	slowdown_per_slot[slot_l_hand] = 1

/obj/item/weapon/storage/backpack/dufflebag/syndie
	name = "black dufflebag"
	desc = "A large dufflebag for holding extra tactical supplies."
	icon_state = "duffle_syndie"

/obj/item/weapon/storage/backpack/dufflebag/syndie/New()
	..()
	slowdown_per_slot[slot_back] = 1

/*
 * Satchel Types
 */
/obj/item/weapon/storage/backpack/satchel
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"

/obj/item/weapon/storage/backpack/satchel/pocketbook //black, master type
	name = "black pocketbook"
	desc = "A neat little folding clasp pocketbook with a shoulder sling."
	icon_state = "pocketbook"
	w_class = ITEM_SIZE_HUGE // to avoid recursive backpacks
	slot_flags = SLOT_BACK
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = DEFAULT_LARGEBOX_STORAGE
	color = "#212121"

//Smuggler's satchel
/obj/item/weapon/storage/backpack/satchel/flat
	name = "\improper Smuggler's satchel"
	desc = "A very slim satchel that can easily fit into tight spaces."
	icon_state = "satchel-flat"
	item_state = "satchel-norm"
	level = 1
	w_class = ITEM_SIZE_NORMAL //Can fit in backpacks itself.
	storage_slots = 5
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = 15
	cant_hold = list(/obj/item/weapon/storage/backpack/satchel/flat) //muh recursive backpacks
	startswith = list(
		/obj/item/stack/tile/floor,
		/obj/item/weapon/crowbar
		)

/obj/item/weapon/storage/backpack/satchel/flat/MouseDrop(var/obj/over_object)
	var/turf/T = get_turf(src)
	if(hides_under_flooring() && isturf(T) && !T.is_plating())
		return
	..()

/obj/item/weapon/storage/backpack/satchel/flat/hide(var/i)
	set_invisibility(i ? 101 : 0)
	anchored = i ? TRUE : FALSE
	alpha = i ? 128 : initial(alpha)

/obj/item/weapon/storage/backpack/satchel/flat/attackby(obj/item/W, mob/user)
	var/turf/T = get_turf(src)
	if(hides_under_flooring() && isturf(T) && !T.is_plating())
		to_chat(user, "<span class='warning'>You must remove the plating first.</span>")
		return 1
	return ..()

/*
 * Messenger Bags
 */
/obj/item/weapon/storage/backpack/messenger
	name = "messenger bag"
	desc = "A sturdy backpack worn over one shoulder."
	icon_state = "courierbag"

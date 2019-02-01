/obj/item/clothing/ears
	name = "ears"
	icon = 'icons/obj/clothing/obj_ears.dmi'
	w_class = ITEM_SIZE_TINY
	throwforce = 2
	slot_flags = SLOT_EARS

/obj/item/clothing/ears/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_ears()

/obj/item/clothing/ears/earmuffs
	name = "earmuffs"
	desc = "Protects your hearing from loud noises, and quiet ones as well."
	icon_state = "earmuffs"
	item_state = "earmuffs"
	slot_flags = SLOT_EARS | SLOT_TWOEARS

/obj/item/clothing/ears/hairflower
	name = "flower pin"
	icon_state = "hairflower"
	desc = "It smells nice."
	slot_flags = SLOT_EARS
	body_parts_covered = 0
	color = COLOR_RED

POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/ears/hairflower, "flower pin")

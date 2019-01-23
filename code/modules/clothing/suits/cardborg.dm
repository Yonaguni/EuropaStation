/obj/item/clothing/suit/cardborg
	name = "cardborg suit"
	desc = "An ordinary cardboard box with holes cut in the sides."
	icon_state = "cardborg"
	item_state = "cardborg"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/cardborg/Initialize()
	. = ..()
	set_extension(src, /datum/extension/appearance, /datum/extension/appearance/cardborg)

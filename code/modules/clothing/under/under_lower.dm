/obj/item/clothing/under/lower
	under_type = PARTIAL_UNIFORM_LOWER
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_uniforms.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_uniforms.dmi',
		slot_w_uniform_str = 'icons/mob/onmob/onmob_under_lower.dmi'
	)
	color = COLOR_BLACK

/obj/item/clothing/under/lower/shorts
	name = "shorts"
	desc = "They're comfy and easy to wear!"
	color = COLOR_GRAY
	icon_state = "shorts"
	gender = PLURAL

/obj/item/clothing/under/lower/pants
	name = "pants"
	icon_state = "pants"
	desc = "Pretty boring."
	gender = PLURAL

/obj/item/clothing/under/lower/dresspants
	name = "dress pants"
	desc = "Looking sharp."
	icon_state = "dresspants"
	gender = PLURAL

/obj/item/clothing/under/lower/skirt
	name = "skirt"
	desc = "A short skirt. Goes well with a long jacket."
	icon_state = "skirt"

/obj/item/clothing/under/lower/skirt/skater
	name = "skater skirt"
	desc = "A skater skirt. See you later, boy."
	icon_state = "skateskirt"

POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/lower/shorts,       "shorts")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/lower/pants,        "pants")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/lower/dresspants,   "dress pants")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/lower/skirt,        "skirt")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/lower/skirt/skater, "skater skirt")
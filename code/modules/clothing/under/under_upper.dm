/obj/item/clothing/under/upper
	under_type = PARTIAL_UNIFORM_UPPER
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_uniforms.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_uniforms.dmi',
		slot_w_uniform_str = 'icons/mob/onmob/onmob_under_upper.dmi'
	)
	color = COLOR_BLACK

/obj/item/clothing/under/upper/shirt
	name = "shirt"
	desc = "A popular garment."
	icon_state = "shirt"

/obj/item/clothing/under/upper/singlet
	name = "singlet"
	desc = "Possibly the single trashiest garment."
	icon_state = "singlet"

/obj/item/clothing/under/upper/business
	name = "collared shirt"
	desc = "Whoever is wearing this is all business."
	icon_state = "business_shirt"

/obj/item/clothing/under/upper/chemise
	name = "chemise"
	desc = "A chemise."
	icon_state = "chemise"

/obj/item/clothing/under/upper/longsleeve
	name = "long-sleeved shirt"
	desc = "Your arms might get hot."
	icon_state = "longsleeve"

POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/upper/shirt,        "shirt")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/upper/singlet,      "singlet")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/upper/business,     "button-up shirt")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/upper/chemise,      "chemise")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/under/upper/longsleeve,   "long-sleeved shirt")
/obj/item/clothing/head/hijab
	name = "hijab"
	desc = "A veil which is wrapped to cover the head and chest."
	icon_state = "hijab"
	body_parts_covered = 0
	flags_inv = BLOCKHAIR

/obj/item/clothing/head/kippa
	name = "kippa"
	desc = "A small, brimless cap."
	icon_state = "kippa"
	body_parts_covered = 0

/obj/item/clothing/head/turban
	name = "turban"
	desc = "A sturdy cloth, worn around the head."
	icon_state = "turban"
	body_parts_covered = 0
	flags_inv = BLOCKHEADHAIR //Shows beards!

/obj/item/clothing/head/surgery
	name = "surgical cap"
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs."
	icon_state = "surgery_cap"
	flags_inv = BLOCKHEADHAIR
	color = COLOR_GREEN

/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, favoured headwear of artists and military nerds."
	icon_state = "beret"
	body_parts_covered = 0
	color = COLOR_RED

/obj/item/clothing/head/bandana
	name = "bandana"
	desc = "It's a bandana with a fine silk lining."
	icon_state = "bandana"
	item_state = "bandana"
	flags_inv = 0
	body_parts_covered = 0
	color = COLOR_ORANGE

POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/head/beret, "beret")
POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/head/bandana, "bandana")

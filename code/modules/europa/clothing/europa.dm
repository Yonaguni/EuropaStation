/*
 * Civilian One Piece Outfits
 */

/obj/item/clothing/under/janitor
	name = "custodial uniform"
	desc = "Hard-wearing clothes for a janitor on the go."
	icon_state = "janitor"

/obj/item/clothing/under/wetsuit
	name = "wetsuit"
	desc = "A sleek, close-fitting suit that provides warmth when swimming. This one has blue stripes."
	icon_state = "wetsuit"

/obj/item/clothing/under/hireling
	name = "rough clothes"
	desc = "A rather ominous set of hard-worn clothes."
	icon_state = "hireling_uniform"

/obj/item/clothing/under/manager
	name = "manager's uniform"
	desc = "Smells faintly of existential despair."
	icon_state = "middle_manager"

/*
 * Government Uniforms
 */

/obj/item/clothing/under/petty_officer
	name = "petty officer's fatigues"
	desc = "Standard government fatigues sporting a grey camo design. The insignia on the collar denotes the wearer to be a colonial petty officer under the administration of the SDPE."
	icon_state = "petty_officer"
	worn_state = "petty_officer"

/obj/item/clothing/under/petty_officer/marshal
	name = "marshal's fatigues"
	desc = "High ranking government fatigues with a grey digital camo design and gold embroidery. The gold trims denote the wearer to be a colonial marshall under the administration of the SDPE."
	icon_state = "marshal"
	worn_state = "marshal"

/obj/item/clothing/under/sailor
	name = "sailor's fatigues"
	desc = "Standard pair of sailor's fatigues. Featuring dark blue trims with a gold logo."
	icon_state = "sailor"
	worn_state = "sailor"

/obj/item/clothing/under/military
	name = "naval uniform"
	desc = "A set of hard-wearing fatigues for naval personnel."
	icon_state = "military_uniform"
	worn_state = "military_uniform"

/obj/item/clothing/under/military/formal
	name = "formal naval uniform"
	desc = "A particularly fancy military uniform."
	icon_state = "military_fancy"
	worn_state = "military_fancy"

/obj/item/clothing/under/military/formal/alt
	icon_state = "military_fancy_alt"
	worn_state = "military_fancy_alt"

/*
 * Industrial Sector
 */

/obj/item/clothing/under/wetsuit/miner
	name = "miner's wetsuit"
	desc = "A sleek, close-fitting suit that provides warmth when swimming. This one is brown with yellow stripes."
	icon_state = "minerwetsuit"

/obj/item/clothing/suit/space/diver/heavy
	name = "heavy diver's suit"
	icon_state = "heavydiver"
	item_state = "heavydiver"
	desc = "A bulky and large diver's suit."
	armor = list(melee = 40, bullet = 30)

/obj/item/clothing/head/helmet/space/diver/heavy
	name = "heavy diver's helmet"
	icon_state = "heavydiver"
	item_state = "heavydiver"
	desc = "A bulky and large diver's helmet."
	armor = list(melee = 20, bullet = 15)

/obj/item/clothing/suit/space/diver/medium
	name = "medium diver's suit"
	icon_state = "mediumdiver"
	item_state = "hmediumdiver"
	desc = "A bulky, normal sized diver's suit."
	armor = list(melee = 30, bullet = 15)

/obj/item/clothing/head/helmet/space/diver/medium
	name = "medium diver's helmet"
	icon_state = "mediumdiver"
	item_state = "mediumdiver"
	desc = "A bulky, normal sized diver's helmet."
	armor = list(melee = 10, bullet = 5)

/obj/item/clothing/suit/space/diver/light
	name = "light diver's suit"
	icon_state = "lightdiver"
	item_state = "lightdiver"
	desc = "A light diver's suit."

/obj/item/clothing/head/helmet/space/diver/light
	name = "light diver's helmet"
	icon_state = "lightdiver"
	item_state = "lightdiver"
	desc = "A light diver's helmet."

/obj/item/clothing/suit/space/diving
	name = "diving suit"
	desc = "A light diving suit suitable for shallow excursions."
	icon_state = "diving_light"

/obj/item/clothing/head/helmet/space/diving
	name = "diving helmet"
	desc = "A light diving helmet suitable for shallow excursions."
	icon_state = "diving_light"
	light_overlay = "hardhat_light"
	flags_inv = HIDEMASK | HIDEEARS | HIDEEYES | BLOCKHAIR

/obj/item/clothing/suit/space/diving/medium
	name = "reinforced diving suit"
	desc = "A reinforced diving suit suitable for excursions of brief duration."
	icon_state = "diving_medium"

/obj/item/clothing/head/helmet/space/diving/medium
	name = "reinforced diving helmet"
	desc = "A reinforced diving helmet suitable for excursions of brief duration."
	icon_state = "diving_medium"
	light_overlay = "helmet_light"

/obj/item/clothing/suit/space/diving/heavy
	name = "armoured diving suit"
	desc = "A heavy, armoured diving suit suitable for extended excursions."
	icon_state = "diving_heavy"

/obj/item/clothing/head/helmet/space/diving/heavy
	name = "armoured diving helmet"
	desc = "A heavy, armoured diving helmet suitable for extended excursions."
	icon_state = "diving_heavy"
	light_overlay = "helmet_light_dual"

/obj/item/weapon/storage/box/divingsuit
	name = "diving suit box"
	desc = "A box containing a complete diving suit."

/obj/item/weapon/storage/box/divingsuit/New()
	..()
	new /obj/item/clothing/suit/space/diving/medium(src)
	new /obj/item/clothing/head/helmet/space/diving/medium(src)
	new /obj/item/weapon/tank/emergency/oxygen/engi(src)
	make_exact_fit()

//Government
/obj/item/clothing/head/petty_officer/marshal
	name = "marshal's cap"
	desc = "A soft grey camo cap with a golden insignia for a government marshal."
	icon_state = "marshal_cap"

/obj/item/clothing/head/petty_officer
	name = "petty officer's cap"
	desc = "A soft grey camo cap for government petty pfficers."
	icon_state = "petty_officer_cap"

/obj/item/clothing/head/petty_officer/parade
	name = "petty officer's parade cap"
	desc = "A sturdy grey hat fit for formal occasions."
	icon_state = "petty_officer_parade_cap"

/obj/item/clothing/head/petty_officer/parade/marshal
	name = "marshal's parade hat"
	desc = "A decorated formal hat that announces your official presence."
	icon_state = "marshal_parade_cap"

/obj/item/clothing/head/military
	name = "armoured helmet"
	desc = "An armoured helmet with a respirator."
	icon_state = "military_helmet"

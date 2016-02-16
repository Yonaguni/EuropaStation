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
	new /obj/item/weapon/tank/emergency_oxygen/engi(src)

/obj/item/weapon/storage/box/divingsuit
	name = "diving suit box"
	desc = "A box containing a complete diving suit."

/obj/item/weapon/storage/box/divingsuit/New()
	..()
	new /obj/item/clothing/suit/space/diving/medium(src)
	new /obj/item/clothing/head/helmet/space/diving/medium(src)
	new /obj/item/weapon/tank/emergency_oxygen/engi(src)

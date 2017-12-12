/obj/structure/closet/athletic_mixed
	name = "athletic wardrobe"
	desc = "It's a storage unit for athletic wear."
	icon_state = "mixed"
	icon_closed = "mixed"

/obj/structure/closet/athletic_mixed/New()
	..()
	new /obj/item/clothing/under/lower/shorts(src)
	new /obj/item/clothing/under/lower/shorts/black(src)
	new /obj/item/clothing/under/lower/shorts/red(src)
	new /obj/item/clothing/under/lower/shorts/blue(src)
	new /obj/item/clothing/under/lower/shorts/green(src)
	new /obj/item/clothing/mask/snorkel(src)
	new /obj/item/clothing/mask/snorkel(src)
	new /obj/item/clothing/shoes/swimmingfins(src)
	new /obj/item/clothing/shoes/swimmingfins(src)



/obj/structure/closet/boxinggloves
	name = "boxing gloves"
	desc = "It's a storage unit for gloves for use in the boxing ring."

/obj/structure/closet/boxinggloves/New()
	..()
	new /obj/item/clothing/gloves/boxing/blue(src)
	new /obj/item/clothing/gloves/boxing/green(src)
	new /obj/item/clothing/gloves/boxing/yellow(src)
	new /obj/item/clothing/gloves/boxing(src)


/obj/structure/closet/masks
	name = "mask closet"
	desc = "IT'S A STORAGE UNIT FOR FIGHTER MASKS OLE!"

/obj/structure/closet/masks/New()
	..()
	new /obj/item/clothing/mask/luchador(src)
	new /obj/item/clothing/mask/luchador/rudos(src)
	new /obj/item/clothing/mask/luchador/tecnicos(src)

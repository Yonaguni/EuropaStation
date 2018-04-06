/obj/structure/closet/cabinet
	name = "cabinet"
	desc = "Old will forever be in fashion."
	icon_state = "cabinet_closed"
	icon_closed = "cabinet_closed"
	icon_opened = "cabinet_open"

/obj/structure/closet/cabinet/update_icon()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/gimmick
	name = "administrative supply closet"
	desc = "It's a storage unit for things that have no right being here."
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1open"
	anchored = 0

/obj/structure/closet/gimmick/tacticool
	name = "tacticool gear closet"
	desc = "It's a storage unit for Tacticool gear."
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	icon_opened = "syndicate1open"

/obj/structure/closet/gimmick/tacticool/New()
	..()
	new /obj/item/clothing/glasses/eyepatch(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/gloves/thick/swat(src)
	new /obj/item/clothing/gloves/thick/swat(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/shoes/swat(src)
	new /obj/item/clothing/shoes/swat(src)
	new /obj/item/clothing/under/jumpsuit/black(src)
	new /obj/item/clothing/under/jumpsuit/black(src)
	new /obj/item/clothing/under/lower/camo(src)
	new /obj/item/clothing/under/upper/tacticool(src)

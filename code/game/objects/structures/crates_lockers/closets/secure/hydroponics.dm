/obj/structure/closet/secure_closet/hydroponics
	name = "botanist's locker"
	req_access = list(access_hydroponics)
	icon_state = "hydrosecure1"
	icon_closed = "hydrosecure"
	icon_locked = "hydrosecure1"
	icon_opened = "hydrosecureopen"
	icon_broken = "hydrosecurebroken"
	icon_off = "hydrosecureoff"


	New()
		..()
		new /obj/item/clothing/suit/overalls(src)
		new /obj/item/storage/plants(src)
		new /obj/item/clothing/under/jumpsuit/green(src)
		new /obj/item/analyzer/plant_analyzer(src)
		new /obj/item/clothing/head/bandana/green(src)
		new /obj/item/material/minihoe(src)
		new /obj/item/material/hatchet(src)
		new /obj/item/wirecutters/clippers(src)
		new /obj/item/reagent_containers/spray/plantbgone(src)
//		new /obj/item/bee_net(src) //No more bees, March 2014
		return

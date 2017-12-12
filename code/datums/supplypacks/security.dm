/decl/hierarchy/supply_pack/security
	name = "Security"

/decl/hierarchy/supply_pack/security/specialops
	name = "Special Ops supplies"
	contains = list(/obj/item/storage/box/emps,
					/obj/item/grenade/smokebomb = 3,
					/obj/item/pen/reagent/paralysis,
					/obj/item/grenade/chem_grenade/incendiary)
	cost = 20
	containername = "\improper Special Ops crate"
	hidden = 1

/decl/hierarchy/supply_pack/security/forensics
	name = "Auxiliary forensic tools"
	contains = list(/obj/item/forensics/sample_kit,
					/obj/item/forensics/sample_kit/powder,
					/obj/item/storage/box/swabs = 3,
					/obj/item/reagent_containers/spray/luminol)
	cost = 30
	containername = "\improper Auxiliary forensic tools"

/decl/hierarchy/supply_pack/security/securitybarriers
	name = "Security barrier crate"
	contains = list(/obj/machinery/deployable/barrier = 4)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "\improper Security barrier crate"

/decl/hierarchy/supply_pack/security/holster
	name = "Holster crate"
	num_contained = 4
	contains = list(/obj/item/clothing/accessory/holster,
					/obj/item/clothing/accessory/holster/armpit,
					/obj/item/clothing/accessory/holster/waist,
					/obj/item/clothing/accessory/holster/hip)
	cost = 15
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Holster crate"
	access = access_security
	supply_method = /decl/supply_method/randomized

/decl/hierarchy/supply_pack/security/securityextragear
	name = "Security surplus equipment"
	contains = list(/obj/item/storage/belt/security = 3,
					/obj/item/clothing/glasses/sunglasses/sechud = 3)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Security surplus equipment"
	access = access_security

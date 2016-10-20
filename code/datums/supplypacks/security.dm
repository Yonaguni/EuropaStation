/decl/hierarchy/supply_pack/security
	name = "Security"

/decl/hierarchy/supply_pack/security/specialops
	name = "Special Ops supplies"
	contains = list(/obj/item/weapon/storage/box/emps,
					/obj/item/weapon/grenade/smokebomb = 3,
					/obj/item/weapon/pen/reagent/paralysis,
					/obj/item/weapon/grenade/chem_grenade/incendiary)
	cost = 20
	containername = "\improper Special Ops crate"
	hidden = 1

/decl/hierarchy/supply_pack/security/forensics
	name = "Auxiliary forensic tools"
	contains = list(/obj/item/weapon/forensics/sample_kit,
					/obj/item/weapon/forensics/sample_kit/powder,
					/obj/item/weapon/storage/box/swabs = 3,
					/obj/item/weapon/reagent_containers/spray/luminol)
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
	contains = list(/obj/item/weapon/storage/belt/security = 3,
					/obj/item/clothing/glasses/sunglasses/sechud = 3)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Security surplus equipment"
	access = access_security

/decl/hierarchy/supply_pack/security/detectiveclothes
	name = "Investigation apparel"
	contains = list(/obj/item/clothing/under/det/black = 2,
					/obj/item/clothing/under/det/grey = 2,
					/obj/item/clothing/head/det/grey = 2,
					/obj/item/clothing/under/det = 2,
					/obj/item/clothing/head/det = 2,
					/obj/item/clothing/suit/storage/det_trench,
					/obj/item/clothing/suit/storage/det_trench/grey,
					/obj/item/clothing/suit/storage/forensics/red,
					/obj/item/clothing/suit/storage/forensics/blue,
					/obj/item/clothing/gloves/forensic,
					/obj/item/clothing/gloves/thick = 2)
	cost = 20
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Investigation clothing"
	access = access_forensics_lockers

/decl/hierarchy/supply_pack/security/corporatesecurityclothing
	name = "Corporate security uniform crate"
	contains = list(/obj/item/weapon/storage/backpack/satchel_sec = 2,
					/obj/item/weapon/storage/backpack/security = 2,
					/obj/item/clothing/under/rank/security/corp = 4,
					/obj/item/clothing/head/soft/sec/corp = 4,
					/obj/item/clothing/under/rank/warden/corp,
					/obj/item/clothing/under/rank/head_of_security/corp,
					/obj/item/clothing/head/beret/sec = 4,
					/obj/item/clothing/head/beret/sec/corporate/warden,
					/obj/item/clothing/head/beret/sec/corporate/hos,
					/obj/item/clothing/gloves/thick = 4,
					/obj/item/weapon/storage/box/holobadge)
	cost = 20
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Corporate security uniform crate"
	access = access_security

/decl/hierarchy/supply_pack/security/securitybiosuit
	name = "Security biohazard gear"
	contains = list(/obj/item/clothing/head/bio_hood/security,
					/obj/item/clothing/under/rank/security,
					/obj/item/clothing/suit/bio_suit/security,
					/obj/item/clothing/shoes/white,
					/obj/item/clothing/mask/gas,
					/obj/item/weapon/tank/oxygen,
					/obj/item/clothing/gloves/latex)
	cost = 35
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Security biohazard gear"
	access = access_security

/decl/hierarchy/supply_pack/security/tactical
	name = "Tactical suits"
	contains = list(/obj/item/clothing/under/tactical,
					/obj/item/clothing/suit/storage/vest/tactical,
					/obj/item/clothing/head/helmet/tactical,
					/obj/item/clothing/mask/balaclava/tactical,
					/obj/item/clothing/glasses/sunglasses/sechud/tactical,
					/obj/item/weapon/storage/belt/security/tactical,
					/obj/item/clothing/shoes/tactical,
					/obj/item/clothing/gloves/tactical)
	cost = 45
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Tactical Suit Locker"
	access = access_armory

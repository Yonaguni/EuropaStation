/decl/hierarchy/supply_pack/medical
	name = "Medical"
	containertype = /obj/structure/closet/crate/medical

/decl/hierarchy/supply_pack/medical/medical
	name = "Medical crate"
	contains = list(/obj/item/weapon/storage/firstaid/regular,
					/obj/item/weapon/storage/firstaid/fire,
					/obj/item/weapon/storage/firstaid/toxin,
					/obj/item/weapon/storage/firstaid/o2,
					/obj/item/weapon/storage/firstaid/adv,
					/obj/item/weapon/reagent_containers/glass/bottle/antitoxin,
					/obj/item/weapon/reagent_containers/glass/bottle/adrenaline,
					/obj/item/weapon/reagent_containers/glass/bottle/stoxin,
					/obj/item/weapon/storage/box/syringes,
					/obj/item/weapon/storage/box/autoinjectors)
	cost = 10
	containername = "\improper Medical crate"

/decl/hierarchy/supply_pack/medical/bloodpack
	name = "BloodPack crate"
	contains = list(/obj/item/weapon/storage/box/bloodpacks = 3)
	cost = 10
	containername = "\improper BloodPack crate"

/decl/hierarchy/supply_pack/medical/bodybag
	name = "Body bag crate"
	contains = list(/obj/item/weapon/storage/box/bodybags = 3)
	cost = 10
	containername = "\improper Body bag crate"

/decl/hierarchy/supply_pack/medical/medicalextragear
	name = "Medical surplus equipment"
	contains = list(/obj/item/weapon/storage/belt/medical = 3,
					/obj/item/clothing/glasses/hud/health = 3)
	cost = 15
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Medical surplus equipment"
	access = access_medical

/decl/hierarchy/supply_pack/medical/medicalscrubs
	name = "Medical scrubs"
	contains = list(/obj/item/clothing/shoes/white = 3,
					/obj/item/clothing/under/rank/medical/blue = 3,
					/obj/item/clothing/under/rank/medical/green = 3,
					/obj/item/clothing/under/rank/medical/purple = 3,
					/obj/item/clothing/under/rank/medical/black = 3,
					/obj/item/clothing/head/surgery = 3,
					/obj/item/clothing/head/surgery/purple = 3,
					/obj/item/clothing/head/surgery/blue = 3,
					/obj/item/clothing/head/surgery/green = 3,
					/obj/item/weapon/storage/box/masks,
					/obj/item/weapon/storage/box/gloves)
	cost = 15
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Medical scrubs crate"
	access = access_medical_equip

/decl/hierarchy/supply_pack/medical/autopsy
	name = "Autopsy equipment"
	contains = list(/obj/item/weapon/folder/white,
					/obj/item/device/camera,
					/obj/item/device/camera_film = 2,
					/obj/item/weapon/autopsy_scanner,
					/obj/item/weapon/scalpel,
					/obj/item/weapon/storage/box/masks,
					/obj/item/weapon/storage/box/gloves,
					/obj/item/weapon/pen)
	cost = 20
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Autopsy equipment crate"
	access = access_morgue

/decl/hierarchy/supply_pack/medical/medicalbiosuits
	name = "Medical biohazard gear"
	contains = list(/obj/item/clothing/head/bio_hood = 3,
					/obj/item/clothing/suit/bio_suit = 3,
					/obj/item/clothing/head/bio_hood/virology = 2,
					/obj/item/clothing/suit/bio_suit/cmo = 2,
					/obj/item/clothing/mask/gas = 5,
					/obj/item/weapon/tank/oxygen = 5,
					/obj/item/weapon/storage/box/masks,
					/obj/item/weapon/storage/box/gloves)
	cost = 50
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Medical biohazard equipment"
	access = access_medical_equip

/decl/hierarchy/supply_pack/medical/portablefreezers
	name = "Portable freezers crate"
	contains = list(/obj/item/weapon/storage/box/freezer = 7)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Portable freezers"
	access = access_medical_equip

/decl/hierarchy/supply_pack/medical/surgery
	name = "Surgery crate"
	contains = list(/obj/item/weapon/cautery,
					/obj/item/weapon/surgicaldrill,
					/obj/item/clothing/mask/breath/medical,
					/obj/item/weapon/tank/anesthetic,
					/obj/item/weapon/FixOVein,
					/obj/item/weapon/hemostat,
					/obj/item/weapon/scalpel,
					/obj/item/weapon/bonegel,
					/obj/item/weapon/retractor,
					/obj/item/weapon/bonesetter,
					/obj/item/weapon/circular_saw)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "\improper Surgery crate"
	access = access_medical

/decl/hierarchy/supply_pack/medical/sterile
	name = "Sterile equipment crate"
	contains = list(/obj/item/clothing/under/rank/medical/green = 2,
					/obj/item/clothing/head/surgery/green = 2,
					/obj/item/weapon/storage/box/masks,
					/obj/item/weapon/storage/box/gloves,
					/obj/item/weapon/storage/belt/medical = 3)
	cost = 15
	containertype = /obj/structure/closet/crate
	containername = "\improper Sterile equipment crate"

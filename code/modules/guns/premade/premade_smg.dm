/obj/item/gun/composite/premade/smg
	name = "submachine gun"
	icon_state = "ballistic_smg"
	variant_chamber = /obj/item/gun_component/chamber/ballistic/auto
	variant_stock =   /obj/item/gun_component/stock/smg
	variant_grip =    /obj/item/gun_component/grip/smg
	variant_body =    /obj/item/gun_component/body/smg
	variant_barrel =  /obj/item/gun_component/barrel/smg

/obj/item/gun/composite/premade/smg/New()
	new /obj/item/gun_component/accessory/chamber/sear/burst_ballistic(src)
	..()

/obj/item/gun/composite/premade/smg/a9
	name = "9mm submachine gun"
	set_caliber = /decl/weapon_caliber/pistol_medium

/obj/item/gun/composite/premade/smg/a10
	name = "10mm submachine gun"
	set_caliber = /decl/weapon_caliber/pistol_large

/obj/item/gun/composite/premade/smg/a10/preloaded
	desc = "A vicious 10mm submachine gun. Preloaded with one magazine."
	ammo_type = /obj/item/ammo_magazine/submachine/large

/obj/item/gun/composite/premade/smg/a45
	name = "a45 submachine gun"
	variant_stock =  null
	set_caliber = /decl/weapon_caliber/pistol_45

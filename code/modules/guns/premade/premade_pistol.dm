/obj/item/gun/composite/premade/revolver
	name = "revolver"
	icon_state = "revolver"
	variant_chamber = /obj/item/gun_component/chamber/ballistic/breech/revolver
	variant_body =    /obj/item/gun_component/body/pistol/revolver
	variant_barrel =  /obj/item/gun_component/barrel/pistol/revolver
	variant_grip =    /obj/item/gun_component/grip/pistol/revolver
	variant_stock =   null

/obj/item/gun/composite/premade/revolver/preloaded
	ammo_type = /obj/item/ammo_casing/a357

/obj/item/gun/composite/premade/revolver/magnum
	name = "magnum revolver"
	variant_barrel = /obj/item/gun_component/barrel/pistol/revolver/magnum
	variant_grip =    /obj/item/gun_component/grip/pistol/revolver/large
	set_caliber = /decl/weapon_caliber/pistol_magnum

/obj/item/gun/composite/premade/revolver/magnum/preloaded
	ammo_type = /obj/item/ammo_casing/magnum

/obj/item/gun/composite/premade/revolver/a45
	name = ".45 revolver"
	variant_barrel = /obj/item/gun_component/barrel/pistol/revolver/a45
	set_caliber = /decl/weapon_caliber/pistol_45

/obj/item/gun/composite/premade/revolver/a45/preloaded
	ammo_type = /obj/item/ammo_casing/a45

/obj/item/gun/composite/premade/revolver/a38
	name = ".38 revolver"
	variant_barrel = /obj/item/gun_component/barrel/pistol/revolver/a38
	variant_grip =    /obj/item/gun_component/grip/pistol/revolver/small
	set_caliber = /decl/weapon_caliber/pistol_38

/obj/item/gun/composite/premade/revolver/a38/preloaded
	ammo_type = /obj/item/ammo_casing/a38

/obj/item/gun/composite/premade/revolver/hunting
	name = "hunting revolver"
	variant_grip =    /obj/item/gun_component/grip/pistol/revolver/large
	variant_barrel = /obj/item/gun_component/barrel/pistol/revolver/long
	set_caliber = /decl/weapon_caliber/pistol_magnum

/obj/item/gun/composite/premade/revolver/hunting/preloaded
	ammo_type = /obj/item/ammo_casing/a357

/obj/item/gun/composite/premade/revolver/toy
	name = "toy revolver"
	set_model = /decl/weapon_model/revolver/toy
	variant_barrel = /obj/item/gun_component/barrel/pistol/toy
	ammo_type = /obj/item/ammo_casing/capgun
	set_caliber = /decl/weapon_caliber/capgun

/obj/item/gun/composite/premade/pistol
	name = "pistol"
	icon_state = "ballistic_pistol"
	variant_chamber = /obj/item/gun_component/chamber/ballistic/pistol
	variant_grip =    /obj/item/gun_component/grip/pistol/small
	variant_body =    /obj/item/gun_component/body/pistol/small
	variant_barrel =  /obj/item/gun_component/barrel/pistol
	variant_stock = null

/obj/item/gun/composite/premade/pistol/preloaded
	ammo_type = /obj/item/ammo_magazine/pistol

/obj/item/gun/composite/premade/pistol/a9
	name = "9mm pistol"
	set_caliber = /decl/weapon_caliber/pistol_medium

/obj/item/gun/composite/premade/pistol/a9/preloaded
	ammo_type = /obj/item/ammo_magazine/pistol/medium

/obj/item/gun/composite/premade/pistol/a10
	name = "10mm pistol"
	variant_grip = /obj/item/gun_component/grip/pistol
	set_caliber = /decl/weapon_caliber/pistol_large

/obj/item/gun/composite/premade/pistol/a10/preloaded
	ammo_type = /obj/item/ammo_magazine/pistol/large

/obj/item/gun/composite/premade/pistol/a45
	name = "a45 pistol"
	variant_grip =    /obj/item/gun_component/grip/pistol/plated
	variant_barrel = /obj/item/gun_component/barrel/pistol/a45
	variant_chamber = /obj/item/gun_component/chamber/ballistic/pistol/a45

/obj/item/gun/composite/premade/pistol/a45/preloaded
	ammo_type = /obj/item/ammo_magazine/pistol/a45

/obj/item/gun/composite/premade/pistol/a38
	name = "a38 pistol"
	variant_grip =    /obj/item/gun_component/grip/pistol/plated/drop
	set_caliber = /decl/weapon_caliber/pistol_38

/obj/item/gun/composite/premade/pistol/a38/preloaded
	ammo_type = /obj/item/ammo_magazine/pistol/a38

/obj/item/gun/composite/premade/pistol/a9/silenced
	desc = "A silenced 9mm holdout pistol. Stylish. Preloaded with one magazine."
	variant_body = /obj/item/gun_component/body/pistol/small
	ammo_type = /obj/item/ammo_magazine/pistol/medium

/obj/item/gun/composite/premade/pistol/a9/silenced/New()
	new /obj/item/gun_component/accessory/barrel/silencer(src)
	..()
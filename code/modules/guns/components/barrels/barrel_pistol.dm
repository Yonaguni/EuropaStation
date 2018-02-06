/obj/item/gun_component/barrel/pistol
	icon_state="pistol_small"
	w_class = 2
	weapon_type = GUN_PISTOL
	design_caliber = /decl/weapon_caliber/pistol_small
	recoil_mod = 0
	color = COLOR_GUNMETAL

/obj/item/gun_component/barrel/pistol/a10
	design_caliber = /decl/weapon_caliber/pistol_large
	icon_state="pistol"
	weight_mod = 1
	recoil_mod = 1

/obj/item/gun_component/barrel/pistol/a45
	design_caliber = /decl/weapon_caliber/pistol_45
	icon_state="pistol2"
	weight_mod = 1
	recoil_mod = 1

/obj/item/gun_component/barrel/pistol/magnum
	design_caliber = /decl/weapon_caliber/pistol_magnum
	icon_state="pistol_large"
	weight_mod = 2
	recoil_mod = 3

/obj/item/gun_component/barrel/pistol/revolver
	icon_state="revolver"
	design_caliber = /decl/weapon_caliber/pistol_357
	shortened_icon="revolver_small"
	weight_mod = 1
	recoil_mod = 2

/obj/item/gun_component/barrel/pistol/revolver/a45
	design_caliber = /decl/weapon_caliber/pistol_45
	recoil_mod = 1

/obj/item/gun_component/barrel/pistol/revolver/long
	icon_state = "revolver_long"
	w_class = 3
	shortened_icon="revolver"
	recoil_mod = 1
	accuracy_mod = 2
	override_name = "hunting"

/obj/item/gun_component/barrel/pistol/revolver/magnum
	icon_state = "revolver_big"
	design_caliber = /decl/weapon_caliber/pistol_magnum
	w_class = 3
	recoil_mod = 3
	shortened_icon = null

/obj/item/gun_component/barrel/pistol/revolver/a38
	icon_state="revolver_small"
	design_caliber = /decl/weapon_caliber/pistol_38
	weight_mod = 0
	recoil_mod = 0
	accuracy_mod = -1

/obj/item/gun_component/barrel/pistol/toy
	icon_state="revolver"
	override_name = "toy"
	design_caliber = /decl/weapon_caliber/capgun

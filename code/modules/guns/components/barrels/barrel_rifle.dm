/obj/item/gun_component/barrel/rifle
	icon_state="rifle"
	weapon_type = GUN_RIFLE
	design_caliber = /decl/weapon_caliber/rifle_small
	accepts_accessories = 1
	shortened_icon="rifle_short"
	weight_mod = 2
	accuracy_mod = 1
	recoil_mod = 2

/obj/item/gun_component/barrel/rifle/large
	design_caliber = /decl/weapon_caliber/rifle_large
	recoil_mod = 3
	accuracy_mod = 2

/obj/item/gun_component/barrel/rifle/short
	icon_state="rifle_short"
	accepts_accessories = 0
	w_class = 2
	weight_mod = 1
	recoil_mod = 3
	accuracy_mod = 0
	override_name = "sawn-off"

/obj/item/gun_component/barrel/rifle/short/large
	design_caliber = /decl/weapon_caliber/rifle_large
	recoil_mod = 4

/obj/item/gun_component/barrel/rifle/am
	icon_state="sniper"
	w_class = 3
	design_caliber = /decl/weapon_caliber/rifle_sniper
	weight_mod = 2
	accuracy_mod = 3
	recoil_mod = 5
	two_handed = 1

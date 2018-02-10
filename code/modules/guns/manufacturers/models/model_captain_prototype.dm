/decl/weapon_model/picomotion_prototype
	force_gun_name = "prototype laser pistol"
	model_name = "PicoMotion Starshot v0.7b"
	model_desc = "A sleek, polished hand laser with some excitingly chunky modules. Looks expensive."
	producer_path = /decl/weapon_manufacturer/picomotion
	use_icon = 'icons/obj/gun_components/captain_prototype_laser.dmi'
	force_item_state = "caplaser"

/obj/item/gun/composite/premade/laser_pistol/prototype
	name = "prototype laser pistol"
	icon_state = "caplaser"
	set_model = /decl/weapon_model/picomotion_prototype
	variant_chamber = /obj/item/gun_component/chamber/laser/pistol/prototype

/obj/item/gun_component/chamber/laser/pistol/prototype
	name = "prototype charging mechanism"
	self_recharge_time = 4

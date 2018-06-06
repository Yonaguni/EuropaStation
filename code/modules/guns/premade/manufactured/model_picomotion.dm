/decl/weapon_model/picomotion
	producer_path = /decl/weapon_manufacturer/picomotion

/decl/weapon_model/picomotion/prototype_laser
	force_gun_name = "prototype laser pistol"
	model_name = "PicoMotion Starshot v0.7b"
	model_desc = "A sleek, polished hand laser with some excitingly chunky modules. Looks expensive."
	use_icon = 'icons/obj/gun_components/captain_prototype_laser.dmi'
	force_item_state = "caplaser"

/decl/weapon_model/picomotion/taser
	model_name = "PicoMotion Detainer v1.2"
	model_desc = "A cheaply made electroshock pistol in a black plastic shell. Very flimsy."

/obj/item/gun/composite/premade/laser_pistol/self_charging/picomotion
	set_model = /decl/weapon_model/picomotion/prototype_laser

/obj/item/gun/composite/premade/taser_pistol/picomotion
	set_model = /decl/weapon_model/picomotion/taser

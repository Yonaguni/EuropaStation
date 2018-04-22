/obj/item/gun/composite/premade/revolver/foundation
	ammo_type = /obj/item/ammo_casing/nullglass
	set_model = /decl/weapon_model/foundation_revolver
	icon_state = "foundation"

/decl/weapon_model/foundation_revolver
	model_name = "CF 'Troubleshooter'"
	model_desc = "A compact plastic-composite weapon designed for concealed carry by Foundation field agents. Smells faintly of copper."
	use_icon = 'icons/obj/gun_components/foundation_revolver.dmi'
	producer_path = /decl/weapon_manufacturer/cuchulain_foundation

/decl/weapon_manufacturer/cuchulain_foundation
	manufacturer_name = "the letters C-F imposed on a white starburst"
	manufacturer_description = "The Cuchulain Foundation is a private-public body with their fingers in a lot of psionic pies."
	manufacturer_short = "CF"
	casing_desc = "The casing is a smooth white polymer."
	accuracy   = 1.2
	capacity   = 0.8
	damage_mod = 0.9
	recoil     = 0.8
	fire_rate  = 1.2
	weight     = 0.8

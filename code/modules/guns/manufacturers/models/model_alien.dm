/decl/weapon_model/kharmaani
	force_gun_name = "particle rifle"
	model_desc = "A long, bulbous energy weapon of alien manufacture."
	producer_path = /decl/weapon_manufacturer/kharmaani
	use_icon = 'icons/obj/gun_components/kharmaani_particle_rifle.dmi'
	ammo_indicator_icon = 'icons/obj/gun_components/kharmaani_particle_rifle.dmi'
	force_item_state = "particle_rifle"
	ammo_use_state = "particle_rifle_loaded"

/decl/weapon_model/kharmaani/New()
	var/datum/language/kharmaani/L = new()
	model_name = L.scramble(force_gun_name)
	..()

/obj/item/gun_component/body/rifle/laser/kharmaani
	item_state = "particle_rifle"
	desc = "A weirdly organic, curving projectile weapon frame."
	wielded_state = "particle_rifle-wielded"

/obj/item/gun_component/barrel/laser/rifle/kharmaani
	desc = "A long, heavy projection apparatus of some kind."
	design_caliber = /decl/weapon_caliber/laser/particle
	accepts_accessories = 0

/obj/item/gun_component/chamber/laser/rifle/kharmaani
	name = "alien focusing lens"
	desc = "A layered, nearly opaque focusing lens."
	initial_charge = 25000
	fire_delay = 5
	ammo_indicator_state = "particle_rifle_loaded"

/obj/item/gun/composite/premade/laser_rifle/kharmaani
	name = "particle rifle"
	icon_state = "particle_rifle"
	set_model = /decl/weapon_model/kharmaani
	variant_barrel = /obj/item/gun_component/barrel/laser/rifle/kharmaani
	variant_body =    /obj/item/gun_component/body/rifle/laser/kharmaani
	variant_chamber = /obj/item/gun_component/chamber/laser/rifle/kharmaani
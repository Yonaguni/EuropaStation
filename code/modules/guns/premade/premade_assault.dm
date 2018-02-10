/obj/item/gun/composite/premade/assault_rifle
	name = "assault rifle"
	icon_state = "ballistic_assault"
	variant_chamber = /obj/item/gun_component/chamber/ballistic/auto/assault
	variant_stock =   /obj/item/gun_component/stock/assault
	variant_grip =    /obj/item/gun_component/grip/assault
	variant_body =    /obj/item/gun_component/body/assault
	variant_barrel =  /obj/item/gun_component/barrel/assault

/obj/item/gun/composite/premade/assault_rifle/New()
	new /obj/item/gun_component/accessory/chamber/sear/burst_ballistic(src)
	..()

/obj/item/gun/composite/premade/assault_rifle/a762
	name = "7.62 assault rifle"
	variant_barrel =  /obj/item/gun_component/barrel/assault/a762
	set_caliber = /decl/weapon_caliber/rifle_large

/obj/item/gun/composite/premade/assault_rifle/a762/preloaded
	desc = "A 7.62 caliber assault rifle: for when you absolutely need the other guy to be full of bullet holes. Preloaded with one magazine."
	ammo_type = /obj/item/ammo_magazine/assault/large
/obj/item/weapon/gun/composite/premade
	icon = 'icons/obj/gun.dmi'
	var/set_model
	var/variant_chamber = /obj/item/gun_component/chamber
	var/variant_body =    /obj/item/gun_component/body
	var/variant_barrel =  /obj/item/gun_component/barrel
	var/variant_stock =   /obj/item/gun_component/stock
	var/variant_grip =    /obj/item/gun_component/grip

/obj/item/weapon/gun/composite/premade/New()
	icon_state = ""
	barrel =  new variant_barrel  (src, use_model = set_model)
	body =    new variant_body    (src, use_model = set_model)
	stock =   new variant_stock   (src, use_model = set_model)
	chamber = new variant_chamber (src, use_model = set_model)
	grip =    new variant_grip    (src, use_model = set_model)
	accessories.Cut()
	for(var/obj/item/gun_component/accessory/acc in contents)
		accessories += acc
	update_from_components()

	..()

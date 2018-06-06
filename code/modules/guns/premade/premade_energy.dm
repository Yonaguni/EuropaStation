/obj/item/gun/composite/premade/laser_cannon
	name = "laser cannon"
	icon_state = "laser_cannon"
	variant_chamber = /obj/item/gun_component/chamber/laser/cannon
	variant_stock =   /obj/item/gun_component/stock/cannon/laser
	variant_grip =    /obj/item/gun_component/grip/cannon/laser
	variant_body =    /obj/item/gun_component/body/cannon/laser
	variant_barrel =  /obj/item/gun_component/barrel/laser/cannon

/obj/item/gun/composite/premade/laser_smg
	name = "laser submachine gun"
	icon_state = "laser_smg"
	variant_chamber = /obj/item/gun_component/chamber/laser/smg
	variant_stock =   /obj/item/gun_component/stock/smg/laser
	variant_grip =    /obj/item/gun_component/grip/smg/laser
	variant_body =    /obj/item/gun_component/body/smg/laser
	variant_barrel =  /obj/item/gun_component/barrel/laser/xray

/obj/item/gun/composite/premade/laser_smg/New()
	new /obj/item/gun_component/accessory/chamber/sear/burst_energy(src)
	..()

/obj/item/gun/composite/premade/laser_pistol
	name = "laser pistol"
	icon_state = "laser_pistol"
	variant_chamber = /obj/item/gun_component/chamber/laser/pistol
	variant_stock =   /obj/item/gun_component/stock/pistol/laser
	variant_grip =    /obj/item/gun_component/grip/pistol/laser
	variant_body =    /obj/item/gun_component/body/pistol/laser
	variant_barrel =  /obj/item/gun_component/barrel/laser/pistol

/obj/item/gun/composite/premade/laser_pistol/New()
	new /obj/item/gun_component/accessory/barrel/lens/stun_lethal(src)
	..()

/obj/item/gun/composite/premade/taser_pistol
	name = "taser pistol"
	icon_state = "laser_pistol"
	variant_chamber = /obj/item/gun_component/chamber/laser/pistol/taser
	variant_stock =   /obj/item/gun_component/stock/pistol/laser
	variant_grip =    /obj/item/gun_component/grip/pistol/laser
	variant_body =    /obj/item/gun_component/body/pistol/laser
	variant_barrel =  /obj/item/gun_component/barrel/laser
	set_caliber = /decl/weapon_caliber/laser/shock

/obj/item/gun/composite/premade/laser_rifle
	name = "laser rifle"
	icon_state = "laser_rifle"
	variant_chamber = /obj/item/gun_component/chamber/laser/rifle
	variant_stock =   /obj/item/gun_component/stock/rifle/laser
	variant_grip =    /obj/item/gun_component/grip/rifle/laser
	variant_body =    /obj/item/gun_component/body/rifle/laser
	variant_barrel =  /obj/item/gun_component/barrel/laser/rifle

/obj/item/gun/composite/premade/laser_rifle/practice
	name = "practice laser rifle"
	set_caliber = /decl/weapon_caliber/laser/practice

/obj/item/gun/composite/premade/laser_rifle/scoped/New()
	new /obj/item/gun_component/accessory/body/scope(src)
	..()

/obj/item/gun/composite/premade/laser_shotgun
	name = "laser shotgun"
	icon_state = "laser_shotgun"
	variant_chamber = /obj/item/gun_component/chamber/laser/burst
	variant_stock =   /obj/item/gun_component/stock/shotgun/laser
	variant_grip =    /obj/item/gun_component/grip/shotgun/laser
	variant_body =    /obj/item/gun_component/body/shotgun/laser
	variant_barrel =  /obj/item/gun_component/barrel/laser/shotgun/burst

/obj/item/gun/composite/premade/laser_assault
	name = "laser assault rifle"
	icon_state = "laser_assault"
	variant_chamber = /obj/item/gun_component/chamber/laser/assault
	variant_stock =   /obj/item/gun_component/stock/assault/laser
	variant_grip =    /obj/item/gun_component/grip/assault/laser
	variant_body =    /obj/item/gun_component/body/assault/laser
	variant_barrel =  /obj/item/gun_component/barrel/laser/assault

/obj/item/gun/composite/premade/laser_assault/New()
	new /obj/item/gun_component/accessory/chamber/sear/burst_energy(src)
	..()

/obj/item/gun/composite/premade/laser_assault/practice
	name = "practice laser assault rifle"
	set_caliber = /decl/weapon_caliber/laser/practice

/obj/item/gun/composite/premade/laser_pistol/self_charging
	name = "self-charging laser pistol"
	icon_state = "caplaser"
	variant_chamber = /obj/item/gun_component/chamber/laser/pistol/self_charging

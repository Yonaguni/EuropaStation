/obj/item/weapon/mecha_equipment/mounted_system/advweapon
	restricted_hardpoints = list(HARDPOINT_LEFT_SHOULDER, HARDPOINT_RIGHT_SHOULDER)
	restricted_software = list(MECH_SOFTWARE_ADVWEAPONS)

/obj/item/weapon/mecha_equipment/mounted_system/advweapon/missile_pod
	icon_state = "mecha_missile_pod"
	holding_type = /obj/item/weapon/gun/launcher/rocket/mech
	restricted_hardpoints = list(HARDPOINT_LEFT_SHOULDER, HARDPOINT_RIGHT_SHOULDER, HARDPOINT_BACK)

/obj/item/weapon/gun/launcher/rocket/get_hardpoint_status_value()
	return (rockets.len/max_rockets)

/obj/item/weapon/gun/launcher/rocket/get_hardpoint_maptext()
	return "[rockets.len]/[max_rockets]"

/obj/item/weapon/gun/projectile/railgun/get_hardpoint_status_value()
	if(rail_deformed)
		return -1
	return ..()

/obj/item/weapon/mecha_equipment/mounted_system/advweapon/railgun
	holding_type = /obj/item/weapon/gun/projectile/railgun/rifle/heavy/auto/reason
	restricted_hardpoints = list(HARDPOINT_LEFT_HAND, HARDPOINT_RIGHT_HAND, HARDPOINT_LEFT_SHOULDER, HARDPOINT_RIGHT_SHOULDER)

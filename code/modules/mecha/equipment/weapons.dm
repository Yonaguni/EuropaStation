/obj/item/weapon/gun/projectile/get_hardpoint_maptext()
	return "[getAmmo()]/[max_shells]"

/obj/item/weapon/gun/projectile/get_hardpoint_status_value()
	return (getAmmo()/max_shells)

/obj/item/weapon/gun/energy/get_hardpoint_status_value()
	var/obj/item/weapon/cell/use_cell
	if(use_external_power)
		use_cell = get_external_power_supply()
	else
		use_cell = power_supply
	if(!use_cell)
		return -1
	return (use_cell.charge/use_cell.maxcharge)

/obj/item/weapon/gun/energy/get_hardpoint_maptext()
	var/obj/item/weapon/cell/use_cell
	if(use_external_power)
		use_cell = get_external_power_supply()
	else
		use_cell = power_supply
	if(!use_cell)
		return null
	return "[round(use_cell.charge/charge_cost)]/[round(use_cell.maxcharge/charge_cost)]"

/obj/item/weapon/mecha_equipment/mounted_system/taser
	icon_state = "mecha_taser"
	holding_type = /obj/item/weapon/gun/energy/taser/mounted
	restricted_hardpoints = list(HARDPOINT_LEFT_HAND, HARDPOINT_RIGHT_HAND, HARDPOINT_LEFT_SHOULDER, HARDPOINT_RIGHT_SHOULDER)
	restricted_software = list(MECH_SOFTWARE_WEAPONS)
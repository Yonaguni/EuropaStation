/obj/item/gun_component/chamber/laser
	projectile_type = GUN_TYPE_LASER
	can_jam = FALSE
	accepts_accessories = TRUE

	var/initial_charge = 5000
	var/can_remove_cell
	var/self_recharge_time // Default is 4; null or 0 means the gun does not recharge itself without a charger.
	var/self_recharge_tick = 0
	var/cell_type
	var/obj/item/cell/power_supply

/obj/item/gun_component/chamber/laser/get_cell()
	return power_supply

/obj/item/gun_component/chamber/laser/proc/get_fire_cost()
	return max(holder.barrel.design_caliber.fire_cost, design_caliber.fire_cost)

/obj/item/gun_component/chamber/laser/get_max_shots(var/val)
	if(!power_supply)
		return 0
	max_shots = power_supply.maxcharge / get_fire_cost()
	return max_shots

/obj/item/gun_component/chamber/laser/update_ammo_overlay()
	if(!power_supply)
		overlays.Cut()
	else
		. = ..()

/obj/item/gun_component/chamber/laser/Destroy()
	if(power_supply)
		qdel(power_supply)
		power_supply = null
	return ..()

/obj/item/gun_component/chamber/laser/empty()
	if(power_supply && can_remove_cell)
		power_supply.forceMove(get_turf(src))
		power_supply = null

/obj/item/gun_component/chamber/laser/unload_ammo(var/mob/user)
	if(!can_remove_cell)
		to_chat(user, "<span class='warning'>\The cell cannot be removed from \the [holder].</span>")
		return 0

	if(!power_supply)
		to_chat(user, "<span class='warning'>\The [holder] does not have a cell.</span>")
		return 0
	to_chat(user, "<span class='notice'>You remove \the [power_supply] from \the [holder].</span>")
	power_supply.forceMove(get_turf(src))
	user.put_in_hands(power_supply)
	power_supply = null
	update_ammo_overlay()
	return 1

/obj/item/gun_component/chamber/laser/load_ammo(var/obj/item/thing, var/mob/user)
	if(!istype(thing, /obj/item/cell))
		return
	if(power_supply)
		to_chat(user, "<span class='warning'>\The [holder] already has a cell.</span>")
		return
	user.visible_message("<span class='danger'>\The [user] jacks \the [thing] into \the [holder].</span>")
	power_supply = thing
	user.unEquip(thing)
	thing.forceMove(src)
	update_ammo_overlay()
	return 1

/obj/item/gun_component/chamber/laser/New(var/newloc, var/weapontype, var/componenttype, var/use_model, var/supplied_caliber)

	if(cell_type)
		power_supply = new cell_type(src)
	else
		power_supply = new /obj/item/cell/device/variable(src, initial_charge)

	..(newloc, weapontype, componenttype, use_model, supplied_caliber)

	if(holder && holder.model && !isnull(holder.model.produced_by.capacity))
		power_supply.maxcharge = round(power_supply.maxcharge * holder.model.produced_by.capacity)
		power_supply.charge = power_supply.maxcharge

	if(self_recharge_time)
		START_PROCESSING(SSprocessing, src)

	update_icon()

/obj/item/gun_component/chamber/laser/Destroy()
	if(!self_recharge_time)
		STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/gun_component/chamber/laser/process()

	// Are we ready to charge.
	self_recharge_tick++
	if(self_recharge_tick < self_recharge_time)
		return 0
	self_recharge_tick = 0

	if(!power_supply || power_supply.charge >= power_supply.maxcharge)
		return 0 // check if we actually need to recharge

	power_supply.give(round(initial_charge/10)) //... to recharge the shot
	update_ammo_overlay()
	return 1

/obj/item/gun_component/chamber/laser/get_shots_remaining()
	return round(power_supply ? (power_supply.charge / get_fire_cost()) : 0)

/obj/item/gun_component/chamber/laser/consume_next_projectile()

	var/fire_cost = get_fire_cost()
	if(holder.installed_in_turret)
		var/obj/machinery/porta_turret/turret = loc.loc
		if(turret.stat & (BROKEN|NOPOWER))
			return null
		turret.use_power(fire_cost)
	else
		if(!power_supply || !power_supply.checked_use(fire_cost))
			return null

	var/projtype
	if(holder && holder.barrel)
		projtype = holder.barrel.get_projectile_type()
	if(projtype)
		return new projtype(src)
	return null

/obj/item/gun_component/chamber/laser/get_external_power_supply()
	if(istype(src.loc, /obj/item/rig_module))
		var/obj/item/rig_module/module = src.loc
		if(module.holder && module.holder.wearer)
			var/mob/living/carbon/human/H = module.holder.wearer
			if(istype(H) && H.back)
				var/obj/item/rig/suit = H.back
				if(istype(suit))
					return suit.cell
	if(istype(loc, /obj/item/mecha_equipment))
		var/obj/item/mecha_equipment/ME = loc
		if(ME.owner && ME.owner.body && ME.owner.body.cell)
			return ME.owner.body.cell
	return null

// Predefined firing mechanisms.
/obj/item/gun_component/chamber/laser/pistol
	icon_state="las_pistol"
	weapon_type = GUN_PISTOL
	initial_charge = 5000
	max_shots = 10
	fire_delay = 5
	ammo_indicator_state = "laser_pistol_loaded"
	design_caliber = /decl/weapon_caliber/laser

/obj/item/gun_component/chamber/laser/pistol/taser
	design_caliber = /decl/weapon_caliber/laser/shock

/obj/item/gun_component/chamber/laser/pistol/self_charging
	name = "prototype charging mechanism"
	self_recharge_time = 4

/obj/item/gun_component/chamber/laser/rifle
	icon_state="las_rifle"
	name = "precision lens"
	weapon_type = GUN_RIFLE
	initial_charge = 10000
	max_shots = 4
	fire_delay = 35
	ammo_indicator_state = "laser_rifle_loaded"
	accuracy_mod = 1
	design_caliber = /decl/weapon_caliber/laser/precision

/obj/item/gun_component/chamber/laser/cannon
	icon_state="las_cannon"
	name = "three-phase industrial lens"
	weapon_type = GUN_CANNON
	initial_charge = 16000
	max_shots = 5
	fire_delay = 20
	ammo_indicator_state = "laser_cannon_loaded"
	design_caliber = /decl/weapon_caliber/laser/heavy

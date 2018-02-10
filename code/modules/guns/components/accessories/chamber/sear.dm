/obj/item/gun_component/accessory/chamber/sear
	name = "sear assembly"
	icon_state = "sear"
	weight_mod = 1
	var/list/firemodes

/obj/item/gun_component/accessory/chamber/sear/apply_mod(var/obj/item/gun/composite/gun)
	if(LAZYLEN(firemodes))
		if(!islist(gun.firemodes))
			gun.firemodes = firemodes.Copy()
		else
			gun.firemodes |= firemodes
		for(var/i in 1 to LAZYLEN(gun.firemodes))
			if(islist(gun.firemodes[i]))
				gun.firemodes[i] = new /datum/firemode(gun, gun.firemodes[i])
	..()

/obj/item/gun_component/accessory/chamber/sear/removed_from(var/obj/item/gun, var/mob/user)
	var/obj/item/gun/composite/removed_from_weapon = holder
	. = ..()
	if(istype(removed_from_weapon))

		removed_from_weapon.sel_mode = 1
		removed_from_weapon.burst = 1
		removed_from_weapon.fire_delay = removed_from_weapon.chamber.fire_delay
		removed_from_weapon.move_delay = null
		removed_from_weapon.burst_accuracy = null
		removed_from_weapon.dispersion = null

		removed_from_weapon.firemodes.Cut()
		for(var/obj/item/gun_component/accessory/chamber/sear/S in removed_from_weapon.contents)
			S.apply_mod(removed_from_weapon)

/obj/item/gun_component/accessory/chamber/sear/burst_ballistic
	name = "burst-fire sear assembly"
	restricted_to_type = GUN_TYPE_BALLISTIC
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, requires_two_hands = 2, move_delay=5,    burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0))
		)

/obj/item/gun_component/accessory/chamber/sear/burst_energy
	name = "multiphase pulse array"
	restricted_to_type = GUN_TYPE_LASER
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0),
		list(mode_name="3-round bursts", burst=3, fire_delay=0, move_delay=3, dispersion=list(0.0, 0.6, 1.0))
		)

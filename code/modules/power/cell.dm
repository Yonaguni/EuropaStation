var/cell_uid = 1		// Unique ID of this power cell. Used to reduce bunch of uglier code in nanoUI.

// Power Cells
/obj/item/cell
	name = "power cell"
	desc = "A rechargable electrochemical power cell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_state = "cell"
	auto_init = TRUE

	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = NORMAL_ITEM
	var/c_uid
	var/charge = 0			// Current charge
	var/maxcharge = 1000	// Capacity in Wh
	var/overlay_state
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 50)


/obj/item/cell/New()
	..()
	charge = maxcharge
	c_uid = cell_uid++

/obj/item/cell/initialize()
	..()
	update_icon()

/obj/item/cell/drain_power(var/drain_check, var/surge, var/power = 0)

	if(drain_check)
		return 1

	if(charge <= 0)
		return 0

	var/cell_amt = power * CELLRATE

	return use(cell_amt) / CELLRATE

/obj/item/cell/update_icon()

	var/new_overlay_state = null
	if(charge/maxcharge >= 0.95)
		new_overlay_state = "cell-o2"
	else if(charge >= 0.05)
		new_overlay_state = "cell-o1"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image('icons/obj/power.dmi', overlay_state)

/obj/item/cell/get_cell()
	return src

/obj/item/cell/proc/percent()		// return % charge of cell
	return 100.0*charge/maxcharge

/obj/item/cell/proc/fully_charged()
	return (charge == maxcharge)

// checks if the power cell is able to provide the specified amount of charge
/obj/item/cell/proc/check_charge(var/amount)
	return (charge >= amount)

// use power from a cell, returns the amount actually used
/obj/item/cell/proc/use(var/amount)
	var/used = min(charge, amount)
	charge -= used
	update_icon()
	return used

// Checks if the specified amount can be provided. If it can, it removes the amount
// from the cell and returns 1. Otherwise does nothing and returns 0.
/obj/item/cell/proc/checked_use(var/amount)
	if(!check_charge(amount))
		return 0
	use(amount)
	return 1

/obj/item/cell/proc/give(var/amount)
	if(maxcharge < amount)	return 0
	var/amount_used = min(maxcharge-charge,amount)
	charge += amount_used
	update_icon()
	return amount_used

/obj/item/cell/examine(mob/user)
	..()
	user << "The label states it's capacity is [maxcharge] Wh"
	user << "The charge meter reads [round(src.percent(), 0.1)]%"

/obj/item/cell/emp_act(severity)
	//remove this once emp changes on dev are merged in
	if(isrobot(loc))
		var/mob/living/silicon/robot/R = loc
		severity *= R.cell_emp_mult

	// Lose 1/2, 1/4, 1/6 of the current charge per hit or 1/4, 1/8, 1/12 of the max charge per hit, whichever is highest
	charge -= max(charge / (2 * severity), maxcharge/(4 * severity))
	if (charge < 0)
		charge = 0
	..()


/obj/item/cell/proc/get_electrocute_damage()
	switch (charge)
		if (1000000 to INFINITY)
			return min(rand(50,160),rand(50,160))
		if (200000 to 1000000-1)
			return min(rand(25,80),rand(25,80))
		if (100000 to 200000-1)//Ave powernet
			return min(rand(20,60),rand(20,60))
		if (50000 to 100000-1)
			return min(rand(15,40),rand(15,40))
		if (1000 to 50000-1)
			return min(rand(10,20),rand(10,20))
		else
			return 0


// SUBTYPES BELOW

// Smaller variant, used by energy guns and similar small devices.
/obj/item/cell/device
	name = "device power cell"
	desc = "A small power cell designed to power handheld devices."
	icon_state = "cell" //placeholder
	w_class = SMALL_ITEM
	force = 0
	throw_speed = 5
	throw_range = 7
	maxcharge = 1000
	matter = list("metal" = 350, "glass" = 50)

/obj/item/cell/device/variable/New(newloc, charge_amount)
	..(newloc)
	maxcharge = charge_amount
	charge = maxcharge
	update_icon()


/obj/item/cell/crap
	name = "old power cell"
	desc = "A cheap old power cell. It's probably been in use for quite some time now."

	maxcharge = 100
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 40)

/obj/item/cell/crap/empty/New()
	..()
	charge = 0


/obj/item/cell/standard
	name = "standard power cell"
	desc = "A standard and relatively cheap power cell, commonly used around the station."

	maxcharge = 250
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 40)

/obj/item/cell/crap/empty/New()
	..()
	charge = 0


/obj/item/cell/apc
	name = "APC power cell"
	desc = "A special power cell designed for heavy-duty use in area power controllers."

	maxcharge = 500
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 50)


/obj/item/cell/high
	name = "advanced power cell"
	desc = "An advanced high-grade power cell, for use in important systems."

	icon_state = "hcell"
	maxcharge = 1000
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 60)

/obj/item/cell/high/empty/New()
	..()
	charge = 0


/obj/item/cell/mecha
	name = "exosuit power cell"
	desc = "A special power cell designed for heavy-duty use in industrial exosuits."

	icon_state = "hcell"
	maxcharge = 1500
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 70)


/obj/item/cell/super
	name = "enhanced power cell"
	desc = "A very advanced power cell with increased energy density, for use in critical applications."

	icon_state = "scell"
	maxcharge = 2000
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 70)

/obj/item/cell/super/empty/New()
	..()
	charge = 0


/obj/item/cell/hyper
	name = "superior power cell"
	desc = "Pinnacle of power storage technology, this very expensive power cell provides the best energy density reachable with conventional electrochemical cells."

	icon_state = "hpcell"
	maxcharge = 3000
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 80)

/obj/item/cell/hyper/empty/New()
	..()
	charge = 0


/obj/item/cell/infinite
	name = "experimental power cell"
	desc = "This special experimental power cell has both very large capacity, and ability to recharge itself by draining power from zero-point energy."
	icon_state = "icell"
	maxcharge = 3000
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 80)

/obj/item/cell/infinite/check_charge()
	return 1

/obj/item/cell/infinite/use()
	return 1


/obj/item/cell/potato
	name = "potato battery"
	desc = "A rechargable starch based power cell."

	icon = 'icons/obj/power.dmi' //'icons/obj/harvest.dmi'
	icon_state = "potato_cell" //"potato_battery"
	maxcharge = 20

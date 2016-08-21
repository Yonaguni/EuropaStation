/obj/item/cell
	name = "power cell"
	desc = "A rechargable electrochemical power cell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_state = "cell"
	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 3.0
	matter = list(DEFAULT_WALL_MATERIAL = 700, "glass" = 50)
	var/charge = 0	// note %age conveted to actual charge in New
	var/maxcharge = 1000

/obj/item/cell/New()
	..()
	charge = maxcharge

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
	overlays.Cut()

	if(charge < 0.01)
		return
	else if(charge/maxcharge >=0.995)
		overlays += image('icons/obj/power.dmi', "cell-o2")
	else
		overlays += image('icons/obj/power.dmi', "cell-o1")

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
	return used

// Checks if the specified amount can be provided. If it can, it removes the amount
// from the cell and returns 1. Otherwise does nothing and returns 0.
/obj/item/cell/proc/checked_use(var/amount)
	if(!check_charge(amount))
		return 0
	use(amount)
	return 1

// recharge the cell
/obj/item/cell/proc/give(var/amount)
	if(maxcharge < amount)	return 0
	var/amount_used = min(maxcharge-charge,amount)
	charge += amount_used
	return amount_used

/obj/item/cell/examine(mob/user)
	if(get_dist(src, user) > 1)
		return

	if(maxcharge <= 2500)
		user << "[desc]\nThe manufacturer's label states this cell has a power rating of [maxcharge], and that you should not swallow it.\nThe charge meter reads [round(src.percent() )]%."
	else
		user << "This power cell has an exciting chrome finish, as it is an uber-capacity cell type! It has a power rating of [maxcharge]!\nThe charge meter reads [round(src.percent() )]%."

/obj/item/cell/emp_act(severity)
	// Lose 1/2, 1/4, 1/8 of the current charge per hit or 1/4, 1/8, 1/24 of the max charge per hit, whichever is highest
	charge -= max(charge / (2 / severity), maxcharge/(4 / severity))
	if (charge < 0)
		charge = 0
	..()

/obj/item/cell/ex_act(severity)

	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return
		if(3.0)
			if (prob(25))
				qdel(src)
				return
	return

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

//currently only used by energy-type guns, that may change in the future.
/obj/item/cell/device
	name = "device power cell"
	desc = "A small power cell designed to power handheld devices."
	icon_state = "cell" //placeholder
	w_class = 2
	force = 0
	throw_speed = 5
	throw_range = 7
	maxcharge = 1000
	matter = list("metal" = 350, "glass" = 50)

/obj/item/cell/device/variable/New(newloc, charge_amount)
	..(newloc)
	maxcharge = charge_amount
	charge = maxcharge

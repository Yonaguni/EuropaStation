/obj/structure/reagent_dispenser
	name = "portable tank"
	desc = "A large wheeled tank, suitable for transporting liquids."
	icon = 'icons/obj/structures/tanks.dmi'
	icon_state = "tank"
	density = 1
	anchored = 0

	var/label_state
	var/max_volume = 1000
	var/amount_per_transfer_from_this = 10
	var/possible_transfer_amounts = list(10,25,50,100)

/obj/structure/reagent_dispenser/attackby(var/obj/item/W, var/mob/user)
	return

/obj/structure/reagent_dispenser/initialize()
	update_icon()
	create_reagents(max_volume)
	if (!possible_transfer_amounts)
		src.verbs -= /obj/structure/reagent_dispenser/verb/set_APTFT
	return ..()

/obj/structure/reagent_dispenser/update_icon()
	overlays.Cut()
	if(label_state) overlays += image(icon, label_state)

/obj/structure/reagent_dispenser/proc/has_accelerant()
	var/amt = 0
	for(var/datum/reagent/R in reagents.reagent_list)
		if(R.flammable > 0)
			amt += (R.volume * R.flammable)
	return ((amt > reagents.total_volume * 0.8) ? amt : 0)

/obj/structure/reagent_dispenser/examine(var/mob/user)
	if(!..(user, 2))
		return
	var/ramt = (reagents.total_volume/max_volume)*100
	if(ramt == 0)
		user << "<span class='notice'>It's empty.</span>"
	else if (ramt <= 35)
		user << "<span class='notice'>It's almost empty.</span>"
	else if (ramt <= 65)
		user << "<span class='notice'>It's half-full of liquid.</span>"
	else if (ramt <= 90)
		user << "<span class='notice'>It's almost full of liquid.</span>"
	else
		user << "<span class='notice'>It's full of liquid.</span>"

	if(has_accelerant())
		user << "<span class='danger'>It reeks of spilled fuel.</span>"

/obj/structure/reagent_dispenser/verb/set_APTFT() //set amount_per_transfer_from_this
	set name = "Set transfer amount"
	set category = "Object"
	set src in view(1)
	var/N = input("Amount per transfer from this:","[src]") as null|anything in possible_transfer_amounts
	if (N)
		amount_per_transfer_from_this = N

/obj/structure/reagent_dispenser/ex_act(var/severity)

	if(has_accelerant())
		explode()
		return

	switch(severity)
		if(1)
			qdel(src)
		if(2)
			if(prob(50))
				qdel(src)
		if(3)
			if(prob(5))
				qdel(src)
	return

/obj/structure/reagent_dispenser/bullet_act(var/obj/item/projectile/Proj)

	if(!has_accelerant())
		return ..()

	if(Proj.get_structure_damage())
		if(istype(Proj.firer))
			message_admins("[key_name_admin(Proj.firer)] shot fueltank at [loc.loc.name] [ADMIN_JUMP_LINK(loc.x,loc.y,loc.z)].")
			log_game("[key_name(Proj.firer)] shot fueltank at [loc.loc.name] ([loc.x],[loc.y],[loc.z]).")
		if(!istype(Proj ,/obj/item/projectile/beam/practice))
			explode()

/obj/structure/reagent_dispenser/proc/explode()
	var/accel_amt = has_accelerant()
	if (accel_amt > 500)
		explosion(src.loc,1,2,4)
	else if (accel_amt > 100)
		explosion(src.loc,0,1,3)
	else if (accel_amt > 50)
		explosion(src.loc,-1,1,2)
	else
		return
	if(src)
		qdel(src)

// Subtypes.
/obj/structure/reagent_dispenser/watertank
	name = "water tank"
	desc = "A tank that declares itself to be full of water."
	label_state = "water"

/obj/structure/reagent_dispenser/watertank/initialize()
	. = ..()
	reagents.add_reagent(REAGENT_ID_WATER, max_volume)

/obj/structure/reagent_dispenser/fueltank
	name = "fuel tank"
	desc = "A tank that declares itself to be full of fuel."
	label_state = "fuel"

/obj/structure/reagent_dispenser/fueltank/initialize()
	. = ..()
	reagents.add_reagent(REAGENT_ID_FUEL, max_volume)

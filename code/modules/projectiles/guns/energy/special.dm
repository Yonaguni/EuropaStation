/obj/item/weapon/gun/energy/ionrifle
	name = "directed-energy particle rifle"
	desc = "Although the name is rather menacing, this bulky, power-hungry energy weapon is designed to damage and incapacitate machinery and causes little to no damage to organic flesh."
	icon_state = "ionrifle"
	item_state = "ionrifle"
	fire_sound = 'sound/weapons/Laser.ogg'
	w_class = 4
	force = 10
	flags =  CONDUCT
	slot_flags = SLOT_BACK
	charge_cost = 300
	max_shots = 10
	projectile_type = /obj/item/projectile/ion

/obj/item/weapon/gun/energy/ionrifle/emp_act(severity)
	..(max(severity, 2)) //so it doesn't EMP itself, I guess

/obj/item/weapon/gun/energy/ionrifle/update_icon()
	..()
	if(power_supply.charge < charge_cost)
		item_state = "ionrifle-empty"
	else
		item_state = initial(item_state)

/obj/item/weapon/gun/energy/decloner
	name = "biological demolecularisor"
	desc = "A gun that discharges high amounts of controlled radiation to slowly break a target into component elements."
	icon_state = "decloner"
	item_state = "decloner"
	fire_sound = 'sound/weapons/pulse3.ogg'
	max_shots = 10
	projectile_type = /obj/item/projectile/energy/declone

/obj/item/weapon/gun/energy/floragun
	name = "floral somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells."
	icon_state = "floramut100"
	item_state = "floramut"
	fire_sound = 'sound/effects/stealthoff.ogg'
	charge_cost = 100
	max_shots = 10
	projectile_type = /obj/item/projectile/energy/floramut
	modifystate = "floramut"
	self_recharge = 1

	firemodes = list(
		list(mode_name="induce mutations", projectile_type=/obj/item/projectile/energy/floramut, modifystate="floramut"),
		list(mode_name="increase yield", projectile_type=/obj/item/projectile/energy/florayield, modifystate="florayield"),
		)

/obj/item/weapon/gun/energy/floragun/afterattack(obj/target, mob/user, adjacent_flag)
	//allow shooting into adjacent hydrotrays regardless of intent
	if(adjacent_flag && istype(target,/obj/machinery/portable_atmospherics/hydroponics))
		user.visible_message("<span class='danger'>\The [user] fires \the [src] into \the [target]!</span>")
		Fire(target,user)
		return
	..()

/obj/item/weapon/gun/energy/meteorgun
	name = "meteor gun"
	desc = "For the love of god, make sure you're aiming this the right way!"
	icon_state = "riotgun"
	item_state = "c20r"
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = 4
	projectile_type = /obj/item/projectile/meteor
	cell_type = /obj/item/weapon/cell/potato
	self_recharge = 1
	recharge_time = 5 //Time it takes for shots to recharge (in ticks)
	charge_meter = 0

/obj/item/weapon/gun/energy/meteorgun/pen
	name = "meteor pen"
	desc = "The pen is mightier than the sword."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	w_class = 1
	slot_flags = SLOT_BELT


/obj/item/weapon/gun/energy/mindflayer
	name = "mind flayer"
	desc = "A custom-built weapon of some kind."
	icon_state = "xray"
	projectile_type = /obj/item/projectile/beam/mindflayer
	fire_sound = 'sound/weapons/Laser.ogg'

/obj/item/weapon/gun/energy/toxgun
	name = "radpistol"
	desc = "A specialized firearm designed to fire lethal bolts of gamma radiation."
	icon_state = "toxgun"
	fire_sound = 'sound/effects/stealthoff.ogg'
	w_class = 3.0
	projectile_type = /obj/item/projectile/energy/phoron

/* Adminbus guns */

// Serves as a target spotter for the Icarus.
/obj/item/weapon/gun/energy/icarus
	name = "rubber ducky"
	desc = "It's a cute rubber duck.  With an evil gleam in it's eye."
	projectile_type = /obj/item/projectile/icarus/pointdefense
	icon = 'icons/obj/watercloset.dmi'
	item_icons = null
	icon_state = "rubberducky"
	item_state = "rubberducky"
	charge_cost = 0
	silenced = 1

/obj/item/weapon/gun/energy/icarus/attack_self(mob/living/user as mob)
	if(projectile_type == /obj/item/projectile/icarus/pointdefense)
		projectile_type = /obj/item/projectile/icarus/guns
		user << "You inform the Icarus to switch to the main guns."
	else
		projectile_type = /obj/item/projectile/icarus/pointdefense
		user << "You inform the Icarus to switch to the point-defense lasers."

	. = ..()

/obj/item/weapon/gun/energy/icarus/update_icon()
	return

/obj/item/weapon/gun/energy/icarus/verb/SetIcarusAngle()
	set src in usr
	set name = "Set Firing Angle"
	set desc = "Sets the angle from which the icarus will fire."
	set category = "Object"

	Icarus_SetPosition(usr)


/obj/item/weapon/gun/energy/variable
	name = "abstract weapon"
	desc = "It seems to shift and flow as you watch."
	charge_cost = 0
	silenced = 1

/obj/item/weapon/gun/energy/variable/update_icon()
	return

/obj/item/weapon/gun/energy/variable/attack_self(mob/living/user as mob)
	var/type = input(user,"What projectile type?","Projectile", null) as null|anything in typesof(/obj/item/projectile)
	if(!type)
		return ..()
	projectile_type = type
	. = ..()

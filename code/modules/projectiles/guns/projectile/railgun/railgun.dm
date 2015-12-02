/obj/item/weapon/gun/projectile/railgun
	name = "rail pistol"
	desc = "30 megajoules of impact force in a package the size of a housecat. Keep the safety on when you jam it into your waistband."
	icon_state = "railpistol"
	icon = 'icons/obj/railguns.dmi'
	load_method = SPEEDLOADER
	max_shells = 12
	fire_sound = 'sound/effects/railgun.ogg'
	ammo_type = /obj/item/ammo_casing/railgun
	magazine_type = /obj/item/ammo_magazine/railgun
	caliber = "railgun slug"
	w_class = 2
	force = 5

	var/rail_damage =           0
	var/rail_damage_threshold = 2
	var/rail_deformed =         0
	var/rail_damage_prob =      10
	var/rail_repair_time =      50

/obj/item/weapon/gun/projectile/railgun/Destroy()
	processing_objects -= src
	..()

// This is pretty simplistic, consider making it more complex to repair them.
/obj/item/weapon/gun/projectile/railgun/attackby(var/obj/item/I, var/mob/user)
	if(rail_deformed && istype(I,/obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = I
		if(!WT.isOn())
			user << "<span class='warning'>You need a lit welding tool to repair \the [src].</span>"
			return
		user << "<span class='notice'>You begin repairing the warped rail of \the [src]...</span>"
		playsound(get_turf(src), 'sound/items/Welder2.ogg', 50, 1)
		if(!do_after(user, rail_repair_time) || !WT.isOn() || !src)
			return
		user << "<span class='notice'>You finish repairing \the [src].</span>"
		rail_deformed = 0
		rail_damage = Floor(rail_damage/2) //You don't get to completely reset wear and tear with one click.
		if(rail_damage > 0)
			processing_objects |= src
	else
		//TODO: click with a fresh set of rails to eject the damaged set and put in new ones.
		return ..()

/obj/item/weapon/gun/projectile/railgun/special_check(var/mob/user)
	if(rail_deformed)
		user << "<span class='warning'>\The [src]'s rails are deformed! It cannot fire!</span>"
		return 0
	return ..()

/obj/item/weapon/gun/projectile/railgun/handle_post_fire()
	..()
	rail_damage++
	if(!rail_deformed && rail_damage >= rail_damage_threshold && prob(rail_damage * rail_damage_prob))
		check_damage() // You gun doofed.
	else
		processing_objects |= src

/obj/item/weapon/gun/projectile/railgun/process()
	if(rail_damage <= 0)
		return
	if(!rail_deformed)
		rail_damage = max(0, rail_damage - rand(1,3)) // Cooling.
		if(rail_damage <= 0)
			processing_objects -= src

/obj/item/weapon/gun/projectile/railgun/proc/check_damage()
	rail_deformed = 1
	processing_objects -= src
	var/mob/M = loc
	if(istype(M))
		M << "<span class='danger'>\The [src]'s rails have warped visibly under the stress of firing!</span>"

// Water-cooled full-auto railguns when?
/obj/item/weapon/gun/projectile/railgun/water_act(var/depth)
	if(depth && rail_damage)
		var/turf/T = get_turf(src)
		if(T) T.visible_message("<span class='notice'>\The [src] hisses and steams as the liquid cools off its barrel.</span>")
		rail_damage = Floor(rail_damage/2)
		if(!rail_damage)
			processing_objects -= src
	return ..(depth)

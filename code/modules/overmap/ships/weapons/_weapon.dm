/obj/machinery/power/ship_weapon
	name = "ship-mounted weapon"
	icon = 'icons/obj/ship_weapons.dmi'
	icon_state = "maser"
	idle_power_usage = 150
	pixel_x = -16
	pixel_y = -16
	anchored = 1
	density = 1

	var/projectile_type = /obj/item/projectile/ship_munition
	var/obj/effect/overmap/ship/linked

/obj/machinery/power/ship_weapon/proc/get_status()
	if(!powered())
		return "[name]: <span class='danger'>OFFLINE</span>"
	if(!can_fire())
		return "[name]: <b><font color='#FF9900'>NOT READY</font></b>"
	return "[name]: <b><font color='#00FF00'>READY</font></b>"

/obj/machinery/power/ship_weapon/initialize()
	..()
	linked = map_sectors["[z]"]
	if(linked)
		linked.weapons |= src

/obj/machinery/power/ship_weapon/update_icon()
	overlays.Cut()
	if(powered())
		overlays += "[icon_state]_on"

/obj/machinery/power/ship_weapon/proc/can_fire()
	return FALSE

/obj/machinery/power/ship_weapon/proc/handle_pre_fire()
	return TRUE

/obj/machinery/power/ship_weapon/proc/handle_post_fire()
	return TRUE

/obj/machinery/power/ship_weapon/proc/fire()

	if(!can_fire() || !handle_pre_fire())
		return FALSE

	var/obj/item/projectile/ship_munition/fired = new projectile_type(get_turf(src))
	if(!fired)
		return FALSE

	fired.fired_by = linked
	fired.fired_at = linked.last_weapon_target
	if(fired.fire_sound)
		playsound(get_turf(src), fired.fire_sound, 100, 1)
	fired.launch(get_edge_target_turf(src, dir))

	if(!handle_post_fire())
		return FALSE

	return fired

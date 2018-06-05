/obj/machinery/power/ship_weapon
	name = "ship-mounted weapon"
	icon = 'icons/obj/ship_weapons.dmi'
	icon_state = "maser"
	idle_power_usage = 150
	pixel_x = -16
	pixel_y = -16
	anchored = 1
	density = 1

	var/global/weapon_number = 0
	var/projectile_type = /obj/item/projectile/ship_munition
	var/obj/effect/overmap/ship/linked

/obj/machinery/power/ship_weapon/proc/get_status()
	var/list/data = list()
	data["name"] = name
	var/area/area = get_area(src)
	data["location"] = area.name
	if(!powered())
		data["status"] = "<span class='danger'>OFFLINE</span>"
	else if(!can_fire())
		data["status"] = "<b><font color='#FF9900'>NOT READY</font></b>"
	else
		data["status"] = "<b><font color='#00FF00'>READY</font></b>"
	return data

/obj/machinery/power/ship_weapon/Initialize()
	. = ..()
	linked = map_sectors["[z]"]
	weapon_number++
	name = "[initial(name)] #[weapon_number]"
	if(linked) linked.weapons |= src

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

/obj/machinery/power/ship_weapon/proc/get_projectile()
	return new projectile_type(get_turf(src))

/obj/machinery/power/ship_weapon/proc/fire()

	if(!can_fire() || !handle_pre_fire())
		return FALSE

	var/obj/item/projectile/ship_munition/fired = get_projectile()
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

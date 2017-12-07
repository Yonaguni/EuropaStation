/obj/item/projectile/ship_munition
	name = "mass driver round"
	var/obj/effect/overmap/ship/fired_by
	var/fired_at

/obj/item/projectile/ship_munition/touch_map_edge()
	var/obj/effect/overmap/linked = map_sectors["[z]"]
	if(istype(linked) && fired_by)
		return linked.projectile_left_map_edge(src)
	. = ..()
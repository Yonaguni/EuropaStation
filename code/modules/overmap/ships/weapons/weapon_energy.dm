/obj/machinery/power/ship_weapon/maser
	name = "maser cannon"
	projectile_type = /obj/item/projectile/ship_munition/energy
	use_power = 1
	idle_power_usage = 3000

	// Todo: cells and capacitors
	var/stored_power = 0
	var/shot_power = 100000
	var/max_stored_power = 100000
	var/max_draw_per_tick = 10000

/obj/machinery/power/ship_weapon/maser/Initialize()
	. = ..()
	connect_to_network()

/obj/machinery/power/ship_weapon/maser/update_icon()
	..()
	if(powered())
		if(!light_obj)
			set_light(2,10, "#3333FF")
	else
		if(light_obj)
			kill_light()

/obj/machinery/power/ship_weapon/maser/process()
	..()
	if(powered())
		var/draw_amount = min(max_draw_per_tick, max_stored_power-stored_power)
		if(surplus() < draw_amount)
			draw_amount = surplus()
		stored_power += draw_power(draw_amount)
	update_icon()

/obj/machinery/power/ship_weapon/maser/can_fire()
	return powered() && stored_power >= shot_power

/obj/machinery/power/ship_weapon/maser/handle_post_fire()
	. = ..()
	if(.)
		stored_power = max(0, stored_power - shot_power)
		if(prob(30))
			var/datum/effect/system/spark_spread/sparks = PoolOrNew(/datum/effect/system/spark_spread)
			sparks.set_up(2, 1, loc)
			sparks.start()

/obj/machinery/power/ship_weapon/maser/get_status()
	var/list/data = ..()
	data["status"] += " \[CHARGE: [stored_power]/[shot_power]\]"
	return data

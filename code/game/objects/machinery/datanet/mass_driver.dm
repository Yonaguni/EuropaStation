/obj/machinery/datanet/mass_driver
	name = "mass driver"
	desc = "A powerful rail driver that fires things at great speed."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "mass_driver"
	use_power = 1
	idle_power_usage = 2
	active_power_usage = 50
	density = 0
	can_remote_trigger = 1
	console_interface_only = 1
	var/firing = 0

/obj/machinery/datanet/mass_driver/interact()
	drive()

/obj/machinery/datanet/mass_driver/pulsed()
	drive()

/obj/machinery/datanet/mass_driver/proc/drive(amount)
	if(firing)
		return
	firing = 1
	sleep(30)
	if(stat & (BROKEN|NOPOWER))
		return
	use_power(500)
	var/O_limit
	var/atom/target = get_edge_target_turf(src, dir)
	for(var/atom/movable/O in loc)
		if(!O.anchored)
			O_limit++
			if(O_limit >= 20)
				visible_message("<span class='warning'>\The [src] screeches as its overloaded motivators come to a halt.</span>")
				return
			use_power(500)
			spawn(0)
				O.throw_at(target, 50, 1)
	flick("mass_driver1", src)
	sleep(10)
	firing = 0

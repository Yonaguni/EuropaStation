//todo
/obj/machinery
	var/use_power = 1
	var/idle_power_usage = 0
	var/active_power_usage = 0
	var/power_channel = EQUIP //EQUIP, ENVIRON or LIGHT

/obj/machinery/proc/use_power(var/amount)
	return 1

/obj/machinery/proc/powered(var/chan = -1)
	return 1

/obj/machinery/proc/connect_to_network()
	return 1

/obj/machinery/proc/add_power(var/amount)
	return 1

/obj/machinery/proc/power_change()
	return 1

/obj/machinery/proc/surplus()
	return 1000

/obj/machinery/proc/draw_power()
	return 1

//sets the use_power var and then forces an area power update
/obj/machinery/proc/update_use_power(var/new_use_power)
	use_power = new_use_power

/obj/machinery/proc/auto_use_power()
	if(!powered(power_channel))
		return 0
	if(src.use_power == 1)
		use_power(idle_power_usage,power_channel, 1)
	else if(src.use_power >= 2)
		use_power(active_power_usage,power_channel, 1)
	return 1

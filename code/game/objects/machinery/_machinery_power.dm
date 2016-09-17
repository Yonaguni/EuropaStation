/obj/machinery
	var/use_power = 1
	var/idle_power_usage = 0
	var/active_power_usage = 0

/obj/machinery/proc/use_power(var/amount)
	find_power_network()
	if(power_network)
		if(!power_network.draw(amount))
			brown_out()

/obj/machinery/proc/brown_out()
	return

/obj/machinery/proc/powered()
	if(!use_power)
		return
	find_power_network()
	return (power_network ? power_network.is_powered() : 0)

//sets the use_power var and then forces an area power update
/obj/machinery/proc/update_use_power(var/new_use_power)
	use_power = new_use_power

/obj/machinery/proc/auto_use_power()
	if(!powered())
		return 0
	if(src.use_power == 1)
		use_power(idle_power_usage)
	else if(src.use_power >= 2)
		use_power(active_power_usage)
	return 1

/obj/machinery/proc/lose_power()
	power_network = null

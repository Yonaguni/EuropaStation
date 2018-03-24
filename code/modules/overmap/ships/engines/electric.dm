//Thermal nozzle engine
/datum/ship_engine/electric
	name = "electric engine"
	var/obj/machinery/power/engine/nozzle

/datum/ship_engine/electric/New(var/obj/machinery/_holder)
	..()
	nozzle = _holder

/datum/ship_engine/electric/Destroy()
	..()
	nozzle = null

/datum/ship_engine/electric/get_status()
	return nozzle.get_status()

/datum/ship_engine/electric/get_thrust()
	return nozzle.get_thrust()

/datum/ship_engine/electric/burn()
	return nozzle.burn()

/datum/ship_engine/electric/set_thrust_limit(var/new_limit)
	nozzle.thrust_limit = new_limit

/datum/ship_engine/electric/get_thrust_limit()
	return nozzle.thrust_limit

/datum/ship_engine/electric/is_on()
	return nozzle.is_on()

/datum/ship_engine/electric/toggle()
	nozzle.on = !nozzle.on

/datum/ship_engine/electric/can_burn()
	return nozzle.is_on() && nozzle.check_power()

/obj/machinery/power/engine
	name = "ion thruster nozzle"
	desc = "Simple electrical propulsion nozzle, uses ion magic to propel the ship."
	icon = 'icons/obj/ship_engine.dmi'
	icon_state = "nozzle"
	use_power = 1
	idle_power_usage = 1500 // internal circuitry, friction losses and stuff
	opacity = 1
	density = 1
	waterproof = TRUE

	var/on = 1
	var/datum/ship_engine/electric/controller
	var/thrust_limit = 1   // Value between 1 and 0 to limit the resulting thrust

	var/use_power_per_thrust = 10000
	var/max_draw_per_tick = 50000

	// Todo: upgrades, use cells and capacitors
	var/stored_power
	var/max_stored_power = 1000000 // ONE MILLION KILLER WATS

/obj/machinery/power/engine/process()
	..()
	if(powered())
		var/draw_amount = min(max_draw_per_tick, max_stored_power-stored_power)
		if(surplus() < draw_amount)
			draw_amount = surplus()
		stored_power += draw_power(draw_amount)

/obj/machinery/power/engine/Initialize()
	. = ..()
	controller = new(src)
	connect_to_network()

/obj/machinery/power/engine/Destroy()
	..()
	if(controller)
		qdel(controller)
		controller = null

/obj/machinery/power/engine/proc/get_status()
	. = list()
	.+= "Location: [get_area(src)]."
	if(!powered())
		.+= "Insufficient power to operate."
	if(!check_power())
		.+= "Insufficient power for thrust (below [round(use_power_per_thrust * thrust_limit)] kW)."
	.+= "Available power: [stored_power] kW."
	. = jointext(.,"<br>")

/obj/machinery/power/engine/proc/is_on()
	return on && powered() && check_power()

/obj/machinery/power/engine/proc/check_power()
	return stored_power >= round(use_power_per_thrust * thrust_limit)

/obj/machinery/power/engine/proc/get_thrust()
	if(!is_on() || !check_power())
		return 0
	return (use_power_per_thrust / 1000) * thrust_limit

/obj/machinery/power/engine/proc/burn()
	if (!is_on())
		return 0
	if(!check_power())
		audible_message(src,"<span class='warning'>[src] sparks once or twice, then goes dark!</span>")
		on = !on
		return 0
	. = get_thrust()
	stored_power = max(0, stored_power - round(use_power_per_thrust * thrust_limit))
	//TODO: ion trail

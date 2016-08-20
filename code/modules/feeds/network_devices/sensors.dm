/obj/structure/sensor
	name = "sensor"
	icon = 'icons/obj/structures/sensors.dmi'
	icon_state = "sensor"

	var/report_name
	var/report_gas
	var/report_temp
	var/report_fluid

// Sensors are accessible by any number of connections.
// This is totally not because I'm lazy.
/obj/structure/sensor/initialize()
	..()
	if(!report_name)
		report_name = name
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/data/D in T.contents)
		if(!D.network)
			D.build_network()
		var/datum/conduit_network/data_cable/DC = D.network
		if(istype(DC))
			DC.connected_sensors |= src
		pixel_x = D.pixel_x
		pixel_y = D.pixel_y

/obj/structure/sensor/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/device/multitool))
		var/new_name = sanitize(input("Please specify a new name or leave blank to clear.") as text|null, MAX_MESSAGE_LEN)

		if(src && thing && user && Adjacent(user))
			if(isnull(new_name) || new_name == "")
				report_name = initial(name)
				name = report_name
			else
				report_name = new_name
				name = "[initial(name)] ([report_name])"
			user << "<span class='notice'>You configure the sensor to report as [report_name].</span>"
		return
	return ..()

/obj/structure/sensor/proc/get_sensor_data()
	var/list/data = list()
	var/turf/simulated/T = get_turf(src)
	if(istype(T) && T.air)
		if(report_temp)
			data["temperature"] = "[T.air.temperature]ºK"
		if(report_gas)
			for(var/gas_type in T.air.gas)
				data[gas_type] = "[T.air.gas[gas_type]]kPa"
		if(report_fluid)
			for(var/obj/effect/fluid/F in T)
				data[F.fluid_type] = "[F.fluid_amount]L"

	return data

/obj/structure/sensor/omni
	name = "advanced atmosphere sensor"
	report_gas = 1
	report_fluid = 1
	report_temp = 1

/obj/structure/sensor/gas
	name = "atmosphere sensor"
	report_gas = 1

/obj/structure/sensor/fluid
	name = "fluid level sensor"
	report_fluid = 1

/obj/structure/sensor/temperature
	name = "temperature sensor"
	report_temp = 1

/obj/structure/sensor/power
	name = "power sensor"

/obj/structure/sensor/power/get_sensor_data()
	return list() // todo
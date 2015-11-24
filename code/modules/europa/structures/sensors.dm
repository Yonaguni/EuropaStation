/obj/structure/europa/sensor
	name = "sensor"
	var/report_gas
	var/report_temp
	var/report_fluid

// Sensors are accessible by any number of connections.
// This is totally not because I'm lazy.
/obj/structure/europa/sensor/initialize()
	..()
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/data/D in T.contents)
		if(!D.network)
			D.build_network()
		var/datum/conduit_network/data_cable/DC = D.network
		if(istype(DC))
			DC.connected_sensors |= src

/obj/structure/europa/sensor/proc/get_sensor_data()
	var/list/data = list()
	var/turf/simulated/T = get_turf(src)
	if(istype(T) && T.air)
		if(report_temp)
			data["temperature"] = T.air.temperature
		if(report_fluid || report_gas)
			for(var/gas_type in T.air.gas)
				if(gas_data.flags[gas_type] & XGM_GAS_LIQUID)
					if(!report_fluid)
						continue
				else if(!report_gas)
					continue
				data[gas_type] = T.air.gas[gas_type]
	return data

/obj/structure/europa/sensor/omni
	name = "advanced sensor"
	report_gas = 1
	report_fluid = 1
	report_temp = 1

/obj/structure/europa/sensor/gas
	name = "atmosphere sensor"
	report_gas = 1

/obj/structure/europa/sensor/fluid
	name = "fluid level sensor"
	report_fluid = 1

/obj/structure/europa/sensor/temperature
	name = "temperature sensor"
	report_temp = 1

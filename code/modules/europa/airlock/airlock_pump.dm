/obj/machinery/atmospherics/unary/vent_pump/airlock
	name = "airlock air pump"
	desc = "An air vent with additional electronics for airlock control functionality."
	power_channel = EQUIP
	power_rating = 15000	//15 kW ~ 20 HP
	use_power = 0	//these pumps only process when needed, so by default are off until switched on
	frequency = null

	var/_airlock_function
	var/_wifi_id
	var/datum/wifi/receiver/airlock_pump/wifi_receiver

/obj/machinery/atmospherics/unary/vent_pump/airlock/New()
	..()
	if(air_contents)
		air_contents.volume = ATMOS_DEFAULT_VOLUME_PUMP + 800

/obj/machinery/atmospherics/unary/vent_pump/airlock/initialize()
	..()
	if(_wifi_id)
		wifi_receiver = new(_wifi_id, src)

/obj/machinery/atmospherics/unary/vent_pump/airlock/Destroy()
	qdel(wifi_receiver)
	wifi_receiver = null
	return ..()

//contrary to popular belief this will pump any gas or liquid in the room, not just water
/obj/machinery/atmospherics/unary/vent_pump/airlock/water_pump
	name = "airlock water pump"
	desc = "A gas pump that has been upgraded with a motor powerful enough to pump water in high pressure environments."
	power_rating = 30000	//30 kW ~ 40 HP - because damnit it's a high pressure underwater environment

/obj/machinery/atmospherics/unary/vent_pump/airlock/water_pump/New()
	..()
	if(air_contents)
		air_contents.volume = ATMOS_DEFAULT_VOLUME_PUMP + 1800

//-------------------------------
// Airlock function extension for airlock pump wifi receiver
//-------------------------------
/datum/wifi/receiver/airlock_pump
	var/airlock_function

/datum/wifi/receiver/airlock_pump/New()
	..()
	var/obj/machinery/atmospherics/unary/vent_pump/airlock/A = parent
	if(!istype(A))
		return
	airlock_function = A._airlock_function

/datum/wifi/receiver/airlock_pump/proc/drain(var/target_pressure)
	var/obj/machinery/atmospherics/unary/vent_pump/airlock/A = parent
	if(!istype(A))
		return
	A.pump_direction = 0
	A.pressure_checks = 1
	A.external_pressure_bound = target_pressure
	A.use_power = 1
	A.hibernate = 0
	A.update_icon()

/datum/wifi/receiver/airlock_pump/proc/fill(var/target_pressure)
	var/obj/machinery/atmospherics/unary/vent_pump/airlock/A = parent
	if(!istype(A))
		return
	A.pump_direction = 1
	A.pressure_checks = 1
	A.external_pressure_bound = target_pressure
	A.use_power = 1
	A.hibernate = 0
	A.update_icon()

/datum/wifi/receiver/airlock_pump/proc/pump_off()
	var/obj/machinery/atmospherics/unary/vent_pump/airlock/A = parent
	if(!istype(A))
		return
	A.use_power = 0
	A.update_icon()

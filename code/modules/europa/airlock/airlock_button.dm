//-------------------------------
// Airlock button
//  Set _airlock_function to either AL_INTERIOR to cycle to interior, or AL_EXTERIOR to cycle to exterior
//-------------------------------
/obj/machinery/button/alternate/airlock
	waterproof = 0
	var/_airlock_function = AL_INTERIOR

/obj/machinery/button/alternate/airlock/exterior
	_airlock_function = AL_EXTERIOR

//airlock control buttons sit on a sub-network to connect to their airlock controller
/obj/machinery/button/alternate/airlock/New()
	..()
	if(_wifi_id)
		_wifi_id = "[_wifi_id]_control"

/obj/machinery/button/alternate/airlock/initialize()
	if(_wifi_id)
		wifi_sender = new/datum/wifi/sender/button/airlock(_wifi_id, src)
	..()

//-------------------------------
// Airlock button wifi sender
//-------------------------------
/datum/wifi/sender/button/airlock
	var/airlock_function

/datum/wifi/sender/button/airlock/New()
	..()
	var/obj/machinery/button/alternate/airlock/A = parent
	if(istype(A))
		airlock_function = A._airlock_function

/datum/wifi/sender/button/airlock/activate()
	for(var/datum/wifi/receiver/button/B in connected_devices)
		B.activate(airlock_function)

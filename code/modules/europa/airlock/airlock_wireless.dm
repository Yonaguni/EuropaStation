//-------------------------------
// Airlock wireless sender
//  Manages the actual airlock control sequences, turning devices on and off and opening and closing doors.
//-------------------------------
/datum/wifi/sender/airlock
	var/abort = 0

//-------------------------------
// Primary sequences (functions)
//  These are the event sequences of what order events happen in
//-------------------------------
/datum/wifi/sender/airlock/proc/cycle_exterior(var/target_pressure = 0)
	//close doors
	doors_close_all()

	//drain via interior pump
	if(drain_airlock(ALP_DRAININT))
		return		//cancel here if drain_airlock() returns 1 (abort has been called)

	//fill via exterior pump
	if(fill_airlock(ALP_FILLEXT, target_pressure))
		return		//cancel here if fill_airlock() returns 1 (abort has been called)

	//open exterior doors
	doors_close(AL_INTERIOR)	//confirm interior doors are closed and locked
	doors_open(AL_EXTERIOR)

	return 0

/datum/wifi/sender/airlock/proc/cycle_interior(var/target_pressure = ONE_ATMOSPHERE)
	//close exterior doors
	doors_close_all()

	//drain via exterior pump
	if(drain_airlock(ALP_DRAINEXT))
		return		//cancel here if drain_airlock() returns 1 (abort has been called)

	//fill via interior pump
	if(fill_airlock(ALP_FILLINT, target_pressure))
		return		//cancel here if fill_airlock() returns 1 (abort has been called)

	//open interior doors
	doors_close(AL_EXTERIOR)	//confirm exterior doors are closed and locked
	doors_open(AL_INTERIOR)

//-------------------------------
// Secondary functions
//  Auxilliary functions that may be called by the airlock controller
//-------------------------------

//find the chamber sensor to retrieve and cache the current chamber pressure
/datum/wifi/sender/airlock/proc/update_chamber_pressure()
	var/obj/machinery/airlock/A = parent
	if(!istype(A))
		return

	//find a sensor in the airlock chamber to check the pressure of
	var/datum/wifi/receiver/airlock_sensor/test_sensor
	for(var/datum/wifi/receiver/airlock_sensor/S in connected_devices)
		if(S.airlock_function & AL_CHAMBER)
			test_sensor = S
			break

	if(test_sensor)
		A.chamber_pressure = test_sensor.return_pressure()

//deactivate all pumps and set the abort var, this will cause any in-progress fill or drain cycles to cancel on the next tick
/datum/wifi/sender/airlock/proc/abort()
	abort = 1

	//shut down all the pumps
	var/datum/spawn_sync/S = new()
	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function)
			S.start_worker(A, "pump_off")
	S.wait_until_done()

//-------------------------------
// Airlock draining and filling functions
//-------------------------------
/datum/wifi/sender/airlock/proc/drain_airlock(var/drain_target, var/target_pressure = 0)	//either ALP_DRAININT or ALP_DRAINEXT
	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function & drain_target)
			S.start_worker(A, "drain", target_pressure)
	S.wait_until_done()

	//find a sensor in the connected devices to check the pressure of
	var/datum/wifi/receiver/airlock_sensor/test_sensor
	for(var/datum/wifi/receiver/airlock_sensor/A in connected_devices)
		if(A.airlock_function & AL_CHAMBER)
			test_sensor = A
			break

	if(test_sensor)
		//wait until the chamber pressure is close enough to continue
		while(test_sensor.return_pressure() > max(target_pressure, 10))
			if(abort)
				abort = 0
				return 1
			sleep(1)
	else
		log_debug("airlock controller for network: \[[id]\]was unable to find a chamber pressure sensor.")

	//turn all pumps off
	S.reset()
	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function)
			S.start_worker(A, "pump_off")
	S.wait_until_done()

	return

/datum/wifi/sender/airlock/proc/fill_airlock(var/fill_target, var/target_pressure = ONE_ATMOSPHERE)	//either ALP_FILLINT or ALP_FillEXT
	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function & fill_target)
			S.start_worker(A, "fill", target_pressure)
	
	S.wait_until_done()

	//find a sensor in the connected devices to check the pressure of
	var/datum/wifi/receiver/airlock_sensor/test_sensor
	for(var/datum/wifi/receiver/airlock_sensor/A in connected_devices)
		if(A.airlock_function & AL_CHAMBER)
			test_sensor = A
			break

	if(test_sensor)
		//wait until the pressure delta is low enough
		while(test_sensor.return_pressure() < target_pressure * 0.90)
			if(abort)
				abort = 0
				return 1
			sleep(1)
	else
		log_debug("airlock controller for network: \[[id]\]was unable to find a chamber pressure sensor.")

	//turn all pumps off
	S.reset()
	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function)
			S.start_worker(A, "pump_off")
	S.wait_until_done()
	
	return

//-------------------------------
// Door opening and closing sequences
//-------------------------------
/datum/wifi/sender/airlock/proc/doors_close_all()
	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/button/door/D in connected_devices)
		if(D.airlock_function)
			S.start_worker(src, "close_door", D)

	S.wait_until_done()

//target_doors: either AL_INTERIOR or AL_EXTERIOR is recommended
/datum/wifi/sender/airlock/proc/doors_close(var/target_doors)
	var/datum/spawn_sync/S = new()
	
	for(var/datum/wifi/receiver/button/door/D in connected_devices)
		if(D.airlock_function & target_doors)
			S.start_worker(src, "close_door", D)
	
	S.wait_until_done()

//target_doors: either AL_INTERIOR or AL_EXTERIOR is recommended
/datum/wifi/sender/airlock/proc/doors_open(var/target_doors)
	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/button/door/D in connected_devices)
		if(D.airlock_function & target_doors)
			S.start_worker(src, "open_door", D)
	
	S.wait_until_done()

/datum/wifi/sender/airlock/proc/close_door(var/datum/wifi/receiver/button/door/D, var/lock_closed = 1)
	if(!istype(D))
		return
	D.unlock()
	D.close()
	if(lock_closed)
		D.lock()

/datum/wifi/sender/airlock/proc/open_door(var/datum/wifi/receiver/button/door/D, var/lock_open = 1)
	if(!istype(D))
		return
	D.unlock()
	D.open()
	if(lock_open)
		D.lock()

//-------------------------------
// Airlock receiver for receiving commands from buttons
//-------------------------------

//currently only has two functions: cycle to interior or cycle to exterior
/datum/wifi/receiver/button/airlock/activate(var/mode)
	var/obj/machinery/airlock/A = parent
	if(!istype(A))
		return
	switch(mode)
		if(AL_INTERIOR)
			A.cycle_interior()
		if(AL_EXTERIOR)
			A.cycle_exterior()

//-------------------------------
// Airlock function extension for door wifi receiver
//-------------------------------
/datum/wifi/receiver/button/door
	var/airlock_function

/datum/wifi/receiver/button/door/New()
	..()
	var/obj/machinery/door/airlock/A = parent
	if(!istype(A))
		return
	airlock_function = A._airlock_function

//-------------------------------
// Pressure retrieval function for airlock sensor wifi receiver
//-------------------------------
/datum/wifi/receiver/airlock_sensor
	var/airlock_function

/datum/wifi/receiver/airlock_sensor/New()
	..()
	var/obj/machinery/airlock_sensor/A = parent
	if(!istype(A))
		return
	airlock_function = A._airlock_function

/datum/wifi/receiver/airlock_sensor/proc/return_pressure()
	var/obj/machinery/airlock_sensor/S = parent
	if(!istype(S))
		return
	return S.previousPressure

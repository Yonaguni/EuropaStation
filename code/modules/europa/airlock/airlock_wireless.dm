//-------------------------------
// Airlock wireless sender
//  Manages the actual airlock control sequences, turning devices on and off and opening and closing doors.
//-------------------------------
/datum/wifi/sender/airlock
	var/mode = AL_IDLE
	var/stage = ALS_IDLE
	var/target_pressure
	var/current_pressure

/datum/wifi/sender/airlock/proc/process()
	if(!mode)
		return

	update_chamber_pressure()
	stage_check()

	if(stage > ALS_DRAIN)
		switch(stage)
			if(ALS_FILL)
				cycle_fill()
			if(ALS_DONE)
				cycle_finish()

//-------------------------------
// Primary sequences (functions)
//  These are the event sequences of what order events happen in
//-------------------------------
/datum/wifi/sender/airlock/proc/cycle_exterior(var/targ_pressure = 0)
	target_pressure = targ_pressure
	mode = AL_EXTERIOR

	//close doors
	doors_close_all()

	//start drain cycle
	drain_airlock(ALP_DRAININT)

/datum/wifi/sender/airlock/proc/cycle_interior(var/targ_pressure = ONE_ATMOSPHERE)
	target_pressure = targ_pressure
	mode = AL_INTERIOR

	//close exterior doors
	doors_close_all()

	//start drain cycle
	drain_airlock(ALP_DRAINEXT)

//-------------------------------
// Secondary functions
//  Auxilliary functions that may be called by the airlock controller
//-------------------------------

/datum/wifi/sender/airlock/proc/cycle_fill()
	//turn all pumps off
	pumps_off()

	//start fill cycle
	switch(mode)
		if(AL_INTERIOR)
			fill_airlock(ALP_FILLINT)
		if(AL_EXTERIOR)
			fill_airlock(ALP_FILLEXT)

/datum/wifi/sender/airlock/proc/cycle_finish()
	//turn all pumps off
	pumps_off()

	switch(mode)
		if(AL_INTERIOR)
			//open interior doors
			doors_close(AL_EXTERIOR)	//confirm exterior doors are closed and locked
			doors_open(AL_INTERIOR)
		if(AL_EXTERIOR)
			//open exterior doors
			doors_close(AL_INTERIOR)	//confirm interior doors are closed and locked
			doors_open(AL_EXTERIOR)

	mode = AL_IDLE
	stage = ALS_IDLE

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
		current_pressure = test_sensor.return_pressure()
		A.chamber_pressure = current_pressure

//deactivate all pumps and set the abort var, this will cause any in-progress fill or drain cycles to cancel on the next tick
/datum/wifi/sender/airlock/proc/abort()
	pumps_off()
	mode = AL_IDLE
	stage = ALS_IDLE

/datum/wifi/sender/airlock/proc/stage_check()
	switch(stage)
		if(ALS_DRAIN)
			if(check_pressure())
				stage = ALS_FILL
		if(ALS_FILL)
			if(check_pressure())
				stage = ALS_DONE

/datum/wifi/sender/airlock/proc/check_pressure()
	switch(stage)
		if(ALS_DRAIN)
			if(current_pressure < 10)	//drain until less than 10 kPa
				return 1
		if(ALS_FILL)
			if(current_pressure > target_pressure * 0.90)	//fill until 90% of target pressure
				return 1

//-------------------------------
// Airlock draining and filling functions
//-------------------------------
/datum/wifi/sender/airlock/proc/drain_airlock(var/drain_target)	//either ALP_DRAININT or ALP_DRAINEXT
	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function & drain_target)
			S.start_worker(A, "drain", 0)
	S.wait_until_done()

	stage = ALS_DRAIN

/datum/wifi/sender/airlock/proc/fill_airlock(var/fill_target)	//either ALP_FILLINT or ALP_FillEXT
	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function & fill_target)
			S.start_worker(A, "fill", target_pressure)
	
	S.wait_until_done()

	stage = ALS_FILL

/datum/wifi/sender/airlock/proc/pumps_off()
	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/airlock_pump/A in connected_devices)
		if(A.airlock_function)
			S.start_worker(A, "pump_off")
	
	S.wait_until_done()

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
//  currently only has two functions: cycle to interior or cycle to exterior
//-------------------------------
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

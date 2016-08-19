//-------------------------------
// Buttons
//	Sender: intended to be used by buttons, when the button is pressed it will call activate() on all connected /button
//			receivers.
//	Receiver: does whatever the subtype does. deactivate() by default calls activate(), so you will have to override in
//			  it in a subtype if you want it to do something.
//-------------------------------
/datum/wifi/sender/button/activate(mob/living/user)
	for(var/datum/wifi/receiver/button/B in connected_devices)
		B.activate(user)

/datum/wifi/sender/button/deactivate(mob/living/user)
	for(var/datum/wifi/receiver/button/B in connected_devices)
		B.deactivate(user)

/datum/wifi/receiver/button/proc/activate(mob/living/user)

/datum/wifi/receiver/button/proc/deactivate(mob/living/user)
	activate(user)		//override this if you want deactivate to actually do something

//-------------------------------
// Doors
//	Sender: sends an open/close request to all connected /door receivers. Utilises spawn_sync to trigger all doors to
//			open at approximately the same time. Waits until all doors have finished opening before returning.
//	Receiver: will try to open/close the parent door when activate/deactivate is called.
//-------------------------------

// Sender procs
/datum/wifi/sender/door/activate(var/command)
	if(!command)
		return

	var/datum/spawn_sync/S = new()

	for(var/datum/wifi/receiver/button/door/D in connected_devices)
		S.start_worker(D, command)
	S.wait_until_done()
	return

//Receiver procs
/datum/wifi/receiver/button/door/proc/open()
	var/obj/machinery/door/D = parent
	if(istype(D) && D.can_open())
		D.open()

/datum/wifi/receiver/button/door/proc/close()
	var/obj/machinery/door/D = parent
	if(istype(D) && D.can_close())
		D.close()

/datum/wifi/receiver/button/door/proc/lock()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.lock()

/datum/wifi/receiver/button/door/proc/unlock()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.unlock()

/datum/wifi/receiver/button/door/proc/enable_idscan()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.set_idscan(1)

/datum/wifi/receiver/button/door/proc/disable_idscan()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.set_idscan(0)

/datum/wifi/receiver/button/door/proc/enable_safeties()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.set_safeties(1)

/datum/wifi/receiver/button/door/proc/disable_safeties()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.set_safeties(0)

/datum/wifi/receiver/button/door/proc/electrify()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.electrify(-1)

/datum/wifi/receiver/button/door/proc/unelectrify()
	var/obj/machinery/door/airlock/D = parent
	if(istype(D))
		D.electrify(0)

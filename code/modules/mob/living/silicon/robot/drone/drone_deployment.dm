/obj/item/weapon/drone_capsule
	name = "capsule"
	desc = "A pre-packaged robotic drone, ready for activation."
	icon = 'icons/obj/drone_capsules.dmi'
	icon_state = "capsule"

	var/drone_type = "maintenance drone"             // Trap tag/general descriptor.
	var/drone_count = 1                              // Number of drones to create.
	var/drone_path = /mob/living/silicon/robot/drone // Path for created drone.
	var/drone_min_activation_time = 50               // Delay before a primed capsule deploys.
	var/drone_ai = 1                                 // Todo. AI to use if a player can't be found.
	var/drone_ai_delay = 80                          // Window for a player to take control after booting.

	var/searching
	var/ghost_trap_id = /datum/ghosttrap/drone

/obj/item/weapon/drone_capsule/New()
	..()
	name = "[drone_type] [name]"

/obj/item/weapon/drone_capsule/attack_self(var/mob/user)
	if(searching)
		user << "<span class='warning'>\The [src] is currently booting.</span>"
		return
	user << "<span class='notice'>You prime \the [src] and it chimes as it begins booting.</span>"
	searching = 1
	sleep(drone_min_activation_time)
	try_deploy(user)

/obj/item/weapon/drone_capsule/proc/try_deploy(var/mob/user)

	if(src.loc == user)
		user.drop_from_inventory(src)
	src.forceMove(get_turf(src))

	var/datum/ghosttrap/trap = get_ghost_trap("[drone_type]")
	if(!trap)
		log_debug("\The [src] couldn't find a trap for [drone_type].")
		qdel(src)
		return

	var/list/new_drones = list()
	for(var/i=0;i<drone_count;i++)
		var/mob/living/new_drone = new drone_path(get_turf(src))
		new_drones |= new_drone
		trap.request_player(host, "\The [user] is booting \the [new_drone]. ")

	// Spawning these procs so new_drones can be cleared; qdel() needs it.
	for(var/mob/living/silicon/robot/drone/M in new_drones)
		if(istype(M)) M.set_master(user)
		new_drones -= M
		spawn(drone_ai_delay)
			if(!M.client && !M.ckey)
				if(!drone_ai)
					qdel(M)
	qdel(src)

/obj/item/weapon/drone_capsule/journalist
	drone_type = "camera drone"
	drone_path = /mob/living/silicon/robot/drone/journalist

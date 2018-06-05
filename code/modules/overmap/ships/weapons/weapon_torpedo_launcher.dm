// Launcher.
/obj/machinery/power/ship_weapon/torpedo
	name = "launch tube"
	projectile_type = /obj/item/projectile/ship_munition/torpedo
	icon_state = "torpedo"
	use_power = 1
	waterproof = TRUE

	var/obj/structure/torpedo_loader/loader
	var/atom/movable/loaded

/obj/machinery/power/ship_weapon/torpedo/proc/find_loader()
	if(!loader)
		loader = locate() in get_step(get_turf(src), reverse_dir[dir])
		if(loader)
			loader.launcher = src
			loader.layer = layer+0.1

/obj/machinery/power/ship_weapon/torpedo/Initialize()
	find_loader()
	. = ..()

/obj/machinery/power/ship_weapon/torpedo/Destroy()
	if(loader && loader.launcher == src)
		loader.launcher = null
	if(loaded)
		loaded.forceMove(src)
		loaded = null
	. = ..()

/obj/machinery/power/ship_weapon/torpedo/can_fire()
	if(!loader) loader = locate() in get_step(get_turf(src), reverse_dir[dir])
	return (loaded && loader && !loader.open)

/obj/machinery/power/ship_weapon/torpedo/handle_pre_fire()
	// Override for firing non-torpedoes.
	if(!istype(loaded, /obj/structure/torpedo))
		var/atom/movable/AM = loaded
		AM.forceMove(get_turf(src))
		AM.throw_at(get_edge_target_turf(loc,dir),50,30)
		playsound(get_turf(src), 'sound/effects/torpedo.ogg', 100, 1)
		handle_post_fire()
	else
		. = ..()

/obj/machinery/power/ship_weapon/torpedo/get_projectile()
	var/obj/structure/torpedo/torpedo = loaded
	if(istype(torpedo))
		return new torpedo.payload_type(get_turf(src))

/obj/machinery/power/ship_weapon/torpedo/handle_post_fire()
	if(loaded)
		if(loaded.loc == src) // Spent.
			qdel(loaded)
		loaded = null // Either way, it's not relevant to us anymore.
	. = ..()

/obj/machinery/power/ship_weapon/torpedo/relaymove(var/mob/user)
	find_loader()
	if(loader)
		if(!loader.open)
			to_chat(user, "<span class='warning'>You push on the loader door, but it's sealed tight!</span>")
			return
		else
			user.forceMove(get_turf(loader))
			if(loaded == user)
				loaded = null
	else
		user.forceMove(get_turf(src))

	if(user == loaded)
		loaded = null

/obj/machinery/power/ship_weapon/torpedo/get_status()
	var/list/data = ..()
	if(loaded)
		data["status"] += " \[LOADED: [istype(loaded, /obj/structure/torpedo) ? "\the [loaded]" : "unknown object"]\]"
	else
		data["status"] += " \[NO AMMUNITION\]"
	return data

//Loader.
/obj/structure/torpedo_loader
	name = "shell loader"
	desc = "A large, old-fashioned loader for a torpedo tube."
	icon_state = "loader_closed"
	icon  ='icons/obj/ship_misc.dmi'
	density = 1
	opacity = 1
	anchored = 1
	waterproof = TRUE

	var/open = FALSE
	var/obj/machinery/power/ship_weapon/torpedo/launcher

/obj/structure/torpedo_loader/Initialize()
	find_launcher()
	. = ..()

/obj/structure/torpedo_loader/MouseDrop_T(var/atom/movable/target, var/mob/user)
	if(!user.incapacitated() && user.Adjacent(src))
		load(target)

/obj/structure/torpedo_loader/MouseDrop(var/over_object)
	if(!open || over_object != usr || usr.incapacitated() || !usr.Adjacent(src))
		return
	find_launcher()
	if(!launcher || !launcher.loaded)
		to_chat(usr, "<span class='warning'>There is nothing loaded in \the [src].</span>")
		launcher.loaded.forceMove(get_turf(over_object))
		usr.visible_message("<span class='notice'>\The [usr] unloades \the [launcher.loaded] from \the [src].</span>")
		launcher.loaded = null

/obj/structure/torpedo_loader/proc/find_launcher()
	if(!launcher)
		launcher = locate() in get_step(src, dir)
		if(launcher)
			launcher.loader = src
			layer = launcher.layer+0.1

/obj/structure/torpedo_loader/Destroy()
	if(launcher && launcher.loader == src)
		launcher.loader = null
	. = ..()

/obj/structure/torpedo_loader/attackby(var/obj/item/thing, var/mob/user)
	if(open && istype(thing, /obj/item/grab))
		var/obj/item/grab/grab = thing
		user.visible_message("<span class='warning'>\The [user] begins stuffing \the [grab.affecting] into \the [src]!</span>")
		if(do_after(user, 50, grab.affecting) && load(grab.affecting))
			user.visible_message("<span class='danger'>\The [user] stuffs \the [grab.affecting] into \the [src]!</span>")
			user.drop_from_inventory(grab)
		return
	. = ..()

/obj/structure/torpedo_loader/attack_hand(var/mob/user)
	user.visible_message("<span class='notice'>\The [user] begins laboriously [open ? "closing" : "opening"] \the [src].</span>")
	if(do_after(user, 30))
		open = !open
		user.visible_message("<span class='notice'>\The [user] finishes [open ? "unlocking and opening" : "closing and locking"] \the [src].</span>")
		update_icon()

/obj/structure/torpedo_loader/Bumped(var/atom/movable/AM)
	. = ..()
	if(AM.loc == get_step(loc, reverse_dir[dir])) load(AM)

/obj/structure/torpedo_loader/proc/load(var/atom/movable/thing)
	if(open)
		find_launcher()
		if(launcher && !launcher.loaded)
			thing.forceMove(launcher)
			launcher.loaded = thing
			return TRUE
	return FALSE

/obj/structure/torpedo_loader/update_icon()
	icon_state = "loader_[open ? "open" : "closed"]"

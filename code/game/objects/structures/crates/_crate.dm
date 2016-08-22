/obj/structure/crate

	name = "storage crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/structures/crate.dmi'
	icon_state = "crate"
	density = 1
	anchored = 0
	climbable = 1
	w_class = 5

	var/breakout
	var/opened = 0
	var/welded = 0
	var/open_sound = 'sound/machines/click.ogg'
	var/icon_opened = "crateopen"
	var/close_sound = 'sound/machines/click.ogg'
	var/icon_closed = "crate"
	var/can_lock = 0
	var/can_weld = 1
	var/locked = 0
	var/storage_capacity = 2 * MOB_MEDIUM
	var/store_items = 1
	var/store_mobs = 0
	var/material/material

/obj/structure/crate/Destroy()
	material = null
	return ..()

/obj/structure/crate/initialize()
	..()
	if(!opened)
		for(var/obj/item/I in loc)
			if(I.density || I.anchored || I == src)
				continue
			I.forceMove(src)
		var/content_size = 0
		for(var/obj/item/I in contents)
			content_size += Ceiling(I.w_class/2)
		if(content_size > storage_capacity-5)
			storage_capacity = content_size + 5
	update_icon()

/obj/structure/crate/examine(mob/user)
	if(..(user, 1) && !opened)
		var/content_size = 0
		for(var/obj/item/I in src.contents)
			if(!I.anchored)
				content_size += Ceiling(I.w_class/2)
		if(!content_size)
			user << "It is empty."
		else if(storage_capacity > content_size*4)
			user << "It is barely filled."
		else if(storage_capacity > content_size*2)
			user << "It is less than half full."
		else if(storage_capacity > content_size)
			user << "There is still some free space."
		else
			user << "It is full."

/obj/structure/crate/New(var/newloc, var/new_material)
	color = null
	if(!new_material)
		new_material = DEFAULT_WALL_MATERIAL
	material = get_material_by_name(new_material)
	if(!istype(material))
		qdel(src)
		return
	..(newloc)

/obj/structure/crate/proc/toggle(var/mob/user)
	if(opened)
		close(user)
	else
		if(welded)
			user << "<span class='warning'>\The [src] is welded shut.</span>"
		else if(locked)
			user << "<span class='warning'>\The [src] is locked.</span>"
		else
			open(user)
	update_icon()

/obj/structure/crate/get_material()
	return material

/obj/structure/crate/update_icon()
	overlays.Cut()
	var/list/overlays_to_add = list()
	var/image/base
	if(opened)
		base = image(icon, "[icon_opened]")
	else
		base = image(icon, "[icon_closed]")
	base.color = material.icon_colour
	overlays_to_add += base
	if(locked)
		overlays_to_add += image(icon, "[icon_closed]_l")
	if(welded)
		overlays_to_add += image(icon, "[icon_closed]_w")
	overlays = overlays_to_add

	name = "[material.use_name] [initial(name)]"
	desc = "[initial(desc)] This one is made of [material.use_name]"

/obj/structure/crate/proc/can_open()
	return (!opened && !locked && !welded)

/obj/structure/crate/proc/can_close()
	if(opened)
		for(var/obj/structure/crate/closet in get_turf(src))
			if(closet != src)
				return 0
		return 1
	return 0

/obj/structure/crate/proc/open()
	if(!can_open())
		return 0
	playsound(src.loc, open_sound, 15, 1, -3)
	dump_mobs()
	dump_items()
	opened = 1
	if(climbable)
		structure_shaken()
	return 1

/obj/structure/crate/proc/close()
	if(!can_close())
		return 0
	playsound(src.loc, close_sound, 15, 1, -3)
	var/stored_units = 0
	if(store_items)
		stored_units += store_items(stored_units)
	if(store_mobs)
		stored_units += store_mobs(stored_units)
	opened = 0
	return 1

/obj/structure/crate/proc/store_items(var/stored_units)
	var/added_units = 0
	for(var/obj/item/I in src.loc)
		var/item_size = Ceiling(I.w_class / 2)
		if(stored_units + added_units + item_size > storage_capacity)
			continue
		if(!I.anchored)
			I.forceMove(src)
			added_units += item_size
	return added_units

/obj/structure/crate/proc/store_mobs(var/stored_units)
	var/added_units = 0
	for(var/mob/living/M in src.loc)
		if(M.buckled || M.pinned.len)
			continue
		if(stored_units + added_units + M.mob_size > storage_capacity)
			break
		if(M.client)
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = src
		M.forceMove(src)
		added_units += M.mob_size
	return added_units

/obj/structure/crate/proc/dump_items()
	for(var/obj/item/I in src)
		I.forceMove(loc)

/obj/structure/crate/proc/dump_mobs()
	for(var/mob/living/M in src)
		M.forceMove(loc)
		if(M.client)
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = src

/obj/structure/crate/ex_act(severity)
	// Provide some protection against explosions.
	for(var/atom/movable/AM in contents)
		AM.ex_act(min(3, severity+rand(1,3)))
	if(severity == 1 || severity == 2 || prob(50))
		qdel(src)
	return

/obj/structure/crate/relaymove(var/mob/user)
	if(user.stat || !isturf(src.loc))
		return
	if(!open())
		user << "<span class='notice'>The door won't budge!</span>"

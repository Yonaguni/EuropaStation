var/list/holder_mob_icon_cache = list()

//Helper object for picking dionaea (and other creatures) up.
/obj/item/holder
	name = "holder"
	desc = "You shouldn't ever see this."
	icon = 'icons/obj/objects.dmi'
	slot_flags = SLOT_HEAD | SLOT_HOLSTER
	show_messages = 1

	item_icons = list(
		slot_l_hand_str = 'icons/mob/items/lefthand_holder.dmi',
		slot_r_hand_str = 'icons/mob/items/righthand_holder.dmi',
		)
	pixel_y = 8

	var/last_holder

/obj/item/holder/New()
	..()
	processing_objects.Add(src)

/obj/item/holder/Destroy()
	last_holder = null
	processing_objects.Remove(src)
	..()

/obj/item/holder/process()
	update_state()

/obj/item/holder/dropped()
	..()
	spawn(1)
		update_state()

/obj/item/holder/proc/update_state()
	if(last_holder != loc)
		for(var/mob/M in contents)
			unregister_all_movement(last_holder, M)

	if(istype(loc,/turf) || !(contents.len))
		for(var/mob/M in contents)
			var/atom/movable/mob_container = M
			mob_container.forceMove(loc, MOVED_DROP)
			M.reset_view()
		qdel(src)
	else if(last_holder != loc)
		for(var/mob/M in contents)
			register_all_movement(loc, M)

	last_holder = loc

/obj/item/holder/GetID()
	for(var/mob/M in contents)
		var/obj/item/I = M.GetIdCard()
		if(I)
			return I
	return null

/obj/item/holder/GetAccess()
	var/obj/item/I = GetID()
	return I ? I.GetAccess() : ..()

/obj/item/holder/attack_self()
	for(var/mob/M in contents)
		M.show_inv(usr)

/obj/item/holder/proc/sync(var/mob/living/M)
	dir = 2
	overlays.Cut()
	icon = M.icon
	icon_state = M.icon_state
	item_state = M.item_state
	color = M.color
	name = M.name
	desc = M.desc
	overlays |= M.overlays
	var/mob/living/human/H = loc
	last_holder = H
	register_all_movement(H, M)

	if(istype(H))
		if(H.l_hand == src)
			H.update_inv_l_hand()
		else if(H.r_hand == src)
			H.update_inv_r_hand()
		else
			H.regenerate_icons()

/obj/item/holder/mouse
	w_class = 1

/obj/item/holder/attackby(obj/item/W as obj, mob/user as mob)
	for(var/mob/M in src.contents)
		M.attackby(W,user)

//Mob procs and vars for scooping up
/mob/living/var/holder_type

/mob/living/proc/get_scooped(var/mob/living/human/grabber, var/self_grab)

	if(!holder_type || buckled || pinned.len)
		return

	var/obj/item/holder/H = new holder_type(get_turf(src))
	src.forceMove(H)
	grabber.put_in_hands(H)

	if(self_grab)
		grabber << "<span class='notice'>\The [src] clambers onto you!</span>"
		src << "<span class='notice'>You climb up onto \the [grabber]!</span>"
		grabber.equip_to_slot_if_possible(H, slot_back, 0, 1)
	else
		grabber << "<span class='notice'>You scoop up \the [src]!</span>"
		src << "<span class='notice'>\The [grabber] scoops you up!</span>"

	grabber.status_flags |= PASSEMOTES
	H.sync(src)
	return H

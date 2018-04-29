/obj/structure/ore_box
	name = "ore box"
	desc = "A heavy box used for storing ore."
	icon = 'icons/obj/storage.dmi'
	icon_state = "orebox"
	density = TRUE
	var/list/stored_ore = list()

/obj/structure/ore_box/attackby(var/obj/item/W, var/mob/user)
	if(istype(W, /obj/item/ore))
		user.drop_from_inventory(W)
		W.forceMove(src)
		stored_ore[W.name]++
	else if(istype(W, /obj/item/storage))
		var/obj/item/storage/S = W
		S.hide_from(usr)
		for(var/obj/item/ore/O in S.contents)
			S.remove_from_storage(O, src) //This will move the item to this item's contents
			stored_ore[O.name]++
		to_chat(user, "<span class='notice'>You empty the satchel into the box.</span>")

/obj/structure/ore_box/examine(var/mob/user)
	. = ..()
	if(.)
		add_fingerprint(user)
		to_chat(user, "It holds:")
		for(var/ore in stored_ore)
			to_chat(user, "- [stored_ore[ore]] [ore]")

/obj/structure/ore_box/verb/empty_box()
	set name = "Empty Ore Box"
	set category = "Object"
	set src in view(1)
	if(!Adjacent(usr) || usr.incapacitated())
		return
	add_fingerprint(usr)
	if(!contents.len)
		to_chat(usr, "<span class='warning'>\The [src] is empty.</span>")
		return
	for(var/thing in contents)
		var/atom/movable/AM = thing
		AM.forceMove(get_turf(src))
	to_chat(usr, "<span class='notice'>You empty \the [src].</span>")

/obj/structure/ore_box/ex_act(severity)
	if(severity == 1 || (severity == 2 && prob(50)))
		for(var/obj/item/ore/O in contents)
			O.forceMove(get_turf(src))
			O.ex_act(severity++)
		qdel(src)
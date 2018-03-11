/obj/item/sign
	name = "sign"
	desc = "A sign, pulled down from a wall."
	icon = 'icons/obj/signs.dmi'
	w_class = 3
	var/placement_type = /obj/structure/sign

/obj/item/sign/attackby(var/obj/item/tool, var/mob/user)
	if(tool.isscrewdriver())
		deploy(tool, user)
	else
		. = ..()

/obj/item/sign/proc/deploy(var/obj/item/tool, var/mob/user)

	if(in_use) return
	in_use = TRUE

	if(!src || !user.dir || src.loc != user || user.incapacitated())
		in_use = FALSE
		return

	var/offset_x = 0
	var/offset_y = 0
	switch(user.dir)
		if(NORTH)
			offset_y = 32
		if(EAST)
			offset_x = 32
		if(SOUTH)
			offset_y = -32
		if(WEST)
			offset_x = -32
		else
			in_use = FALSE
			return

	var/turf/covering_turf = get_step(get_turf(user), user.dir)
	if(!istype(covering_turf) || !covering_turf.density)
		to_chat(user, "<span class='warning'>You can only place this [name] on a wall.</span>")
		in_use = FALSE
		return

	for(var/obj/structure/sign/S in get_turf(user))
		if(S.pixel_x == offset_x + S.default_pixel_x && S.pixel_y == offset_y + S.default_pixel_y)
			to_chat(user, "<span class='warning'>There is no room for \the [src] on that wall.</span>")
			in_use = FALSE
			return

	var/obj/structure/sign/product = handle_placement(tool, user)
	if(istype(product))
		product.pixel_x = offset_x + product.default_pixel_x
		product.pixel_y = offset_y + product.default_pixel_y
		product.dir = get_dir(covering_turf, get_turf(user))

	if(handle_post_placement(tool, user, product, covering_turf))
		user.drop_from_inventory(src)
		qdel(src)
	else
		qdel(product)

	in_use = FALSE

/obj/item/sign/proc/get_placement_args()
	return src

/obj/item/sign/proc/handle_placement(var/obj/item/tool, var/mob/user)
	return new placement_type(get_turf(user), get_placement_args())

/obj/item/sign/proc/handle_post_placement(var/obj/item/tool, var/mob/user, var/atom/movable/product, var/turf/covering_turf)
	if(src && user && !user.incapacitated() && istype(covering_turf) && covering_turf.density && src.loc == user)
		if(tool)
			to_chat(user, "<span class='notice'>You fasten \the [product] in place with your [tool].</span>")
		return TRUE
	return FALSE

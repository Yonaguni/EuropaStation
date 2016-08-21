/obj/item/reagent_containers/food/snacks/baked/breadslice/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/material/shard) || istype(W,/obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/csandwich/S = new(get_turf(src))
		S.attackby(W,user)
		qdel(src)
	..()

/obj/item/reagent_containers/food/snacks/baked/bun/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/material/shard) || istype(W,/obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/csandwich/burger/S = new(get_turf(src))
		S.attackby(W,user)
		qdel(src)
	..()

/obj/item/reagent_containers/food/snacks/csandwich
	name = "sandwich"
	icon = 'icons/obj/kitchen/meals/sandwiches.dmi'
	desc = "The best thing since sliced bread."
	icon_state = "sandwich_bottom"

	var/vary_fillings = 1
	var/bread_icon = "sandwich"
	var/filling_icon = "sandwich_filling"
	var/filling_limit = 4
	var/list/ingredients = list()

/obj/item/reagent_containers/food/snacks/csandwich/burger
	name = "burger"
	desc = "A timeless classic."

	icon_state = "burger_bottom"
	bread_icon = "burger"
	filling_icon = "burger_filling"
	filling_limit = 2
	vary_fillings = 0

/obj/item/reagent_containers/food/snacks/csandwich/attackby(obj/item/W as obj, mob/user as mob)

	if(src.contents.len > filling_limit)
		user << "<span class='warning'>If you put anything else on \the [src] it's going to collapse.</span>"
		return
	else if(istype(W,/obj/item/material/shard))
		user << "<span class='notice'>You hide \the [W] in \the [src].</span>"
		user.drop_item()
		W.loc = src
		update_icon()
		return
	else if(istype(W,/obj/item/reagent_containers/food/snacks))
		user << "<span class='notice'>You layer \the [W] over \the [src].</span>"
		var/obj/item/reagent_containers/F = W
		F.reagents.trans_to_obj(src, F.reagents.total_volume)
		user.unEquip(W)
		W.loc = src
		ingredients += W
		update_icon()
		return
	..()

/obj/item/reagent_containers/food/snacks/csandwich/update_icon()

	var/fullname = "" //We need to build this from the contents of the var.
	var/i = 0

	overlays.Cut()

	for(var/obj/item/reagent_containers/food/snacks/O in ingredients)
		i++
		if(i == 1)
			fullname += "[O.name]"
		else if(i == ingredients.len)
			fullname += " and [O.name]"
		else
			fullname += ", [O.name]"

		var/image/I = new(src.icon, filling_icon)
		I.color = O.filling_color
		if(vary_fillings)
			I.pixel_x = pick(list(-1,0,1))
		I.pixel_y = i*2
		overlays += I

	var/image/T = new(src.icon, "[bread_icon]_top")
	if(vary_fillings)
		T.pixel_x = pick(list(-1,0,1))
	T.pixel_y = (ingredients.len * 2)
	overlays += T

	name = lowertext("[fullname] [initial(name)]")
	if(length(name) > 80) name = "[pick(list("absurd","colossal","enormous","ridiculous"))] [initial(name)]"
	w_class = n_ceil(Clamp((ingredients.len/2),2,4))

/obj/item/reagent_containers/food/snacks/csandwich/Destroy()
	for(var/obj/item/O in ingredients)
		qdel(O)
	..()

/obj/item/reagent_containers/food/snacks/csandwich/examine(mob/user)
	..(user)
	var/obj/item/O = pick(contents)
	user << "<span class='notice'>You think you can see [O.name] in there.</span>"

/obj/item/reagent_containers/food/snacks/csandwich/attack(mob/M as mob, mob/user as mob, def_zone)

	var/obj/item/shard
	for(var/obj/item/O in contents)
		if(istype(O,/obj/item/material/shard))
			shard = O
			break

	var/mob/living/H
	if(istype(M,/mob/living))
		H = M

	if(H && shard && M == user) //This needs a check for feeding the food to other people, but that could be abusable.
		H << "<span class='danger'>You lacerate your mouth on a [shard.name] in \the [src]!</span>"
		H.adjustBruteLoss(5) //TODO: Target head if human.
	..()

/obj/structure/bookcase
	name = "bookcase"
	icon = 'icons/obj/library.dmi'
	icon_state = "book-0"
	anchored = 1
	density = 1
	opacity = 1

/obj/structure/bookcase/initialize()
	for(var/obj/item/I in loc)
		if(istype(I, /obj/item/weapon/book))
			I.loc = src
	update_icon()

/obj/structure/bookcase/attackby(obj/O as obj, mob/user as mob)
	if(istype(O, /obj/item/weapon/book))
		user.drop_item()
		O.loc = src
		update_icon()
	else if(istype(O, /obj/item/weapon/pen))
		var/newname = sanitizeSafe(input("What would you like to title this bookshelf?"), MAX_NAME_LEN)
		if(!newname)
			return
		else
			name = ("bookcase ([newname])")
	else if(istype(O,/obj/item/weapon/wrench))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
		user << (anchored ? "<span class='notice'>You unfasten \the [src] from the floor.</span>" : "<span class='notice'>You secure \the [src] to the floor.</span>")
		anchored = !anchored
	else if(istype(O,/obj/item/weapon/screwdriver))
		playsound(loc, 'sound/items/Screwdriver.ogg', 75, 1)
		user << "<span class='notice'>You begin dismantling \the [src].</span>"
		if(do_after(user,25))
			user << "<span class='notice'>You dismantle \the [src].</span>"
			new /obj/item/stack/material/wood(get_turf(src), amount = 3)
			for(var/obj/item/weapon/book/b in contents)
				b.loc = (get_turf(src))
			qdel(src)
	else
		..()

/obj/structure/bookcase/attack_hand(var/mob/user as mob)
	if(contents.len)
		var/obj/item/weapon/book/choice = input("Which book would you like to remove from the shelf?") as null|obj in contents
		if(choice)
			if(!usr.canmove || usr.incapacitated() || usr.restrained() || !in_range(loc, usr))
				return
			if(ishuman(user))
				if(!user.get_active_hand())
					user.put_in_hands(choice)
			else
				choice.loc = get_turf(src)
			update_icon()

/obj/structure/bookcase/ex_act(severity)
	switch(severity)
		if(1.0)
			for(var/obj/item/weapon/book/b in contents)
				qdel(b)
			qdel(src)
			return
		if(2.0)
			for(var/obj/item/weapon/book/b in contents)
				if (prob(50)) b.loc = (get_turf(src))
				else qdel(b)
			qdel(src)
			return
		if(3.0)
			if (prob(50))
				for(var/obj/item/weapon/book/b in contents)
					b.loc = (get_turf(src))
				qdel(src)
			return
		else
	return

/obj/structure/bookcase/update_icon()
	if(contents.len < 5)
		icon_state = "book-[contents.len]"
	else
		icon_state = "book-5"

/obj/item/weapon/book
	name = "book"
	icon = 'icons/obj/library.dmi'
	icon_state ="book"
	throw_speed = 1
	throw_range = 5
	w_class = 3		 //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb = list("bashed", "whacked", "educated")
	var/carved = 0	 // Has the book been hollowed out for use as a secret storage item?
	var/obj/item/store	//What's in the book?

/obj/item/weapon/book/attack_self(var/mob/user)
	if(!carved)
		return

	if(store)
		user << "<span class='notice'>\A [store] falls out of \the [src]!</span>"
		store.forceMove(get_turf(src))
		store = null
	else
		user << "<span class='warning'>The pages of \the [src] have been cut out!</span>"
	return

/obj/item/weapon/book/attackby(var/obj/item/weapon/W, var/mob/user)
	if(carved)
		if(!store)
			if(W.w_class < 3)
				user.unEquip(W)
				W.forceMove(src)
				store = W
				user << "<span class='warning'>You put \the [W] in \the [src].</span>"
				return
			else
				user << "<span class='warning'>\The [W] won't fit in \the [src].</span>"
				return
		else
			user << "<span class='warning'>There's already something in \the [src]!</span>"
			return
	else
		..()

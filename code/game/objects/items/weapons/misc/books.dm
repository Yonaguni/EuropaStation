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

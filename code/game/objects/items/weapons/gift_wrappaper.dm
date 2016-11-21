/* Gifts and wrapping paper
 * Contains:
 *		Gifts
 *		Wrapping Paper
 */

/*
 * Gifts
 */
/obj/item/a_gift
	name = "gift"
	desc = "PRESENTS!!!! eek!"
	icon = 'icons/obj/items.dmi'
	icon_state = "gift1"
	item_state = "gift1"
	randpixel = 10

/obj/item/a_gift/New()
	..()
	if(w_class > 0 && w_class < BULKY_ITEM)
		icon_state = "gift[w_class]"
	else
		icon_state = "gift[pick(1, 2, 3)]"
	return

/obj/item/a_gift/ex_act()
	qdel(src)
	return

/obj/effect/spresent/relaymove(var/mob/user)
	if (user.stat)
		return
	user << "<span class='warning'>You can't move.</span>"

/obj/effect/spresent/attackby(var/obj/item/W, var/mob/user)
	..()

	if (!W.iswirecutter())
		user << "<span class='warning'>I need wirecutters for that.</span>"
		return

	user << "<span class='notice'>You cut open the present.</span>"

	for(var/mob/M in src) //Should only be one but whatever.
		M.loc = src.loc
		if (M.client)
			M.client.eye = M.client.mob
			M.client.perspective = MOB_PERSPECTIVE

	qdel(src)

/obj/item/a_gift/attack_self(var/mob/M)
	var/gift_type = pick(
		/obj/item/storage/wallet,
		/obj/item/storage/photo_album,
		/obj/item/storage/box/snappops,
		/obj/item/storage/fancy/crayons,
		/obj/item/storage/backpack/holding,
		/obj/item/storage/belt/champion,
		/obj/item/soap/deluxe,
		/obj/item/pickaxe/silver,
		/obj/item/pen/invisible,
		/obj/item/lipstick/random,
		/obj/item/grenade/smokebomb,
		/obj/item/corncob,
		/obj/item/contraband/poster,
		/obj/item/book/manual/barman_recipes,
		/obj/item/book/manual/chef_recipes,
		/obj/item/bikehorn,
		/obj/item/beach_ball,
		/obj/item/beach_ball/holoball,
		/obj/item/toy/balloon,
		/obj/item/toy/blink,
		/obj/item/toy/crossbow,
		/obj/item/gun/composite/premade/revolver/toy,
		/obj/item/toy/katana,
		/obj/item/toy/prize/deathripley,
		/obj/item/toy/prize/durand,
		/obj/item/toy/prize/fireripley,
		/obj/item/toy/prize/gygax,
		/obj/item/toy/prize/honk,
		/obj/item/toy/prize/marauder,
		/obj/item/toy/prize/mauler,
		/obj/item/toy/prize/odysseus,
		/obj/item/toy/prize/phazon,
		/obj/item/toy/prize/ripley,
		/obj/item/toy/prize/seraph,
		/obj/item/toy/spinningtoy,
		/obj/item/toy/sword,
		/obj/item/reagent_containers/food/snacks/grown/ambrosiadeus,
		/obj/item/reagent_containers/food/snacks/grown/ambrosiavulgaris,
		/obj/item/device/paicard,
		/obj/item/device/violin,
		/obj/item/storage/belt/utility/full,
		/obj/item/clothing/accessory/horrible)

	if(!ispath(gift_type,/obj/item))	return

	var/obj/item/I = new gift_type(M)
	M.remove_from_mob(src)
	M.put_in_hands(I)
	I.add_fingerprint(M)
	qdel(src)
	return

/*
 * Wrapping Paper and Gifts
 */

/obj/item/gift
	name = "gift"
	desc = "A wrapped item."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift3"
	var/size = 3.0
	var/obj/item/gift = null
	item_state = "gift"
	w_class = 5

/obj/item/gift/New(newloc, obj/item/wrapped = null)
	..(newloc)

	if(istype(wrapped))
		gift = wrapped
		w_class = gift.w_class
		gift.forceMove(src)

		//a good example of where we don't want to use the w_class defines
		switch(gift.w_class)
			if(1) icon_state = "gift1"
			if(2) icon_state = "gift1"
			if(3) icon_state = "gift2"
			if(4) icon_state = "gift2"
			if(5) icon_state = "gift3"

/obj/item/gift/attack_self(var/mob/user)
	user.drop_item()
	if(src.gift)
		user.put_in_active_hand(gift)
		src.gift.add_fingerprint(user)
	else
		user << "<span class='warning'>The gift was empty!</span>"
	qdel(src)
	return

/obj/item/wrapping_paper
	name = "wrapping paper"
	desc = "You can use this to wrap items in."
	icon = 'icons/obj/items.dmi'
	icon_state = "wrap_paper"
	var/amount = 2.5*base_storage_cost(BULKY_ITEM)

/obj/item/wrapping_paper/attackby(obj/item/W as obj, var/mob/user)
	..()
	if (!( locate(/obj/structure/table, src.loc) ))
		user << "<span class='warning'>You MUST put the paper on a table!</span>"
	if (W.w_class < BULKY_ITEM)
		if ((istype(user.l_hand, /obj/item/wirecutters) || istype(user.r_hand, /obj/item/wirecutters)))
			var/a_used = W.get_storage_cost()
			if (a_used == DO_NOT_STORE)
				user << "<span class='warning'>You can't wrap that!</span>" //no gift-wrapping lit welders
				return
			if (src.amount < a_used)
				user << "<span class='warning'>You need more paper!</span>"
				return
			else
				if(istype(W, /obj/item/smallDelivery) || istype(W, /obj/item/gift)) //No gift wrapping gifts!
					return

				if(user.drop_from_inventory(W))
					var/obj/item/gift/G = new /obj/item/gift( src.loc, W )
					G.add_fingerprint(user)
					W.add_fingerprint(user)
					src.add_fingerprint(user)
					src.amount -= a_used

			if (src.amount <= 0)
				new /obj/item/c_tube( src.loc )
				qdel(src)
				return
		else
			user << "<span class='warning'>You need scissors!</span>"
	else
		user << "<span class='warning'>The object is FAR too large!</span>"
	return


/obj/item/wrapping_paper/examine(mob/user)
	if(..(user, 1))
		user << text("There is about [] square units of paper left!", src.amount)

/obj/item/wrapping_paper/attack(var/mob/target, var/mob/user)
	if (!istype(target, /mob/living/carbon/human)) return
	var/mob/living/carbon/human/H = target

	if (istype(H.wear_suit, /obj/item/clothing/suit/straight_jacket) || H.stat)
		if (src.amount > 2)
			var/obj/effect/spresent/present = new /obj/effect/spresent (H.loc)
			src.amount -= 2

			if (H.client)
				H.client.perspective = EYE_PERSPECTIVE
				H.client.eye = present

			H.loc = present

			H.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been wrapped with [src.name]  by [user.name] ([user.ckey])</font>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to wrap [H.name] ([H.ckey])</font>")
			msg_admin_attack("[key_name(user)] used [src] to wrap [key_name(H)]")

		else
			user << "<span class='warning'>You need more paper.</span>"
	else
		user << "They are moving around too much. A straightjacket would help."

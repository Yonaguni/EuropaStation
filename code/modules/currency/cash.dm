/obj/item/cash
	name = "cash"
	desc = "Cold, hard cash."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "spacecash1"
	force = 1
	throwforce = 1
	throw_speed = 1
	throw_range = 2
	w_class = 2
	var/worth = 0

/obj/item/cash/New(var/newloc, var/newworth)
	worth = max(1,newworth)
	..(newloc)

/obj/item/cash/initialize()
	if(!worth || worth < 1)
		qdel(src)
		return
	..()
	update_icon()

/obj/item/cash/attackby(var/obj/item/weapon/W as obj, var/mob/user)
	if(istype(W, /obj/item/cash))
		var/obj/item/cash/bundle = W
		bundle.worth += src.worth
		bundle.update_icon()
		var/mob/M = W.loc
		if(istype(M))
			M.unEquip(W)
		M = src.loc
		if(istype(M))
			M.unEquip(src)
		if(user)
			user.put_in_hands(bundle)
			user << "<span class='notice'>You add [src.worth] credit\s to \the [src].</span>"
			user << "<span class='notice'>It is now worth [bundle.worth] credit\s.</span>"
		qdel(src)
		return
	return ..()

/obj/item/cash/update_icon()
	overlays.Cut()
	if(worth == 1)
		name = "credit"
	else if(worth < 50)
		name = "[worth] credits"
	else
		name = "pile of credits"
	if(worth == 1)
		overlays += make_banknote(1)
	else
		var/sum = worth
		for(var/i in list(1000,500,200,100,50,20,10,1))
			while(sum >= i)
				sum -= i
				overlays += make_banknote(i)
	desc = "[initial(desc)] It's worth [worth] credit\s."

/obj/item/cash/attack_self(var/mob/user)
	var/amount = input(user, "How many credits do you want to take? (0 to [src.worth])", "Take Money", min(src.worth,20)) as null|num
	amount = round(Clamp(amount, 0, src.worth))
	if(!amount)
		return 0
	worth -= amount
	if(worth <= 0)
		var/mob/M = loc
		if(istype(M))
			M.unEquip(src)
		qdel(src)
	else
		update_icon()
	var/obj/item/cash/bundle = new (get_turf(user), amount)
	user.put_in_hands(bundle)

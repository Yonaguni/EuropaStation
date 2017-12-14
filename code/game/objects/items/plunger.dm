/obj/item/clothing/plunger
	name = "plunger"
	desc = "This is possibly the least sanitary object around."
	icon_state = "plunger_black"
	icon = 'icons/obj/plunger.dmi'
	attack_verb = list("plunged")
	force = 1
	w_class = 3
	slot_flags = SLOT_HEAD | SLOT_MASK
	flags = NOSLIP
	climbing_effectiveness = 0.5 // You need shoes and feet both to be able to climb even easy surfaces.
	hitsound = 'sound/effects/plunger.ogg'

	var/taped = FALSE
	var/doubled = FALSE

/obj/item/clothing/plunger/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/tape_roll))
		if(taped)
			to_chat(user, "<span class='warning'>\The [src] already has tape wrapped around it.</span>")
			return
		visible_message("<span class='notice'\The [user] wraps some tape around \the [src].</span>")
		taped = TRUE
		update_icon()
	else if(thing.iswirecutter() && taped)
		visible_message("<span class='notice'\The [user] snips the tape from \the [src].</span>")
		taped = FALSE
		if(doubled)
			doubled = FALSE
			for(var/obj/item/clothing/plunger/P in contents)
				P.forceMove(get_turf(src))
		update_state()
	else if(istype(thing, /obj/item/clothing/plunger) && !doubled)
		if(!taped)
			to_chat(user, "<span class='warning'>\The [src] needs some tape to secure \the [thing], first.</span>")
			return
		user.drop_from_inventory(thing)
		thing.forceMove(src)
		doubled = TRUE
		visible_message("<span class='notice'\The [user] attaches a second plunger to \the [src].</span>")
		update_state()
	else
		. = ..()

/obj/item/clothing/plunger/update_icon()
	icon_state = initial(icon_state)
	if(doubled)
		icon_state += "_doubled"
	else if(taped)
		icon_state += "_taped"

/obj/item/clothing/plunger/proc/update_state()
	name = initial(name)
	gender = NEUTER
	slot_flags = initial(slot_flags)
	if(doubled)
		name += "s"
		gender = PLURAL
		slot_flags |= SLOT_GLOVES|SLOT_FEET
	var/mob/living/carbon/human/H = loc
	if(istype(H) && ((H.gloves == src && !(slot_flags & SLOT_GLOVES)) || (H.shoes == src && !(slot_flags & SLOT_FEET))))
		H.drop_from_inventory(src)
	update_icon()


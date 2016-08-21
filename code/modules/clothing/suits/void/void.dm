/obj/item/clothing/suit/voidsuit
	name = "voidsuit"
	icon_state = "void"
	item_state = "void"
	desc = "A high-tech dark red environment suit."
	slowdown = 1
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 20)
	allowed = list(/obj/item/flashlight,/obj/item/tank)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list("Human", "Skrell")

	//Breach thresholds, should ideally be inherited by most (if not all) voidsuits.
	//With 0.2 resiliance, will reach 10 breach damage after 3 laser carbine blasts or 8 smg hits.
	breach_threshold = 18
	can_breach = 1

	//Inbuilt devices.
	var/obj/item/clothing/shoes/boots = null            // Deployable boots, if any.
	var/obj/item/clothing/head/voidsuit/helmet = null   // Deployable helmet, if any.

/obj/item/clothing/suit/voidsuit/examine(user)
	..(user)
	var/list/part_list = new
	for(var/obj/item/I in list(helmet,boots))
		part_list += "\a [I]"
	user << "\The [src] has [english_list(part_list)] installed."

/obj/item/clothing/suit/voidsuit/refit_for_species(var/target_species)
	..()
	if(istype(helmet))
		helmet.refit_for_species(target_species)
	if(istype(boots))
		boots.refit_for_species(target_species)

/obj/item/clothing/suit/voidsuit/equipped(mob/M)
	..()

	var/mob/living/human/H = M

	if(!istype(H)) return

	if(H.wear_suit != src)
		return

	if(boots)
		if (H.equip_to_slot_if_possible(boots, slot_shoes))
			boots.canremove = 0

	if(helmet)
		if(H.head)
			M << "You are unable to deploy your suit's helmet as \the [H.head] is in the way."
		else if (H.equip_to_slot_if_possible(helmet, slot_head))
			M << "Your suit's helmet deploys with a hiss."
			helmet.canremove = 0

/obj/item/clothing/suit/voidsuit/dropped()
	..()

	var/mob/living/human/H

	if(helmet)
		helmet.canremove = 1
		H = helmet.loc
		if(istype(H))
			if(helmet && H.head == helmet)
				H.drop_from_inventory(helmet)
				helmet.forceMove(src)

	if(boots)
		boots.canremove = 1
		H = boots.loc
		if(istype(H))
			if(boots && H.shoes == boots)
				H.drop_from_inventory(boots)
				boots.forceMove(src)

/obj/item/clothing/suit/voidsuit/verb/toggle_helmet()

	set name = "Toggle Helmet"
	set category = "Object"
	set src in usr

	if(!istype(src.loc,/mob/living)) return

	if(!helmet)
		usr << "There is no helmet installed."
		return

	var/mob/living/human/H = usr

	if(!istype(H)) return
	if(H.stat) return
	if(H.wear_suit != src) return

	if(H.head == helmet)
		H << "<span class='notice'>You retract your suit helmet.</span>"
		helmet.canremove = 1
		H.drop_from_inventory(helmet)
		helmet.forceMove(src)
	else
		if(H.head)
			H << "<span class='danger'>You cannot deploy your helmet while wearing \the [H.head].</span>"
			return
		if(H.equip_to_slot_if_possible(helmet, slot_head))
			helmet.pickup(H)
			helmet.canremove = 0
			H << "<span class='info'>You deploy your suit helmet, sealing you off from the world.</span>"

/obj/item/clothing/suit/voidsuit/attackby(obj/item/W as obj, mob/user as mob)

	if(!istype(user,/mob/living)) return

	if(istype(W,/obj/item/clothing/accessory) || istype(W, /obj/item/hand_labeler))
		return ..()

	if(istype(src.loc,/mob/living))
		user << "<span class='warning'>You cannot modify \the [src] while it is being worn.</span>"
		return

	if(istype(W,/obj/item/screwdriver))
		if(helmet || boots)
			var/choice = input("What component would you like to remove?") as null|anything in list(helmet,boots)
			if(!choice) return

			if(choice == helmet)
				user << "You detatch \the [helmet] from \the [src]'s helmet mount."
				helmet.forceMove(get_turf(src))
				src.helmet = null
			else if(choice == boots)
				user << "You detatch \the [boots] from \the [src]'s boot mounts."
				boots.forceMove(get_turf(src))
				src.boots = null
		else
			user << "\The [src] does not have anything installed."
		return
	else if(istype(W,/obj/item/clothing/head/voidsuit))
		if(helmet)
			user << "\The [src] already has a helmet installed."
		else
			user << "You attach \the [W] to \the [src]'s helmet mount."
			user.drop_item()
			W.forceMove(src)
			src.helmet = W
		return
	else if(istype(W,/obj/item/clothing/shoes))
		if(boots)
			user << "\The [src] already has boots installed."
		else
			user << "You attach \the [W] to \the [src]'s boot mounts."
			user.drop_item()
			W.forceMove(src)
			boots = W
		return
	..()


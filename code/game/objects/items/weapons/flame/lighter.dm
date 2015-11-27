/////////
//ZIPPO//
/////////
/obj/item/weapon/flame/lighter
	name = "cheap lighter"
	desc = "A cheap-as-free lighter."
	icon = 'icons/obj/items.dmi'
	icon_state = "lighter-g"
	item_state = "lighter-g"
	w_class = 1
	throwforce = 4
	flags = CONDUCT
	slot_flags = SLOT_BELT
	attack_verb = list("burnt", "singed")
	var/base_state

/obj/item/weapon/flame/lighter/zippo
	name = "\improper Zippo lighter"
	desc = "The zippo."
	icon_state = "zippo"
	item_state = "zippo"

/obj/item/weapon/flame/lighter/random
	New()
		icon_state = "lighter-[pick("r","c","y","g")]"
		item_state = icon_state
		base_state = icon_state

/obj/item/weapon/flame/lighter/attack_self(mob/living/user)
	if(!base_state)
		base_state = icon_state
	if(user.r_hand == src || user.l_hand == src)
		if(!lit)
			lit = 1
			icon_state = "[base_state]on"
			item_state = "[base_state]on"
			if(istype(src, /obj/item/weapon/flame/lighter/zippo) )
				user.visible_message("<span class='rose'>Without even breaking stride, [user] flips open and lights [src] in one smooth movement.</span>")
			else
				if(prob(95))
					user.visible_message("<span class='notice'>After a few attempts, [user] manages to light the [src].</span>")
				else
					user << "<span class='warning'>You burn yourself while lighting the lighter.</span>"
					if (user.l_hand == src)
						user.apply_damage(2,BURN,"l_hand")
					else
						user.apply_damage(2,BURN,"r_hand")
					user.visible_message("<span class='notice'>After a few attempts, [user] manages to light the [src], they however burn their finger in the process.</span>")

			set_light(2)
			processing_objects.Add(src)
		else
			lit = 0
			icon_state = "[base_state]"
			item_state = "[base_state]"
			if(istype(src, /obj/item/weapon/flame/lighter/zippo) )
				user.visible_message("<span class='rose'>You hear a quiet click, as [user] shuts off [src] without even looking at what they're doing.</span>")
			else
				user.visible_message("<span class='notice'>[user] quietly shuts off the [src].</span>")

			set_light(0)
			processing_objects.Remove(src)
	else
		return ..()
	return


/obj/item/weapon/flame/lighter/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M, /mob))
		return
	M.IgniteMob()

	if(istype(M.wear_mask, /obj/item/clothing/mask/smokable/cigarette) && user.zone_sel.selecting == "mouth" && lit)
		var/obj/item/clothing/mask/smokable/cigarette/cig = M.wear_mask
		if(M == user)
			cig.attackby(src, user)
		else
			if(istype(src, /obj/item/weapon/flame/lighter/zippo))
				cig.light("<span class='rose'>[user] whips the [name] out and holds it for [M].</span>")
			else
				cig.light("<span class='notice'>[user] holds the [name] out for [M], and lights the [cig.name].</span>")
	else
		..()

/obj/item/weapon/flame/lighter/process()
	var/turf/location = get_turf(src)
	if(location)
		location.hotspot_expose(700, 5)
	return

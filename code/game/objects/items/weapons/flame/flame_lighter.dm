/////////
//ZIPPO//
/////////
/obj/item/flame/lighter
	name = "cheap lighter"
	desc = "A cheap-as-free lighter."
	icon = 'icons/obj/items.dmi'
	icon_state = "lighter-g"
	item_state = "lighter-g"
	slot_flags = SLOT_BELT
	one_use = FALSE
	fuel = 1

	var/light_prob = 95
	var/base_state

/obj/item/flame/lighter/Initialize()
	set_base_state()
	icon_state = base_state
	item_state = base_state
	. = ..()

/obj/item/flame/lighter/proc/set_base_state()
	base_state = icon_state

/obj/item/flame/lighter/use_fuel()
	fuel = 1 // Fuel never runs out (currently)

/obj/item/flame/lighter/attack_self(mob/living/user)
	if(lit)
		extinguish(user)
	else
		light()

/obj/item/flame/lighter/update_icon()
	if(lit)
		icon_state = "[base_state]on"
	else
		icon_state = base_state
	item_state = icon_state

/obj/item/flame/lighter/light(var/flavour_text)
	if(!lit)
		var/mob/living/user = usr
		if(!istype(user))
			..(flavour_text)
		else
			if(prob(light_prob))
				do_lit_message(usr)
				..(null)
			else
				if(user.l_hand == src) user.apply_damage(2,BURN, user.l_hand == src ? BP_L_HAND : BP_R_HAND)
				..("After a few attempts, \the [user] manages to light \the [src], burning their finger in the process.")

/obj/item/flame/lighter/extinguish(var/mob/user)
	. = ..()
	if(!lit && user)
		do_extinguished_message(user)

/obj/item/flame/lighter/proc/do_extinguished_message(var/mob/user)
	if(!lit && user)
		user.visible_message("<span class='notice'>\The [user] quietly shuts off \the [src].</span>")

/obj/item/flame/lighter/proc/do_lit_message(var/mob/user)
	if(lit && user)
		user.visible_message("After a few attempts, \the [user] manages to light \the [src].")

/obj/item/flame/lighter/proc/do_cig_lit_message(var/mob/user, var/mob/target, var/obj/item/clothing/mask/smokable/cigarette/cig)
	cig.light("<span class='notice'>\The [user] holds the [name] out for \the [target], and lights \the [cig].</span>")

/obj/item/flame/lighter/attack(var/mob/living/M, var/mob/user)
	if(lit && istype(M))
		M.IgniteMob()
		if(istype(M.wear_mask, /obj/item/clothing/mask/smokable/cigarette) && user.zone_sel.selecting == BP_MOUTH)
			var/obj/item/clothing/mask/smokable/cigarette/cig = M.wear_mask
			if(M == user)
				cig.attackby(src, user)
			else
				do_cig_lit_message(user, M, M.wear_mask)
		return
	. = ..()

/obj/item/flame/lighter/zippo
	name = "\improper Zippo lighter"
	desc = "The zippo."
	icon_state = "zippo"
	item_state = "zippo"
	light_prob = 100

/obj/item/flame/lighter/zippo/do_extinguished_message(var/mob/user)
	if(!lit && user)
		user.visible_message("<span class='rose'>You hear a quiet click as \the [user] shuts off \the [src] without even looking at what they're doing.</span>")

/obj/item/flame/lighter/zippo/do_lit_message(var/mob/user)
	if(lit && user)
		user.visible_message("<span class='rose'>Without even breaking stride, \the [user] flips open and lights \the [src] in one smooth movement.</span>")

/obj/item/flame/lighter/zippo/do_cig_lit_message(var/mob/user, var/mob/target, var/obj/item/clothing/mask/smokable/cigarette/cig)
	cig.light("<span class='rose'>\The [user] whips out \the [src] and holds it for \the [target], lighting \the [cig].</span>")

/obj/item/flame/lighter/random/set_base_state()
	base_state = "lighter-[pick("r","c","y","g")]"

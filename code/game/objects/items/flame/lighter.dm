/////////
//ZIPPO//
/////////
/obj/item/flame/lighter
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
	light_range = 1
	light_power = 2
	light_color = "#FF6600"
	var/base_state

/obj/item/flame/lighter/light()
	if(!..())
		return 0
	set_light()
	return 1

/obj/item/flame/lighter/die()
	if(!..())
		return 0
	kill_light()
	return 1


/obj/item/flame/lighter/proc/do_lit_message(var/mob/living/user)
	playsound(src.loc, 'sound/items/lighter_on.ogg', 25, 1)
	if(prob(95))
		user.visible_message("<span class='notice'>After a few attempts, \the [user] manages to light \the [src].</span>")
		return
	user << "<span class='danger'>You burn yourself while lighting the lighter.</span>"
	if(user.l_hand == src)
		user.apply_damage(2,BURN,"l_hand")
	else
		user.apply_damage(2,BURN,"r_hand")
	user.visible_message("<span class='danger'>\The [user] manages to light \the [src], burning their finger in the process.</span>")


/obj/item/flame/lighter/proc/do_snuff_message(var/mob/user)
	user.visible_message("<span class='notice'>\The [user] shuts off \the [src].</span>")
	playsound(src.loc, 'sound/items/lighter_off.ogg', 25, 1)

/obj/item/flame/lighter/update_icon()
	if(!base_state)
		base_state = icon_state
	if(lit)
		icon_state = "[base_state]on"
		item_state = "[base_state]on"
	else
		icon_state = "[base_state]"
		item_state = "[base_state]"

/obj/item/flame/lighter/attack_self(var/mob/living/user)
	if(!lit)
		if(light())
			do_lit_message(user)
			return
	else
		if(die())
			do_snuff_message(user)
			return
	return ..()

/obj/item/stack/flag
	name = "flags"
	desc = "Some colourful flags."
	singular_name = "flag"
	amount = 10
	max_amount = 10
	icon = 'icons/obj/flags.dmi'
	var/upright = FALSE
	var/base_state

/obj/item/stack/flag/New()
	..()
	base_state = icon_state

/obj/item/stack/flag/red
	name = "red flags"
	singular_name = "red flag"
	icon_state = "redflag"

/obj/item/stack/flag/yellow
	name = "yellow flags"
	singular_name = "yellow flag"
	icon_state = "yellowflag"

/obj/item/stack/flag/green
	name = "green flags"
	singular_name = "green flag"
	icon_state = "greenflag"

/obj/item/stack/flag/attack_hand(var/mob/user)
	if(upright)
		upright = FALSE
		icon_state = base_state
		anchored = FALSE
		src.visible_message("<span class='danger'>\The [user] knocks down \the [src].</span>")
		return
	. = ..()

/obj/item/stack/flag/attack_self(var/mob/user)

	var/turf/T = get_turf(src)
	if(!T)
		to_chat(user, "<span class='warning'>The flag won't stand up in this terrain.</span>")
		return

	var/obj/item/stack/flag/F = locate() in T
	if(F && F.upright)
		to_chat(user, "<span class='warning'>There is already a flag here.</span>")
		return

	var/obj/item/stack/flag/newflag = new src.type(T, amount = 1)
	newflag.upright =     TRUE
	newflag.anchored =    TRUE
	newflag.name =        newflag.singular_name
	newflag.icon_state = "[newflag.base_state]_open"
	newflag.visible_message("<span class='notice'>\The [user] plants \the [newflag] firmly.</span>")
	src.use(1)
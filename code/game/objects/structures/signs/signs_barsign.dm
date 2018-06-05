/obj/structure/sign/barsign
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "Off"
	appearance_flags = 0
	anchored = 1
	pixel_x = -32
	pixel_y = -32
	default_pixel_x = -32
	default_pixel_y = -32
	light_power = 6
	light_range = 5
	light_color = "#FF55FF"
	var/list/valid_states

/obj/structure/sign/barsign/New()
	valid_states = icon_states(icon)
	..()

/obj/structure/sign/barsign/examine(mob/user)
	..()
	switch(icon_state)
		if("Off")
			to_chat(user, "It appears to be switched off.")
		if("Blank")
			to_chat(user, "The lights are on, but there's no picture.")
		else
			to_chat(user, "It says '[icon_state]'")

/obj/structure/sign/barsign/Initialize()
	. = ..()
	icon_state = pick(valid_states - "Off")
	set_light()

/obj/structure/sign/barsign/dismount()
	anchored = FALSE

/obj/structure/sign/barsign/attackby(var/obj/item/I, var/mob/user)

	if(!anchored && I.isscrewdriver())
		anchored = TRUE
		to_chat(user, "<span class='notice'>You fasten \the [src] in place with \the [I].</span>")
		return

	var/obj/item/card/id/card = I.GetID()
	if(istype(card))
		if(access_bar in card.GetAccess())
			var/sign_type = input(user, "What would you like to change the barsign to?") as null|anything in valid_states
			if(!src || !sign_type || !user.Adjacent(src) || user.incapacitated())
				return
			icon_state = sign_type
			to_chat(user, "<span class='notice'>You change the barsign to '[icon_state]'.</span>")
			if(icon_state == "Off")
				kill_light()
			else
				set_light()
		else
			to_chat(user, "<span class='warning'>Access denied.</span>")
		return
	return ..()

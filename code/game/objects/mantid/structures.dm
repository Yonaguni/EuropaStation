/obj/structure/mantid
	icon = 'icons/obj/mantid.dmi'
	auto_init = 1

/obj/structure/mantid/initialize()
	..()
	if(light_power && light_range)
		set_light()

/obj/structure/mantid/proc/check_user(var/mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.species.get_bodytype(H) == "Mantid Alate" || H.species.get_bodytype(H) == "Mantid Gyne")
			return 1
	return 0

/obj/structure/mantid/light
	name = "light pod"
	icon_state = "light_on"
	light_power = 3
	light_range = 3
	light_color = "#00FFFF"
	anchored = 1
	density = 0

/obj/structure/mantid/light/proc/toggle(var/mob/user)
	if(light_obj)
		kill_light()
		icon_state = "light_off"
	else
		set_light()
		icon_state = "light_on"
	if(user)
		user.visible_message("<span class='notice'>\The [user] taps \the [src], and it [light_obj ? "brightens" : "goes dark"].</span>")

/obj/structure/mantid/light/attack_hand(var/mob/user)
	if(check_user(user))
		toggle(user)
		return
	. = ..()

/obj/structure/mantid/console
	name = "mantid console"
	icon_state = "console_on"
	light_power = 1
	light_range = 2
	light_color = "#00FFFF"
	anchored = 1
	density = 1

/obj/structure/mantid/door
	name = "composite airlock"
	icon_state = "door"
	anchored = 1
	density = 1
	opacity = 1

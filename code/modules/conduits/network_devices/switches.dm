/obj/structure/button/wall_switch
	name = "wall switch"
	desc = "It turns something on and off, probably."
	icon = 'icons/obj/structures/lightswitch.dmi'
	icon_state = "off"
	var/pushed = 0
	var/active = 1
	var/next_push = 0

/obj/structure/button/wall_switch/initialize()
	..()
	update_icon()

/obj/structure/button/wall_switch/interact()
	if(world.time < next_push)
		return
	next_push = world.time + button_delay
	if(active)
		pushed = !pushed
	update_icon()
	usr << "You switch \the [src] [icon_state][active ? "" : ", but nothing happens"]."

/obj/structure/button/wall_switch/update_icon()
	if(active)
		if(pushed)
			icon_state = "on"
		else
			icon_state = "off"
	else
		icon_state = "disabled"
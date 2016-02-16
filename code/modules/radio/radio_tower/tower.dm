/obj/machinery/radio_receiver
	name = "radio reciever"
	desc = "It's a placeholder!"
	icon = 'icons/obj/structures/radio_tower.dmi'
	icon_state = "tower_on"
	layer = 9.1 // Render over most things.

	// It's -big-.
	use_power = 1
	anchored = 1
	density = 1
	opacity = 1

	// -Really- big.
	pixel_x = -32
	bound_width = 96
	bound_height = 96
	bound_x = -32

	var/bluespace_relay                          // Will broadcast to all levels in universal_broadcast.
	var/datum/radio_net/net                      // Network for keeping track of all transmitters on a level.
	var/global/list/universal_broadcast = list() // Levels eligible for universal broadcast.

/obj/machinery/radio_receiver/attack_hand(var/mob/user)
	use_power = !use_power
	user.visible_message("<span class='notice'>\The [user] [use_power ? "switches on" : "shuts down"] \the [src].</span>")
	update_icon()

/obj/machinery/radio_receiver/update_icon()
	if(stat & BROKEN)
		icon_state = "tower_broken"
	else if(!use_power)
		icon_state = "tower_off"
	else
		icon_state = "tower_on"

/obj/machinery/radio_receiver/New()
	all_recievers += src
	..()

/obj/machinery/radio_receiver/initialize()
	if(!all_radio_nets["[z]"])
		net = new
		all_radio_nets["[z]"] = net
	else
		net = all_radio_nets["[z]"]
	net.towers += src

/obj/machinery/radio_receiver/Destroy()
	all_recievers -= src
	if(net)
		net.towers -= src
		net = null
	return ..()


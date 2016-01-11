/obj/structure/conduit/power
	name = "power cable"
	desc = "A length of heavy-duty power cabling."
	icon_state = "power_single"
	icon = 'icons/obj/europa/structures/conduits/power.dmi'
	feed_type = "power"
	feed_icon = "power"
	feed_layer = 1
	network_type = /datum/conduit_network/power
	color = "#FF0000"

	deconstruct_tool = /obj/item/weapon/wirecutters
	deconstruct_path = /obj/item/stack/conduit/power
	deconstruct_time = 0
	deconstruct_verb = "cut"
	deconstruct_adj = "cutting"
	deconstruct_sound = 'sound/items/Wirecutter.ogg'

/obj/structure/conduit/power
	name = "power cable"
	desc = "A length of heavy-duty power cabling."
	icon_state = "power_single"
	icon = 'icons/obj/structures/conduits/power.dmi'
	feed_type = "power"
	feed_icon = "power"
	feed_layer = 1
	network_type = /datum/conduit_network/power_net
	color = "#FF0000"

	deconstruct_tool = /obj/item/wirecutters
	deconstruct_path = /obj/item/stack/conduit/power
	deconstruct_time = 0
	deconstruct_verb = "cut"
	deconstruct_adj = "cutting"
	deconstruct_sound = 'sound/items/Wirecutter.ogg'

	var/list/machines = list()

/datum/conduit_network/power_net/proc/add_machine(var/obj/machinery/machine)
	machines |= machine

/datum/conduit_network/power_net/proc/lose_machine(var/obj/machinery/machine)
	machines -= machine

/datum/conduit_network/power_net/Destroy()
	for(var/obj/machinery/machine in machines)
		if(machine.power_network == src)
			machine.lose_power()
	machines.Cut()
	return ..()

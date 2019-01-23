/obj/machinery/commrelay
	name = "emergency comm relay"
	desc = "This relay punches messages across hundreds of light years! Wow!"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "bspacerelay"
	anchored = 1
	density = 1
	idle_power_usage = 15000

/obj/machinery/commrelay/on_update_icon()
	if(stat & (BROKEN|NOPOWER))
		icon_state = "[initial(icon_state)]_off"
	else
		icon_state = initial(icon_state)

/obj/machinery/commrelay/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/weapon/circuitboard/commrelay(src)
	component_parts += new /obj/item/weapon/stock_parts/manipulator(src)
	component_parts += new /obj/item/weapon/stock_parts/manipulator(src)
	component_parts += new /obj/item/weapon/stock_parts/subspace/filter(src)
	component_parts += new /obj/item/weapon/stock_parts/subspace/crystal(src)
	component_parts += new /obj/item/stack/cable_coil(src, 30)

/obj/machinery/commrelay/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(default_deconstruction_screwdriver(user, O))
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return

	..()
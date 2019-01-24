#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/circuitboard/smes
	name = T_BOARD("superconductive magnetic energy storage")
	build_path = /obj/machinery/power/smes/buildable
	board_type = "machine"
	req_components = list(/obj/item/weapon/smes_coil = 1, /obj/item/stack/cable_coil = 30)


/obj/item/weapon/circuitboard/batteryrack
	name = T_BOARD("battery rack PSU")
	build_path = /obj/machinery/power/smes/batteryrack
	board_type = "machine"
	req_components = list(/obj/item/weapon/stock_parts/capacitor/ = 3, /obj/item/weapon/stock_parts/matter_bin/ = 1)
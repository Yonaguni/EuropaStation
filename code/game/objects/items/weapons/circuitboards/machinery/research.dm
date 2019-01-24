#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif
/obj/item/weapon/circuitboard/autolathe
	name = T_BOARD("autolathe")
	build_path = /obj/machinery/autolathe
	board_type = "machine"
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 3,
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/circuitboard/ntnet_relay
	name = "Circuit board (NTNet Quantum Relay)"
	build_path = /obj/machinery/ntnet_relay
	board_type = "machine"
	req_components = list(
							/obj/item/stack/cable_coil = 15)
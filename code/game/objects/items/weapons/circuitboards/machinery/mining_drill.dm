#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/circuitboard/miningdrill
	name = T_BOARD("mining drill head")
	build_path = "/obj/machinery/mining/drill"
	board_type = "machine"
	req_components = list(
							"/obj/item/component/capacitor" = 1,
							"/obj/item/weapon/cell" = 1,
							"/obj/item/component/matter_bin" = 1,
							"/obj/item/component/micro_laser" = 1)
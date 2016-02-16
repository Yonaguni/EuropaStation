#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/circuitboard/bluespacerelay
	name = T_BOARD("bluespacerelay")
	build_path = "/obj/machinery/bluespacerelay"
	board_type = "machine"
	req_components = list(
							"/obj/item/stack/cable_coil" = 30,
							"/obj/item/component/manipulator" = 2,
							"/obj/item/component/subspace/filter" = 1,
							"/obj/item/component/subspace/crystal" = 1,
						  )
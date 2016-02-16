#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/circuitboard/unary_atmos
	board_type = "machine"

/obj/item/weapon/circuitboard/unary_atmos/construct(var/obj/machinery/atmospherics/unary/U)
	//TODO: Move this stuff into the relevant constructor when pipe/construction.dm is cleaned up.
	U.initialize()
	U.build_network()
	if (U.node)
		U.node.initialize()
		U.node.build_network()

/obj/item/weapon/circuitboard/unary_atmos/heater
	name = T_BOARD("gas heating system")
	build_path = "/obj/machinery/atmospherics/unary/heater"
	req_components = list(
							"/obj/item/stack/cable_coil" = 5,
							"/obj/item/component/matter_bin" = 1,
							"/obj/item/component/capacitor" = 2)

/obj/item/weapon/circuitboard/unary_atmos/cooler
	name = T_BOARD("gas cooling system")
	build_path = "/obj/machinery/atmospherics/unary/freezer"
	req_components = list(
							"/obj/item/stack/cable_coil" = 2,
							"/obj/item/component/matter_bin" = 1,
							"/obj/item/component/capacitor" = 2,
							"/obj/item/component/manipulator" = 1)

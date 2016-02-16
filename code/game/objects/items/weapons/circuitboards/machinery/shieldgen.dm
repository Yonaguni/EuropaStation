#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/circuitboard/shield_gen_ex
	name = T_BOARD("hull shield generator")
	board_type = "machine"
	build_path = "/obj/machinery/shield_gen/external"
	req_components = list(
							"/obj/item/component/manipulator/pico" = 2,
							"/obj/item/component/subspace/transmitter" = 1,
							"/obj/item/component/subspace/crystal" = 1,
							"/obj/item/component/subspace/amplifier" = 1,
							"/obj/item/component/console_screen" = 1,
							"/obj/item/stack/cable_coil" = 5)

/obj/item/weapon/circuitboard/shield_gen
	name = T_BOARD("bubble shield generator")
	board_type = "machine"
	build_path = "/obj/machinery/shield_gen"
	req_components = list(
							"/obj/item/component/manipulator/pico" = 2,
							"/obj/item/component/subspace/transmitter" = 1,
							"/obj/item/component/subspace/crystal" = 1,
							"/obj/item/component/subspace/amplifier" = 1,
							"/obj/item/component/console_screen" = 1,
							"/obj/item/stack/cable_coil" = 5)

/obj/item/weapon/circuitboard/shield_cap
	name = T_BOARD("shield capacitor")
	board_type = "machine"
	build_path = "/obj/machinery/shield_capacitor"
	req_components = list(
							"/obj/item/component/manipulator/pico" = 2,
							"/obj/item/component/subspace/filter" = 1,
							"/obj/item/component/subspace/treatment" = 1,
							"/obj/item/component/subspace/analyzer" = 1,
							"/obj/item/component/console_screen" = 1,
							"/obj/item/stack/cable_coil" = 5)

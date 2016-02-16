#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/circuitboard/telecomms
	board_type = "machine"

/obj/item/weapon/circuitboard/telecomms/receiver
	name = T_BOARD("subspace receiver")
	build_path = "/obj/machinery/telecomms/receiver"
	req_components = list(
							"/obj/item/component/subspace/ansible" = 1,
							"/obj/item/component/subspace/filter" = 1,
							"/obj/item/component/manipulator" = 2,
							"/obj/item/component/micro_laser" = 1)

/obj/item/weapon/circuitboard/telecomms/hub
	name = T_BOARD("hub mainframe")
	build_path = "/obj/machinery/telecomms/hub"
	req_components = list(
							"/obj/item/component/manipulator" = 2,
							"/obj/item/stack/cable_coil" = 2,
							"/obj/item/component/subspace/filter" = 2)

/obj/item/weapon/circuitboard/telecomms/relay
	name = T_BOARD("relay mainframe")
	build_path = "/obj/machinery/telecomms/relay"
	req_components = list(
							"/obj/item/component/manipulator" = 2,
							"/obj/item/stack/cable_coil" = 2,
							"/obj/item/component/subspace/filter" = 2)

/obj/item/weapon/circuitboard/telecomms/bus
	name = T_BOARD("bus mainframe")
	build_path = "/obj/machinery/telecomms/bus"
	req_components = list(
							"/obj/item/component/manipulator" = 2,
							"/obj/item/stack/cable_coil" = 1,
							"/obj/item/component/subspace/filter" = 1)

/obj/item/weapon/circuitboard/telecomms/processor
	name = T_BOARD("processor unit")
	build_path = "/obj/machinery/telecomms/processor"
	req_components = list(
							"/obj/item/component/manipulator" = 3,
							"/obj/item/component/subspace/filter" = 1,
							"/obj/item/component/subspace/treatment" = 2,
							"/obj/item/component/subspace/analyzer" = 1,
							"/obj/item/stack/cable_coil" = 2,
							"/obj/item/component/subspace/amplifier" = 1)

/obj/item/weapon/circuitboard/telecomms/server
	name = T_BOARD("telecommunication server")
	build_path = "/obj/machinery/telecomms/server"
	req_components = list(
							"/obj/item/component/manipulator" = 2,
							"/obj/item/stack/cable_coil" = 1,
							"/obj/item/component/subspace/filter" = 1)

/obj/item/weapon/circuitboard/telecomms/broadcaster
	name = T_BOARD("subspace broadcaster")
	build_path = "/obj/machinery/telecomms/broadcaster"
	req_components = list(
							"/obj/item/component/manipulator" = 2,
							"/obj/item/stack/cable_coil" = 1,
							"/obj/item/component/subspace/filter" = 1,
							"/obj/item/component/subspace/crystal" = 1,
							"/obj/item/component/micro_laser/high" = 2)

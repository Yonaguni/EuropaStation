#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/circuitboard/clonepod
	name = T_BOARD("clone pod")
	build_path = /obj/machinery/clonepod
	board_type = "machine"

	req_components = list(
							/obj/item/stack/cable_coil = 2,
							/obj/item/stock_parts/scanning_module = 2,
							/obj/item/stock_parts/manipulator = 2,
							/obj/item/stock_parts/console_screen = 1)

/obj/item/circuitboard/clonescanner
	name = T_BOARD("cloning scanner")
	build_path = /obj/machinery/dna_scannernew
	board_type = "machine"

	req_components = list(
							/obj/item/stock_parts/scanning_module = 1,
							/obj/item/stock_parts/manipulator = 1,
							/obj/item/stock_parts/micro_laser = 1,
							/obj/item/stock_parts/console_screen = 1,
							/obj/item/stack/cable_coil = 2)

/obj/item/circuitboard/resleever
	name = T_BOARD("neural lace resleever")
	build_path = /obj/machinery/resleever
	board_type = "machine"

	req_components = list(
							/obj/item/stack/cable_coil = 2,
							/obj/item/stock_parts/scanning_module = 1,
							/obj/item/stock_parts/manipulator = 3,
							/obj/item/stock_parts/console_screen = 1)
/obj/item/circuitboard/bioprinter
	name = T_BOARD("bioprinter")
	build_path = /obj/machinery/organ_printer/flesh
	board_type = "machine"

	req_components = list(
							/obj/item/healthanalyzer = 1,
							/obj/item/stock_parts/matter_bin = 2,
							/obj/item/stock_parts/manipulator = 2,
							)

/obj/item/circuitboard/roboprinter
	name = T_BOARD("prosthetic organ fabricator")
	build_path = /obj/machinery/organ_printer/robot
	board_type = "machine"

	req_components = list(
							/obj/item/stock_parts/matter_bin = 2,
							/obj/item/stock_parts/manipulator = 2,
							)
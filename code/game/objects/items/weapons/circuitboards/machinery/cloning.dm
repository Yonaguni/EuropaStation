#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

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
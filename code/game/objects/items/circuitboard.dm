//Define a macro that we can use to assemble all the circuit board names
#ifdef T_BOARD
#error T_BOARD already defined elsewhere, we can't use it.
#endif
#define T_BOARD(name)	"circuit board (" + (name) + ")"

/obj/item/weapon/circuitboard
	name = "circuit board"
	icon = 'icons/obj/module.dmi'
	icon_state = "id_mod"
	item_state = "electronic"
	density = 0
	anchored = 0
	w_class = 2.0
	flags = CONDUCT
	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 15
	var/build_path = null
	var/board_type = "computer"
	var/list/req_components = null
	var/contain_parts = 1

//Called when the circuitboard is used to contruct a new machine.
/obj/item/weapon/circuitboard/proc/construct(var/obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0

//Called when a computer is deconstructed to produce a circuitboard.
//Only used by computers, as other machines store their circuitboard instance.
/obj/item/weapon/circuitboard/proc/deconstruct(var/obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0

/obj/item/weapon/circuitboard/broken
	name = "broken electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics_smoked"
	board_type = "other"

/obj/item/weapon/circuitboard/smes
	name = T_BOARD("superconductive magnetic energy storage")
	build_path = "/obj/machinery/power/smes/buildable"
	board_type = "machine"
	req_components = list("/obj/item/weapon/smes_coil" = 1, "/obj/item/stack/conduit/power" = 30)

/obj/item/weapon/circuitboard/autolathe
	name = T_BOARD("autolathe")
	build_path = "/obj/machinery/fabricator"
	board_type = "machine"
	req_components = list(
							"/obj/item/component/matter_bin" = 3,
							"/obj/item/component/manipulator" = 1,
							"/obj/item/component/console_screen" = 1)

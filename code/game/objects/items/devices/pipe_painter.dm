/obj/item/pipe_painter
	name = "pipe painter"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "labeler1"
	item_state = "flight"
	var/list/modes
	var/mode

/obj/item/pipe_painter/New()
	..()
	modes = new()
	for(var/C in pipe_colors)
		modes += "[C]"
	mode = pick(modes)

/obj/item/pipe_painter/afterattack(atom/A, var/mob/user, proximity)
	if(!proximity)
		return

	if(!istype(A,/obj/machinery/atmospherics/pipe) || istype(A,/obj/machinery/atmospherics/pipe/tank) || istype(A,/obj/machinery/atmospherics/pipe/vent) || istype(A,/obj/machinery/atmospherics/pipe/simple/heat_exchanging) || !in_range(user, A))
		return
	var/obj/machinery/atmospherics/pipe/P = A

	P.change_color(pipe_colors[mode])

/obj/item/pipe_painter/attack_self(var/mob/user)
	mode = input("Which colour do you want to use?", "Pipe painter", mode) in modes

/obj/item/pipe_painter/examine(mob/user)
	..(user)
	user << "It is in [mode] mode."

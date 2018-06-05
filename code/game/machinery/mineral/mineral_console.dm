/obj/machinery/computer/mining
	name = "ore processing console"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"
	light_color = "#b88b2e"
	req_access = list(access_cargo)
	var/datum/console_program/control_system = /datum/console_program/mining

/obj/machinery/computer/mining/Initialize()
	if(ispath(control_system))
		control_system = new control_system(src)
	. = ..()

/obj/machinery/computer/mining/attack_ai(var/mob/user)
	return attack_hand(user)

/obj/machinery/computer/mining/attack_hand(var/mob/user)
	interact(user)

/obj/machinery/computer/mining/interact(user)
	if(!istype(user, /mob/living/silicon))
		playsound(loc, 'sound/effects/keyboard.ogg', 50)
	control_system.Run(user)

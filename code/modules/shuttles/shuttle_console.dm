/obj/machinery/computer/shuttle_control
	name = "shuttle control console"
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "atmos_key"
	icon_screen = "shuttle"
	circuit = null

	var/datum/console_program/shuttle/control_system = /datum/console_program/shuttle
	var/shuttle_tag  // Used to coordinate data in shuttle controller.
	var/hacked = 0   // Has been emagged, no access restrictions.

/obj/machinery/computer/shuttle_control/Initialize()
	if(ispath(control_system))
		control_system = new control_system(src, shuttle_tag)
	. = ..()

/obj/machinery/computer/shuttle_control/process()
	. = ..()
	if(istype(control_system))
		control_system.Process()

/obj/machinery/computer/shuttle_control/attack_hand(user as mob)
	if(..(user))
		return
	if(!allowed(user))
		to_chat(user, "<span class='warning'>Access denied.</span>")
		return 1
	interact(user)

/obj/machinery/computer/shuttle_control/interact(user)
	if(!istype(user, /mob/living/silicon))
		playsound(loc, 'sound/effects/keyboard.ogg', 50)
	control_system.Run(user)

/obj/machinery/computer/shuttle_control/Topic(href, href_list)
	if(..())
		return 1

	handle_topic_href(shuttle_controller.shuttles[shuttle_tag], href_list)

/obj/machinery/computer/shuttle_control/emag_act(var/remaining_charges, var/mob/user)
	if (!hacked)
		req_access = list()
		req_one_access = list()
		hacked = 1
		to_chat(user, "You short out the console's ID checking system. It's now available to everyone!")
		return 1

/obj/machinery/computer/shuttle_control/bullet_act(var/obj/item/projectile/Proj)
	visible_message("\The [Proj] ricochets off \the [src]!")
	Proj.on_hit(src, 0)

/obj/machinery/computer/shuttle_control/ex_act()
	return

/obj/machinery/computer/shuttle_control/emp_act()
	return

/obj/machinery/computer/shuttle_control/proc/handle_topic_href(var/datum/shuttle/autodock/shuttle, var/list/href_list)
	if(!istype(shuttle) || !CanInteract(usr, default_state))
		return
	if(href_list["move"])
		if(!shuttle.next_location.is_valid(shuttle))
			to_chat(usr, "<span class='warning'>Destination zone is invalid or obstructed.</span>")
			return
		shuttle.launch(src)
	else if(href_list["force"])
		shuttle.force_launch(src)
	else if(href_list["cancel"])
		shuttle.cancel_launch(src)
	else if(shuttle.multiple_destinations && href_list["pick"])
		var/datum/shuttle/autodock/multi/ashuttle = shuttle
		var/dest_key = input("Choose shuttle destination", "Shuttle Destination") as null|anything in ashuttle.destinations
		if(CanInteract(usr, default_state))
			ashuttle.set_destination(dest_key, usr)
	else if(shuttle.can_cloak && href_list["toggle_cloaked"])
		var/datum/shuttle/autodock/multi/antag/ashuttle = shuttle
		ashuttle.cloaked = !ashuttle.cloaked
	ui_interact(usr)

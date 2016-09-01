var/console_count = 0

/obj/machinery/console
	name = "terminal"
	desc = "A computer terminal. Very 2100-chic."
	icon = 'icons/obj/machines/consoles.dmi'
	icon_state = "console"
	is_data_console = 1
	light_type = LIGHT_SOFT_FLICKER

	var/list/installed_software = list()
	var/global/list/default_software = list(
		/datum/console_program/main_menu,
		/datum/console_program/server_login
		)
	var/on = 1

/obj/machinery/console/Destroy()
	for(var/module in installed_software)
		qdel(installed_software[module])
	installed_software.Cut()
	if(data_network)
		data_network.connected_consoles -= src
	return ..()

/obj/machinery/console/initialize()
	..()
	if(name == "terminal")
		name = "terminal (#[++console_count])"
	for(var/module_type in default_software)
		var/datum/console_program/module = new module_type(src)
		installed_software[module.name] = module

	for(var/i in installed_software)
		var/datum/console_program/P = installed_software[i]
		if(istype(P))
			P.initialize()

	set_light(2,5,"#006600")

/obj/machinery/console/attack_hand(var/mob/user)
	interact(user)

/obj/machinery/console/interact(var/mob/user)
	if(!data_network)
		find_data_network()

	var/datum/console_program/program = installed_software["Main Menu"]
	if(istype(program))
		program.Run(user)

/*
/obj/machinery/console/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	var/mob/user = locate(href_list["remote_connection_user"])
	if(href_list["remote_connection"])
		var/obj/machinery/E = locate(href_list["remote_connection"])
		if(istype(E) && istype(user))
			E.interact(user)

	if(href_list["remote_pulse"])
		var/obj/machinery/E = locate(href_list["remote_pulse"])
		if(istype(E) && istype(user))
			E.pulsed(user)

	if(href_list["toggle_show"])
		var/datum/console_module/module = installed_software[href_list["toggle_show"]]
		module.visible = !module.visible

	updateUsrDialog()
*/

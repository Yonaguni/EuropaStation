var/console_count = 0

/obj/machinery/console
	name = "terminal"
	desc = "A computer terminal. Very 2100-chic."
	icon = 'icons/obj/machines/consoles.dmi'
	icon_state = "console"
	is_data_console = 1
	light_type = LIGHT_SOFT_FLICKER

	var/mob/cur_user
	var/datum/console_program/cur_program
	var/startup_program = "Main Menu"

	var/list/installed_software = list()
	var/global/list/default_software = list(
		/datum/console_program/message_board_browser,
		/datum/console_program/message_board_posts,
		/datum/console_program/main_menu
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

	cur_program = installed_software[startup_program]

	set_light(2,5,"#006600")

/obj/machinery/console/attack_hand(var/mob/user)
	interact(user)

/obj/machinery/console/interact(var/mob/user)
	if(!data_network)
		find_data_network()

	cur_user = user
	OpenTerminal()

/obj/machinery/console/proc/SwitchProgram(var/prog)
	var/datum/console_program/program = installed_software[prog]
	if(!istype(program))
		return

	cur_program = program

	OpenTerminal()

/obj/machinery/console/proc/OpenTerminal()
	if(!cur_user)
		return

	PushCommonAssets()
	cur_user << browse(cur_program.html_template, "window=\ref[src];size=800x600;can_resize=0")

	sleep(30)

	cur_program.Run()

	//Push the starting page, row-by-row to the browser, using the replaceRow javascript function - I couldn't get an array push to work
	for(var/i = 1 to cur_program.html.len)
		cur_user << output(list2params(list("[i]", cur_program.html[i])), "\ref[src].browser:replaceRow")

/obj/machinery/console/proc/PushCommonAssets()
	cur_user << browse('html/css/terminal.css', "display=0")
	cur_user << browse('html/js/terminalFunctions.js', "display=0")
	cur_user << browse('html/images/terminal_bg.png', "display=0")

/obj/machinery/console/Topic(href, href_list[])
	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	cur_program.HandleTopic(href_list)

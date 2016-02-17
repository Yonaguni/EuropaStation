var/console_count = 0

/obj/machinery/datanet/console
	name = "terminal"
	desc = "A computer terminal. Very 2100-chic."
	icon = 'icons/obj/machines/consoles.dmi'
	icon_state = "console"
	is_data_console = 1
	light_flicker = 1
	light_hard = 0

	var/list/installed_software = list()
	var/global/list/default_software = list(
		/datum/console_module/configuration,
		/datum/console_module/basic_interface,
		/datum/console_module/sensor_data
		)
	var/on = 1

/obj/machinery/datanet/console/Destroy()
	for(var/module in installed_software)
		qdel(installed_software[module])
	installed_software.Cut()
	if(data_network)
		data_network.connected_consoles -= src
	return ..()

/obj/machinery/datanet/console/initialize()
	..()
	if(name == "terminal")
		name = "terminal (#[++console_count])"
	for(var/module_type in default_software)
		var/datum/console_module/module = new module_type(src)
		installed_software[module.name] = module
	set_light(2,5,"#006600")

/obj/machinery/datanet/console/attack_hand(var/mob/user)
	interact(user)

/obj/machinery/datanet/console/interact(var/mob/user)

	if(!data_network)
		find_data_network()

	var/dat = "<body bgcolor='#101010'><font color='#00FF00' size=2 face='fixedsys'><center>[capitalize(name)]</center>"

	dat += "<br>============================<br>"

	if(data_network)
		dat += "<br><b>\The [src] is connected to [data_network].</b><br>"
	else
		dat += "<br>\The [src] is not connected to a network.<br>"

	dat += "<br>============================<br>"

	if(installed_software.len)
		for(var/module in installed_software)
			var/datum/console_module/smodule = installed_software[module]
			dat += "<br>[smodule.get_header()] \[<a href='?src=\ref[src];toggle_show=[module]'>show/hide</a>\]<br>"
			if(smodule.visible)
				dat += "<br>[smodule.get_interface_data(user)]"
	else
		dat += "No software modules installed, please contact your hardware vendor.<br>"

	dat += "<br>============================</font></body>"

	user << browse(dat, "window=term_[name]")
	onclose(user, "window=term_[name]")

/obj/machinery/datanet/console/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	var/mob/user = locate(href_list["remote_connection_user"])
	if(href_list["remote_connection"])
		var/obj/machinery/datanet/E = locate(href_list["remote_connection"])
		if(istype(E) && istype(user))
			E.interact(user)

	if(href_list["remote_pulse"])
		var/obj/machinery/datanet/E = locate(href_list["remote_pulse"])
		if(istype(E) && istype(user))
			E.pulsed(user)

	if(href_list["toggle_show"])
		var/datum/console_module/module = installed_software[href_list["toggle_show"]]
		module.visible = !module.visible

	updateUsrDialog()

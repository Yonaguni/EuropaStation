var/console_count = 0

/obj/machinery/europa/console
	name = "terminal"
	desc = "A computer terminal. Very 2100-chic."
	icon = 'icons/obj/europa/machines/consoles.dmi'
	icon_state = "console"
	is_data_console = 1

	var/show_terminals = 1
	var/show_machines = 1
	var/show_sensors = 1

	var/on = 1

/obj/machinery/europa/console/initialize()
	..()
	if(name == "terminal")
		name = "terminal (#[++console_count])"

/obj/machinery/europa/console/attack_hand(var/mob/user)
	interact(user)

/obj/machinery/europa/console/interact(var/mob/user)

	if(!data_network)
		find_data_network()

	var/dat = "<body bgcolor='#101010'><font color='#00FF00' size=2 face='fixedsys'><center>[capitalize(name)]</center>"

	dat += "<br><br>============================================================<br><br>"
	if(data_network)
		dat += "<b>\The [src] is connected to [data_network].</b><br>"

		dat += "<br>Connected console(s): [data_network.connected_consoles.len] \[<a href='?src=\ref[src];toggle_show_consoles=1'>show/hide</a>\]<br>"
		if(show_terminals)
			if(data_network.connected_consoles.len)
				for(var/obj/thing in data_network.connected_consoles)
					dat += "- <a href='?src=\ref[src];remote_connection=\ref[thing];remote_connection_user=\ref[user]'>\the [thing]</a><br>"
			else
				dat += "None."
			dat += "<br>"

		dat += "<br>Connected machine(s): [data_network.connected_machines.len] \[<a href='?src=\ref[src];toggle_show_machines=1'>show/hide</a>\]<br>"
		if(show_machines)
			if(data_network.connected_machines.len)
				for(var/obj/machinery/europa/thing in data_network.connected_machines)
					dat += "- "
					if(thing.can_remote_connect)
						dat += "<a href='?src=\ref[src];remote_connection=\ref[thing];remote_connection_user=\ref[user]'>\the [thing]</a>"
					else
						dat += "\the [thing]"
					if(thing.can_remote_trigger)
						dat += " <a href='?src=\ref[src];remote_pulse=\ref[thing];remote_connection_user=\ref[user]'>\[activate\]</a>"
					dat += "<br>"

			else
				dat += "None."
			dat += "<br>"

		dat += "<br>Connected sensor(s): [data_network.connected_sensors.len] \[<a href='?src=\ref[src];toggle_show_sensors=1'>show/hide</a>\]<br>"
		if(show_sensors)
			if(data_network.connected_sensors.len)
				for(var/obj/structure/europa/sensor/sensor in data_network.connected_sensors)
					dat += "<b>- [sensor.report_name]:</b><br>"
					var/list/sensor_data = sensor.get_sensor_data()
					for(var/sdata in sensor_data)
						dat += "---- [sdata]: [sensor_data[sdata]]<br>"
			else
				dat += "None."
			dat += "<br>"
	else
		dat += "\The [src] is not connected to a network.<br>"
	dat += "<br>============================================================</font></body>"

	user << browse(dat, "window=et_[name]")
	onclose(user, "europa_terminal")

/obj/machinery/europa/console/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	var/mob/user = locate(href_list["remote_connection_user"])
	if(href_list["remote_connection"])
		var/obj/machinery/europa/E = locate(href_list["remote_connection"])
		if(istype(E) && istype(user))
			E.interact(user)

	if(href_list["remote_pulse"])
		var/obj/machinery/europa/E = locate(href_list["remote_pulse"])
		if(istype(E) && istype(user))
			E.pulsed(user)

	if(href_list["toggle_show_consoles"])
		show_terminals = !show_terminals
	if(href_list["toggle_show_machines"])
		show_machines = !show_machines
	if(href_list["toggle_show_sensors"])
		show_sensors = !show_sensors

	updateUsrDialog()

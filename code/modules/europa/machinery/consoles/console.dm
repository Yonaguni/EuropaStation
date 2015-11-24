var/console_count = 0

/obj/machinery/europa/console
	name = "terminal"
	desc = "A computer terminal. Very 2100-chic."
	icon = 'icons/obj/europa/machines/consoles.dmi'
	icon_state = "console"
	anchored = 1
	density = 1
	is_data_console = 1

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
		if(data_network.connected_consoles.len)
			dat += "<br>[data_network.connected_consoles.len] console(s):<br>"
			for(var/obj/thing in data_network.connected_consoles)
				dat += "- <a href='?src=\ref[src];remote_connection=\ref[thing];remote_connection_user=\ref[user]'>\the [thing]</a><br>"
			dat += "<br>"
		if(data_network.connected_machines.len)
			dat += "<br>[data_network.connected_machines.len] machine(s):<br>"
			for(var/obj/thing in data_network.connected_machines)
				dat += "- <a href='?src=\ref[src];remote_connection=\ref[thing];remote_connection_user=\ref[user]'>\the [thing]</a><br>"
			dat += "<br>"
		if(data_network.connected_sensors.len)
			dat += "<br>[data_network.connected_sensors.len] sensor(s):<br>"
			for(var/obj/structure/europa/sensor/sensor in data_network.connected_sensors)
				dat += "<b>- \the [sensor]:</b><br>"
				var/list/sensor_data = sensor.get_sensor_data()
				for(var/sdata in sensor_data)
					dat += "---- [sdata]: [sensor_data[sdata]]<br>"
			dat += "<br>"
	else
		dat += "\The [src] is not connected to a network.<br><br>"
	dat += "============================================================</font></body>"

	user << browse(dat, "window=europa_terminal")
	onclose(user, "europa_terminal")

/obj/machinery/europa/console/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["remote_connection"])
		var/obj/machinery/europa/E = locate(href_list["remote_connection"])
		var/mob/user = locate(href_list["remote_connection_user"])
		if(istype(E) && istype(user))
			E.interact(user)

	updateUsrDialog()

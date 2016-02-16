/datum/console_module
	var/name = "console software module"
	var/visible = 1
	var/obj/machinery/datanet/console/owner

/datum/console_module/New(var/obj/machinery/datanet/console/new_owner)
	if(!istype(new_owner))
		qdel(src)
		return
	owner = new_owner

/datum/console_module/Destroy()
	if(owner)
		owner.installed_software[name] = null
		owner.installed_software -= name
		owner = null
	return ..()

/datum/console_module/proc/get_header()
	return "[name]"

/datum/console_module/proc/get_interface_data(var/mob/user)
	return ""

/datum/console_module/configuration
	name = "system configuration"
	visible = 0

/datum/console_module/configuration/get_header()
	return "Aperture 12 release 122.8 (Final)<br>Kernel 6.x86_64 on an x86_64"

/datum/console_module/configuration/get_interface_data(var/mob/user)
	return "About<br>Configuration<br>Reboot<br>Shutdown<br>"

/datum/console_module/basic_interface
	name = "remote interface"

/datum/console_module/basic_interface/get_header()
	return "Connected machine(s): [owner.data_network ? owner.data_network.connected_machines.len : "NO CARRIER"]"

/datum/console_module/basic_interface/get_interface_data(var/mob/user)
	var/dat = ..()
	if(owner.data_network)
		if(owner.data_network.connected_machines.len)
			for(var/obj/machinery/datanet/thing in owner.data_network.connected_machines)
				dat += "- "
				if(thing.can_remote_connect)
					dat += "<a href='?src=\ref[owner];remote_connection=\ref[thing];remote_connection_user=\ref[user]'>\the [thing]</a>"
				else
					dat += "\the [thing]"
				if(thing.can_remote_trigger)
					dat += " <a href='?src=\ref[owner];remote_pulse=\ref[thing];remote_connection_user=\ref[user]'>\[activate\]</a>"
				dat += "<br>"
		else
			dat += "No compatible devices found.<br>"
	return dat

/datum/console_module/sensor_data
	name = "remote diagnostics"

/datum/console_module/sensor_data/get_header()
	return "Connected sensor(s): [owner.data_network ? owner.data_network.connected_sensors.len : "NO CARRIER"]"

/datum/console_module/sensor_data/get_interface_data()
	var/dat = ..()
	if(owner.data_network)
		if(owner.data_network.connected_sensors.len)
			for(var/obj/structure/sensor/sensor in owner.data_network.connected_sensors)
				dat += "<b>- [sensor.report_name]:</b><br>"
				var/list/sensor_data = sensor.get_sensor_data()
				for(var/sdata in sensor_data)
					dat += "---- [sdata]: [sensor_data[sdata]]<br>"
		else
			dat += "None.<br>"
	return dat
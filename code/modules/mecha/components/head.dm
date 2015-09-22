/obj/item/mech_component/sensors
	name = "head"
	pixel_y = -18
	icon_state = "loader_head"
	gender = NEUTER

	var/sight_flags = 0
	var/obj/item/robot_parts/robot_component/radio/radio
	var/obj/item/robot_parts/robot_component/camera/camera
	var/obj/item/mech_component/control_module/software
	has_hardpoints = list(HARDPOINT_HEAD)

/obj/item/mech_component/sensors/prebuild()
	radio = new(src)
	camera = new(src)

/obj/item/mech_component/sensors/ready_to_install()
	return (radio && camera)

/obj/item/mech_component/sensors/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing,/obj/item/robot_parts/robot_component/radio))
		if(radio)
			user << "<span class='warning'>\The [src] already has a radio installed.</span>"
			return
		radio = thing
		install_component(thing, user)
	if(istype(thing,/obj/item/robot_parts/robot_component/camera))
		if(camera)
			user << "<span class='warning'>\The [src] already has a camera installed.</span>"
			return
		camera = thing
		install_component(thing, user)
	else
		return ..()

/obj/item/mech_component/control_module
	name = "exosuit control module"
	var/list/installed_software = list()
	var/max_installed_software = 2
	icon_state = "internals"
	icon = 'icons/mecha/mech_part_items.dmi'
	pixel_x = 0

/obj/item/mech_component/control_module/attackby(var/obj/item/thing, var/mob/user)
	return
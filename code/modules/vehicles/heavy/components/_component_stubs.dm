/obj/item/broken_device
	name = "broken component"
	icon = 'icons/obj/robot_component.dmi'
	icon_state = "broken"

/obj/item/robot_parts/robot_component
	icon = 'icons/obj/robot_component.dmi'
	icon_state = "working"
	var/brute = 0
	var/burn = 0
	var/total_dam = 0
	var/max_dam = 30
	var/icon_state_broken = "broken"

/obj/item/robot_parts/robot_component/proc/take_damage(var/brute_amt, var/burn_amt)
	brute += brute_amt
	burn += burn_amt
	total_dam = brute+burn
	if(total_dam >= max_dam)
		var/obj/item/broken_device/BD = new(src.loc)
		BD.name = "broken [name]"
		return BD
	return 0

/obj/item/robot_parts/robot_component/proc/is_functional()
	return ((brute + burn) < max_dam)

/obj/item/robot_parts/robot_component/binary_communication_device
	name = "binary communication device"
	icon_state = "binradio"
	icon_state_broken = "binradio_broken"

/obj/item/robot_parts/robot_component/actuator
	name = "actuator"
	icon_state = "motor"
	icon_state_broken = "motor_broken"

/obj/item/robot_parts/robot_component/armour
	name = "armour plating"
	icon_state = "armor"
	icon_state_broken = "armor_broken"

/obj/item/robot_parts/robot_component/camera
	name = "camera"
	icon_state = "camera"
	icon_state_broken = "camera_broken"

/obj/item/robot_parts/robot_component/diagnosis_unit
	name = "diagnosis unit"
	icon_state = "analyser"
	icon_state_broken = "analyser_broken"

/obj/item/robot_parts/robot_component/radio
	name = "radio"
	icon_state = "radio"
	icon_state_broken = "radio_broken"
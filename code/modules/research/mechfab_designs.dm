/datum/design/item/mechfab
	build_type = MECHFAB
	category = "Misc"
	req_tech = list(TECH_MATERIAL = 1)

/datum/design/item/mechfab/robot
	category = "Robot"

/datum/design/item/mechfab/robot/exoskeleton
	name = "Robot exoskeleton"
	id = "robot_exoskeleton"
	build_path = /obj/item/robot_parts/robot_suit
	time = 50
	materials = list(DEFAULT_WALL_MATERIAL = 50000)

/datum/design/item/mechfab/robot/torso
	name = "Robot torso"
	id = "robot_torso"
	build_path = /obj/item/robot_parts/chest
	time = 35
	materials = list(DEFAULT_WALL_MATERIAL = 40000)

/datum/design/item/mechfab/robot/head
	name = "Robot head"
	id = "robot_head"
	build_path = /obj/item/robot_parts/head
	time = 35
	materials = list(DEFAULT_WALL_MATERIAL = 25000)

/datum/design/item/mechfab/robot/l_arm
	name = "Robot left arm"
	id = "robot_l_arm"
	build_path = /obj/item/robot_parts/l_arm
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 18000)

/datum/design/item/mechfab/robot/r_arm
	name = "Robot right arm"
	id = "robot_r_arm"
	build_path = /obj/item/robot_parts/r_arm
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 18000)

/datum/design/item/mechfab/robot/l_leg
	name = "Robot left leg"
	id = "robot_l_leg"
	build_path = /obj/item/robot_parts/l_leg
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 15000)

/datum/design/item/mechfab/robot/r_leg
	name = "Robot right leg"
	id = "robot_r_leg"
	build_path = /obj/item/robot_parts/r_leg
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 15000)

/datum/design/item/mechfab/robot/component
	time = 20
	materials = list(DEFAULT_WALL_MATERIAL = 5000)

/datum/design/item/mechfab/robot/component/binary_communication_device
	name = "Binary communication device"
	id = "binary_communication_device"
	build_path = /obj/item/robot_parts/robot_component/binary_communication_device

/datum/design/item/mechfab/robot/component/radio
	name = "Radio"
	id = "radio"
	build_path = /obj/item/robot_parts/robot_component/radio

/datum/design/item/mechfab/robot/component/actuator
	name = "Actuator"
	id = "actuator"
	build_path = /obj/item/robot_parts/robot_component/actuator

/datum/design/item/mechfab/robot/component/diagnosis_unit
	name = "Diagnosis unit"
	id = "diagnosis_unit"
	build_path = /obj/item/robot_parts/robot_component/diagnosis_unit

/datum/design/item/mechfab/robot/component/camera
	name = "Camera"
	id = "camera"
	build_path = /obj/item/robot_parts/robot_component/camera

/datum/design/item/mechfab/robot/component/armour
	name = "Armour plating"
	id = "armour"
	build_path = /obj/item/robot_parts/robot_component/armour

/datum/design/item/robot_upgrade
	build_type = MECHFAB
	time = 12
	materials = list(DEFAULT_WALL_MATERIAL = 10000)
	category = "Cyborg Upgrade Modules"

/datum/design/item/robot_upgrade/rename
	name = "Rename module"
	desc = "Used to rename a cyborg."
	id = "borg_rename_module"
	build_path = /obj/item/borg/upgrade/rename

/datum/design/item/robot_upgrade/reset
	name = "Reset module"
	desc = "Used to reset a cyborg's module. Destroys any other upgrades applied to the robot."
	id = "borg_reset_module"
	build_path = /obj/item/borg/upgrade/reset

/datum/design/item/robot_upgrade/restart
	name = "Emergency restart module"
	desc = "Used to force a restart of a disabled-but-repaired robot, bringing it back online."
	id = "borg_restart_module"
	materials = list(DEFAULT_WALL_MATERIAL = 60000, "glass" = 5000)
	build_path = /obj/item/borg/upgrade/restart

/datum/design/item/robot_upgrade/vtec
	name = "VTEC module"
	desc = "Used to kick in a robot's VTEC systems, increasing their speed."
	id = "borg_vtec_module"
	materials = list(DEFAULT_WALL_MATERIAL = 80000, "glass" = 6000, "gold" = 5000)
	build_path = /obj/item/borg/upgrade/vtec

//TODO make this fastcharge lasers etc as well.
/datum/design/item/robot_upgrade/tasercooler
	name = "Rapid cooling module"
	desc = "Used to cool a mounted weapon, increasing the potential current in it and thus its recharge rate."
	id = "borg_taser_module"
	materials = list(DEFAULT_WALL_MATERIAL = 80000, "glass" = 6000, "gold" = 2000, "diamond" = 500)
	build_path = /obj/item/borg/upgrade/tasercooler

/datum/design/item/robot_upgrade/jetpack
	name = "Jetpack module"
	desc = "A carbon dioxide jetpack suitable for low-gravity mining operations."
	id = "borg_jetpack_module"
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "uranium" = 20000)
	build_path = /obj/item/borg/upgrade/jetpack

/datum/design/item/robot_upgrade/syndicate
	name = "Illegal upgrade"
	desc = "Allows for the construction of lethal upgrades for cyborgs."
	id = "borg_syndicate_module"
	req_tech = list(TECH_COMBAT = 4, TECH_ILLEGAL = 3)
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "glass" = 15000, "diamond" = 10000)
	build_path = /obj/item/borg/upgrade/syndicate

/datum/design/item/mecha
	build_type = MECHFAB
	category = "Exosuit Equipment"
	time = 10
	materials = list(DEFAULT_WALL_MATERIAL = 10000)

/datum/design/item/synthetic_flash
	name = "Synthetic flash"
	id = "sflash"
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 2)
	build_type = MECHFAB
	materials = list(DEFAULT_WALL_MATERIAL = 750, "glass" = 750)
	build_path = /obj/item/device/flash/synthetic
	category = "Misc"
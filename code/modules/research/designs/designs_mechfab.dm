/datum/design/item/mechfab
	build_type = MECHFAB
	category = "Misc"
	req_tech = list(TECH_MATERIAL = 1)

/datum/design/item/mechfab/robot
	category = "Robot"

/obj/machinery/mecha_part_fabricator
	var/manufacturer
	var/list/files = list()

//if the fabricator is a mech fab pass the manufacturer info over to the robot part constructor
/datum/design/item/mechfab/robot/Fabricate(var/newloc, var/fabricator)
	if(istype(fabricator, /obj/machinery/mecha_part_fabricator))
		var/obj/machinery/mecha_part_fabricator/mechfab = fabricator
		return new build_path(newloc, mechfab.manufacturer)
	return ..()

/datum/design/item/mechfab/robot/exoskeleton
	name = "Robot exoskeleton"
	id = "robot_exoskeleton"
	build_path = /obj/item/robot_parts/robot_suit
	time = 50
	materials = list(MATERIAL_STEEL = 50000)

/datum/design/item/mechfab/robot/torso
	name = "Robot torso"
	id = "robot_torso"
	build_path = /obj/item/robot_parts/chest
	time = 35
	materials = list(MATERIAL_STEEL = 40000)

/datum/design/item/mechfab/robot/head
	name = "Robot head"
	id = "robot_head"
	build_path = /obj/item/robot_parts/head
	time = 35
	materials = list(MATERIAL_STEEL = 25000)

/datum/design/item/mechfab/robot/l_arm
	name = "Robot left arm"
	id = "robot_l_arm"
	build_path = /obj/item/robot_parts/l_arm
	time = 20
	materials = list(MATERIAL_STEEL = 18000)

/datum/design/item/mechfab/robot/r_arm
	name = "Robot right arm"
	id = "robot_r_arm"
	build_path = /obj/item/robot_parts/r_arm
	time = 20
	materials = list(MATERIAL_STEEL = 18000)

/datum/design/item/mechfab/robot/l_leg
	name = "Robot left leg"
	id = "robot_l_leg"
	build_path = /obj/item/robot_parts/l_leg
	time = 20
	materials = list(MATERIAL_STEEL = 15000)

/datum/design/item/mechfab/robot/r_leg
	name = "Robot right leg"
	id = "robot_r_leg"
	build_path = /obj/item/robot_parts/r_leg
	time = 20
	materials = list(MATERIAL_STEEL = 15000)

/datum/design/item/mechfab/robot/component
	time = 20
	materials = list(MATERIAL_STEEL = 5000)

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
	materials = list(MATERIAL_STEEL = 10000)
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

/datum/design/item/robot_upgrade/floodlight
	name = "Floodlight module"
	desc = "Used to boost cyborg's integrated light intensity."
	id = "borg_floodlight_module"
	build_path = /obj/item/borg/upgrade/floodlight

/datum/design/item/robot_upgrade/restart
	name = "Emergency restart module"
	desc = "Used to force a restart of a disabled-but-repaired robot, bringing it back online."
	id = "borg_restart_module"
	materials = list(MATERIAL_STEEL = 60000, MATERIAL_GLASS = 5000)
	build_path = /obj/item/borg/upgrade/restart

/datum/design/item/robot_upgrade/vtec
	name = "VTEC module"
	desc = "Used to kick in a robot's VTEC systems, increasing their speed."
	id = "borg_vtec_module"
	materials = list(MATERIAL_STEEL = 80000, MATERIAL_GLASS = 6000, MATERIAL_GOLD = 5000)
	build_path = /obj/item/borg/upgrade/vtec

/datum/design/item/robot_upgrade/weaponcooler
	name = "Rapid weapon cooling module"
	desc = "Used to cool a mounted energy gun, increasing the potential current in it and thus its recharge rate."
	id = "borg_taser_module"
	materials = list(MATERIAL_STEEL = 80000, MATERIAL_GLASS = 6000, MATERIAL_GOLD = 2000, MATERIAL_DIAMOND = 500)
	build_path = /obj/item/borg/upgrade/weaponcooler

/datum/design/item/robot_upgrade/jetpack
	name = "Jetpack module"
	desc = "A carbon dioxide jetpack suitable for low-gravity mining operations."
	id = "borg_jetpack_module"
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_PHORON = 15000, MATERIAL_URANIUM = 20000)
	build_path = /obj/item/borg/upgrade/jetpack

/datum/design/item/robot_upgrade/rcd
	name = "RCD module"
	desc = "A rapid construction device module for use during construction operations."
	id = "borg_rcd_module"
	materials = list(MATERIAL_STEEL = 25000, MATERIAL_PHORON = 10000, MATERIAL_GOLD = 1000, MATERIAL_SILVER = 1000)
	build_path = /obj/item/borg/upgrade/rcd

/datum/design/item/robot_upgrade/syndicate
	name = "Illegal upgrade"
	desc = "Allows for the construction of lethal upgrades for cyborgs."
	id = "borg_syndicate_module"
	req_tech = list(TECH_COMBAT = 4, TECH_ILLEGAL = 3)
	materials = list(MATERIAL_STEEL = 10000, MATERIAL_GLASS = 15000, MATERIAL_DIAMOND = 10000)
	build_path = /obj/item/borg/upgrade/syndicate

/datum/design/item/synthetic_flash
	name = "Synthetic flash"
	id = "sflash"
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 2)
	build_type = MECHFAB
	materials = list(MATERIAL_STEEL = 750, MATERIAL_GLASS = 750)
	build_path = /obj/item/device/flash/synthetic
	category = "Misc"

//Augments, son
/datum/design/item/mechfab/augment
	category = "Augments"

/datum/design/item/mechfab/augment/armblade
	name = "Armblade"
	build_path = /obj/item/organ/internal/augment/active/simple/armblade
	materials = list(DEFAULT_WALL_MATERIAL = 4000, "glass" = 750)
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 2, TECH_MATERIAL = 4, TECH_BIO = 3)
	id = "augment_blade"

/datum/design/item/mechfab/augment/armblade/wolverine
	name = "Cyberclaws"
	build_path = /obj/item/organ/internal/augment/active/simple/wolverine
	materials = list(DEFAULT_WALL_MATERIAL = 6000, "diamond" = 250)
	req_tech = list(TECH_MAGNET = 3, TECH_COMBAT = 4, TECH_MATERIAL = 4, TECH_BIO = 3)
	id = "augment_wolverine"

/datum/design/item/mechfab/augment/engineering
	name = "Engineering toolset"
	build_path = /obj/item/organ/internal/augment/active/polytool/engineer
	materials = list(DEFAULT_WALL_MATERIAL = 3000, "glass" = 1000)
	req_tech = list(TECH_MATERIAL = 4, TECH_ENGINEERING = 4, TECH_BIO = 2)
	id = "augment_toolset_engineering"

/datum/design/item/mechfab/augment/surgery
	name = "Surgical toolset"
	build_path = /obj/item/organ/internal/augment/active/polytool/surgical
	materials = list(DEFAULT_WALL_MATERIAL = 2000, "glass" = 2000)
	req_tech = list(TECH_BIO = 4, TECH_MATERIAL = 4)
	id = "augment_toolset_surgery"

/datum/design/item/mechfab/augment/reflex
	name = "Synapse interceptors"
	build_path = /obj/item/organ/internal/augment/boost/reflex
	materials = list(DEFAULT_WALL_MATERIAL = 750, "glass" = 750, "silver" = 100)
	req_tech = list(TECH_MATERIAL = 5, TECH_COMBAT = 4, TECH_BIO = 4, TECH_MAGNET = 5)
	id = "augment_booster_reflex"

/datum/design/item/mechfab/augment/shooting
	name = "Gunnery booster"
	build_path = /obj/item/organ/internal/augment/boost/shooting
	materials = list(DEFAULT_WALL_MATERIAL = 750, "glass" = 750, "silver" = 100)
	req_tech = list(TECH_MATERIAL = 5, TECH_COMBAT = 5, TECH_BIO = 4)
	id = "augment_booster_gunnery"

/datum/design/item/mechfab/augment/muscle
	name = "Mechanical muscles"
	build_path = /obj/item/organ/internal/augment/boost/muscle
	materials = list(DEFAULT_WALL_MATERIAL = 5000, "glass" = 1000)
	req_tech = list(TECH_MATERIAL = 3, TECH_BIO = 4)
	id = "augment_booster_muscles"

/datum/design/item/mechfab/augment/armor
	name = "Subdermal armor"
	build_path = /obj/item/organ/internal/augment/armor
	materials = list(DEFAULT_WALL_MATERIAL = 10000, "glass" = 750)
	req_tech = list(TECH_MATERIAL = 5, TECH_COMBAT = 4, TECH_BIO = 4)
	id = "augment_armor"

/datum/design/item/mechfab/augment/nanounit
	name = "Nanite MCU"
	build_path = /obj/item/organ/internal/augment/active/nanounit
	materials = list(DEFAULT_WALL_MATERIAL = 5000, "glass" = 1000, "gold" = 100, "uranium" = 500)
	req_tech = list(TECH_MATERIAL = 5, TECH_COMBAT = 5, TECH_BIO = 5, TECH_ENGINEERING = 5)
	id = "augment_nanounit"

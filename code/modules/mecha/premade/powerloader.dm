/mob/living/mecha/premade/ripley
	name = "power loader"
	desc = "An ancient but well-liked cargo handling exosuit."

/mob/living/mecha/premade/ripley/New()
	if(!arms) arms = new /obj/item/mech_component/manipulators/ripley(src)
	if(!legs) legs = new /obj/item/mech_component/propulsion/ripley(src)
	if(!head) head = new /obj/item/mech_component/sensors/ripley(src)
	if(!body) body = new /obj/item/mech_component/chassis/ripley(src)
	..()
	install_system(new /obj/item/weapon/mecha_equipment/clamp(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/weapon/mecha_equipment/mounted_system/drill(src), HARDPOINT_RIGHT_HAND)

/obj/item/mech_component/manipulators/ripley
	name = "power loader arms"
	color = "#FFBC37"
/obj/item/mech_component/propulsion/ripley
	name = "power loader legs"
	color = "#FFBC37"
/obj/item/mech_component/sensors/ripley
	name = "power loader sensors"
	color = "#FFBC37"
/obj/item/mech_component/sensors/ripley/prebuild()
	..()
	software = new(src)
	software.installed_software |= MECH_SOFTWARE_UTILITY
	software.installed_software |= MECH_SOFTWARE_ENGINEERING
/obj/item/mech_component/chassis/ripley
	name = "power loader chassis"
	color = "#FFDC37"
	hatch_descriptor = "roll cage"
	open_cabin = 1
	pilot_offset_y = 8
	pilot_offset_x = 8
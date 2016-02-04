/mob/living/heavy_vehicle/premade/gygax
	name = "combat exosuit"
	desc = "A medium-weight combat exosuit designed by a famous statistician."

/mob/living/heavy_vehicle/premade/gygax/New()
	if(!arms) arms = new /obj/item/mech_component/manipulators/gygax(src)
	if(!legs) legs = new /obj/item/mech_component/propulsion/gygax(src)
	if(!head) head = new /obj/item/mech_component/sensors/gygax(src)
	if(!body) body = new /obj/item/mech_component/chassis/gygax(src)
	..()

/obj/item/mech_component/manipulators/gygax
	name = "combat exosuit arms"
	icon_state = "combat_arms"
	melee_damage = 30
	action_delay = 8
	has_hardpoints = list(HARDPOINT_LEFT_HAND, HARDPOINT_RIGHT_HAND, HARDPOINT_LEFT_SHOULDER, HARDPOINT_RIGHT_SHOULDER)
/obj/item/mech_component/propulsion/gygax
	name = "combat exosuit legs"
	icon_state = "combat_legs"
/obj/item/mech_component/sensors/gygax
	name = "combat exosuit sensors"
	icon_state = "combat_head"
	sight_flags = SEE_MOBS
/obj/item/mech_component/sensors/gygax/prebuild()
	..()
	software = new(src)
	software.installed_software |= MECH_SOFTWARE_WEAPONS
	software.installed_software |= MECH_SOFTWARE_ADVWEAPONS
/obj/item/mech_component/chassis/gygax
	name = "combat exosuit chassis"
	has_hardpoints = list(HARDPOINT_BACK)
	icon_state = "combat_body"

/obj/item/mecha_equipment/clamp
	name = "mounted clamp"
	desc = "A large, heavy industrial cargo loading clamp."
	icon_state = "mecha_clamp"
	restricted_hardpoints = list(HARDPOINT_LEFT_HAND, HARDPOINT_RIGHT_HAND)
	restricted_software = list(MECH_SOFTWARE_UTILITY)

/obj/item/weldingtool/get_hardpoint_status_value()
	return (get_fuel()/max_fuel)

/obj/item/weldingtool/get_hardpoint_maptext()
	return "[get_fuel()]/[max_fuel]"

// A lot of this is copied from flashlights.
/obj/item/mecha_equipment/light
	name = "floodlight"
	desc = "An exosuit-mounted light."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight"
	item_state = "flashlight"
	restricted_hardpoints = list(HARDPOINT_HEAD)

	var/on = 0
	light_range = 8
	light_power = 8

/obj/item/mecha_equipment/light/attack_self(mob/user)
	on = !on
	user << "You switch \the [src] [on ? "on" : "off"]."
	update_icon()
	return 1

/obj/item/mecha_equipment/light/update_icon()
	if(on)
		icon_state = "[initial(icon_state)]-on"
		set_light()
	else
		icon_state = "[initial(icon_state)]"
		kill_light()
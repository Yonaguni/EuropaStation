// Placeholder for proper vehicle parts.
/obj/item/vehicle_part
	name = "vehicle part"
	desc = "A part from a vehicle."
	icon_state = "engine"
	icon = 'icons/obj/vehicle_parts.dmi'

/obj/item/vehicle_part/New()
	..()
	icon_state = pick(icon_states(icon))
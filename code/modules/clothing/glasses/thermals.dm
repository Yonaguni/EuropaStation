/obj/item/clothing/glasses/thermal
	name = "optical thermal scanner"
	desc = "Thermals in the shape of glasses."
	gender = NEUTER
	icon_state = "thermal"
	item_state = "glasses"
	action_button_name = "Toggle Goggles"
	origin_tech = list(TECH_MAGNET = 3)
	toggleable = TRUE
	vision_flags = SEE_MOBS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	electric = TRUE

/obj/item/clothing/glasses/thermal/Initialize()
	. = ..()
	overlay = GLOB.global_hud.thermal

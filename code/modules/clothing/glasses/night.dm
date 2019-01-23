/obj/item/clothing/glasses/night
	name = "night vision goggles"
	desc = "You can totally see in the dark now!"
	icon_state = "night"
	item_state = "glasses"
	origin_tech = list(TECH_MAGNET = 2)
	darkness_view = 7
	action_button_name = "Toggle Goggles"
	toggleable = TRUE
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	off_state = "denight"
	electric = TRUE

/obj/item/clothing/glasses/night/Initialize()
	. = ..()
	overlay = GLOB.global_hud.nvg

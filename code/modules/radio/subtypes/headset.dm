/obj/item/device/radio/headset
	name = "radio headset"
	desc = "An updated, modular intercom that fits over the head. Takes encryption keys."
	icon_state = "headset"
	item_state = "headset"
	matter = list(DEFAULT_WALL_MATERIAL = 75)
	canhear_range = 0 // can't hear headsets from very far away
	slot_flags = SLOT_EARS

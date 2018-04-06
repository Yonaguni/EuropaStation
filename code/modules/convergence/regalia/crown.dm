// Passive/armour/aura effects.
/obj/item/convergence/crown
	name = "crown"
	regalia_type = REGALIA_CROWN
	body_parts_covered = HEAD
	slot_flags = SLOT_HEAD

/obj/item/convergence/crown/update_from_presence()
	name = sanctified_to.presence.crown_name
	desc = sanctified_to.presence.crown_desc
	icon_state = sanctified_to.presence.crown_icon
	..()

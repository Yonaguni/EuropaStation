// Utility effects.
/obj/item/convergence/orb
	name = "crown"
	regalia_type = REGALIA_ORB

/obj/item/convergence/orb/update_from_presence()
	name = sanctified_to.presence.orb_name
	desc = sanctified_to.presence.orb_desc
	icon_state = sanctified_to.presence.orb_icon
	..()

// Aggressive combat or directed utility effects.
/obj/item/convergence/rod
	name = "crown"
	regalia_type = REGALIA_ROD
	var/charged

/obj/item/convergence/rod/update_from_presence()
	name = sanctified_to.presence.rod_name
	desc = sanctified_to.presence.rod_desc
	icon_state = sanctified_to.presence.rod_icon
	..()

/obj/item/convergence/rod/proc/charged()
	return charged

/obj/item/convergence/rod/proc/add_charge()
	charged = TRUE

/obj/item/convergence/rod/proc/spend_charge()
	charged = FALSE

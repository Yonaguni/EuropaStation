/obj/item/clothing/head/soft
	name = "cap"
	desc = "It's a soft cap with a brim."
	icon_state = "soft"
	siemens_coefficient = 0.9
	body_parts_covered = 0
	color = COLOR_YELLOW

/obj/item/clothing/head/soft/dropped()
	. = ..()
	icon_state = initial(icon_state)

/obj/item/clothing/head/soft/attack_self(mob/user)
	if(icon_state == initial(icon_state))
		icon_state = "[icon_state]_flipped"
		to_chat(user, SPAN_NOTICE("You flip the hat backwards."))
	else
		icon_state = initial(icon_state)
		to_chat(user, SPAN_NOTICE("You flip the hat back in normal position."))
	update_clothing_icon()	//so our mob-overlays update

POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/head/soft, "cap")
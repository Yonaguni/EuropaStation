/obj/item/clothing/suit/straight_jacket
	name = "straitjacket"
	desc = "A suit that completely restrains the wearer."
	icon_state = "straight_jacket"
	item_state = "straight_jacket"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL

/obj/item/clothing/suit/straight_jacket/equipped(var/mob/user, var/slot)
	if(slot == slot_wear_suit)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.drop_from_inventory(C.handcuffed)
		user.drop_l_hand()
		user.drop_r_hand()
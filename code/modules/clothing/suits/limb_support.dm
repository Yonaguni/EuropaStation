/obj/item/clothing/suit
	var/list/supporting_limbs //If not-null, automatically splints breaks. Checked when removing the suit.

/obj/item/clothing/suit/equipped(mob/M)
	check_limb_support()
	..()

/obj/item/clothing/suit/dropped(var/mob/user)
	check_limb_support(user)
	..()

// Some space suits are equipped with reactive membranes that support
// broken limbs - at the time of writing, only the ninja suit, but
// I can see it being useful for other suits as we expand them. ~ Z
// The actual splinting occurs in /obj/item/organ/external/proc/fracture()
/obj/item/clothing/suit/proc/check_limb_support(var/mob/living/human/user)

	// If this isn't set, then we don't need to care.
	if(!supporting_limbs || !supporting_limbs.len)
		return

	if(!istype(user) || user.wear_suit == src)
		return

	// Otherwise, remove the splints.
	for(var/obj/item/organ/external/E in supporting_limbs)
		E.status &= ~ ORGAN_SPLINTED
		user << "The suit stops supporting your [E.name]."
	supporting_limbs = list()

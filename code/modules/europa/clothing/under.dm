/obj/item/clothing/under/europa
	name = "Europan uniform"
	desc = "A generic undersea colonist uniform."
	icon = 'icons/obj/europa/clothing/uniforms.dmi'
	item_state_slots = null   // Clear out inherited species
	sprite_sheets = null      // data from Bay, since we don't
	species_restricted = null // use the majority of nonnumans.
	item_icons = list(
		slot_w_uniform_str = 'icons/mob/europa/worn_uniform.dmi',
		slot_l_hand_str = 'icons/mob/europa/lefthand_uniform.dmi',
		slot_r_hand_str = 'icons/mob/europa/righthand_uniform.dmi'
		)

/obj/item/clothing/under/europa/janitor
	name = "custodial uniform"
	desc = "Hard-wearing clothes for a janitor on the go."
	icon_state = "janitor"

/obj/item/clothing/under/europa/wetsuit
	name = "wetsuit"
	desc = "A sleek, close-fitting suit that provides warmth when swimming. This one has blue stripes."
	icon_state = "wetsuit"

/*
 * Government Uniforms
 */

/obj/item/clothing/under/rank/petty_officer
	name = "petty officer's uniform"
	desc = "A well-kept uniform with well-shined buttons. The insignia denotes the wearer to be a colonial petty officer under the administration of the SDPE."
	icon_state = "petty_officer"
	item_state = "ba_suit"
	worn_state = "petty_officer"

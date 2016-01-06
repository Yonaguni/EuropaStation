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

/*
 * Legwear (These have no shirts! Best used with shirt accessories.)
 */

/obj/item/clothing/under/europa/pants
	name = "slacks"
	desc = "A smooth and straight pair of comfortable slacks."
	icon_state = "slacks"

/obj/item/clothing/under/europa/pants/dresspants
	name = "dress pants"
	desc = "A smooth and straight pair of grey dress pants. For a more formal occasion."
	icon_state = "dresspants-grey"

/obj/item/clothing/under/europa/pants/leatherpants
	name = "leather pants"
	desc = "A tough pair of brown leather pants. For the industrious."
	icon_state = "leatherpants"

/obj/item/clothing/under/europa/pants/camo
	name = "camo pants"
	desc = "A baggy pair of pants sporting a camo design."
	icon_state = "camopants"

/obj/item/clothing/under/europa/pants/jeans
	name = "jeans"
	desc = "A rough pair of denim jeans. For the more casual minded."
	icon_state = "jeans"

/obj/item/clothing/under/europa/pants/jeans/slim
	name = "slim jeans"
	desc = "A smoother and slimmer pair of denim jeans. For the more casual, but not too casual, minded."
	icon_state = "slimjeans"

/obj/item/clothing/under/europa/pants/khakis
	name = "khaki pants"
	desc = "A smooth pair of tan khakis. Now you're getting things done."
	icon_state = "khakipants"

/obj/item/clothing/under/europa/pants/shorts
	name = "shorts"
	desc = "A pair of shorts cut off just above the knee. For when the air gets a bit stuffy."
	icon_state = "shorts"

/obj/item/clothing/under/europa/skirts
	name = "gray skirt"
	desc = "A casual grey skirt for around the office."
	icon_state = "skirt-gray"

/obj/item/clothing/under/europa/skirts/blue
	name = "blue skirt"
	desc = "A casual navy blue skirt for around the office."
	icon_state = "skirt-blue"

/obj/item/clothing/under/europa/skirts/black
	name = "black skirt"
	desc = "A casual black skirt for around the office."
	icon_state = "skirt-black"

/obj/item/clothing/under/europa/skirts/skater
	name = "red skater skirt"
	desc = "Skates not include,"
	icon_state = "skateskirt-red"

/obj/item/clothing/under/europa/skirts/skater/pink
	name = "pink skater skirt"
	desc = "Skates not include,"
	icon_state = "skateskirt-pink"

/obj/item/clothing/under/europa/skirts/skater/blue
	name = "blue skater skirt"
	desc = "Skates not include,"
	icon_state = "skateskirt-blue"

/*
 * Civilian One Piece Outfits
 */

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

/obj/item/clothing/under/europa/petty_officer
	name = "petty officer's fatigues"
	desc = "Standard government fatigues sporting a grey camo design. The insignia on the collar denotes the wearer to be a colonial petty officer under the administration of the SDPE."
	icon_state = "petty_officer"
	worn_state = "petty_officer"

/obj/item/clothing/under/europa/petty_officer/marshal
	name = "marshal's fatigues"
	desc = "High ranking government fatigues with a grey digital camo design and gold embroidery. The gold trims denote the wearer to be a colonial marshall under the administration of the SDPE."
	icon_state = "marshal"
	worn_state = "marshal"

/obj/item/clothing/under/europa/sailor
	name = "sailor's fatigues"
	desc = "Standard pair of sailor's fatigues. Featuring dark blue trims with a gold logo."
	icon_state = "sailor"
	worn_state = "sailor"


/*
 * Industrial Sector
 */

/obj/item/clothing/under/europa/wetsuit/miner
	name = "miner's wetsuit"
	desc = "A sleek, close-fitting suit that provides warmth when swimming. This one is brown with yellow stripes."
	icon_state = "minerwetsuit"
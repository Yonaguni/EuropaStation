//Biosuit complete with shoes (in the item sprite)
/obj/item/clothing/head/bio_hood
	name = "bio hood"
	icon_state = "bio"
	item_state_slots = list(
		slot_l_hand_str = "bio_hood",
		slot_r_hand_str = "bio_hood",
		)
	desc = "A hood that protects the head and face from biological comtaminants."
	permeability_coefficient = 0
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 100, rad = 20)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	item_flags = ITEM_FLAG_THICKMATERIAL
	body_parts_covered = HEAD|FACE|EYES
	siemens_coefficient = 0.9

/obj/item/clothing/suit/bio_suit
	name = "bio suit"
	desc = "A suit that protects against biological contamination."
	icon_state = "bio"
	item_state_slots = list(
		slot_l_hand_str = "bio_suit",
		slot_r_hand_str = "bio_suit",
	)
	w_class = ITEM_SIZE_HUGE//bulky item
	gas_transfer_coefficient = 0
	permeability_coefficient = 0
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	allowed = list(
		/obj/item/weapon/tank/emergency,
		/obj/item/weapon/pen,
		/obj/item/device/flashlight/pen,
		/obj/item/device/healthanalyzer,
		/obj/item/clothing/head/bio_hood,
		/obj/item/clothing/mask/gas
	)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 100, rad = 20)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	item_flags = ITEM_FLAG_THICKMATERIAL
	siemens_coefficient = 0.9

/obj/item/clothing/suit/bio_suit/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1.0

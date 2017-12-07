/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "It's a hat used by chefs to keep hair out of your food. Judging by the food in the mess, they don't work."
	icon_state = "chefhat"
	item_state = "chefhat"

/obj/item/clothing/head/surgery
	name = "surgical cap"
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs."
	icon_state = "surgery_cap"
	flags_inv = BLOCKHEADHAIR
	color = COLOR_GREEN

/obj/item/clothing/head/surgery/blue
	color = COLOR_BLUE

/obj/item/clothing/head/surgery/purple
	color = COLOR_PURPLE

/obj/item/clothing/head/surgery/black
	color = COLOR_BLACK

/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, an artists favorite headwear."
	icon_state = "beret"
	body_parts_covered = 0
	color = COLOR_RED

POPULATE_COLOURED_VARIANTS_OF(/obj/item/clothing/head/beret, "beret")

/obj/item/clothing/head/detective
	name = "hard-bitten fedora"
	desc = "Wearing this makes you want to go hang around under a streetlamp."
	icon_state = "detective"

/obj/item/clothing/head/hardhat
	name = "hard hat"
	desc = "A piece of headgear used in dangerous working conditions to protect the head. Comes with a built-in flashlight."
	icon_state = "hardhat"
	action_button_name = "Toggle Headlamp"
	light_overlay = "hardhat_light"
	w_class = 3
	armor = list(melee = 30, bullet = 5, laser = 20,energy = 10, bomb = 20, bio = 10, rad = 20)
	flags_inv = 0
	siemens_coefficient = 0.9
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/head/hardhat/red
	icon_state = "hardhat_red"

/obj/item/clothing/head/hijab
	name = "hijab"
	desc = "A veil which is wrapped to cover the head and chest."
	icon_state = "hijab"
	body_parts_covered = 0
	flags_inv = BLOCKHAIR

/obj/item/clothing/head/kippa
	name = "kippa"
	desc = "A small, brimless cap."
	icon_state = "kippa"
	body_parts_covered = 0

/obj/item/clothing/head/turban
	name = "turban"
	desc = "A sturdy cloth, worn around the head."
	icon_state = "turban"
	body_parts_covered = 0
	flags_inv = BLOCKHEADHAIR //Shows beards!

/obj/item/clothing/head/cowboy_hat
	name = "cowboy hat"
	desc = "A wide-brimmed hat, in the prevalent style of America's frontier period. By interplanetary law, you are required to wear this hat while watching True Grit."
	item_state = "brownhat"
	icon_state = "brownhat"
	body_parts_covered = 0

/obj/item/clothing/head/cowboy_hat/black
	icon_state = "blackhat"
	item_state = "blackhat"
	desc = "A wide-brimmed hat. Whoever wears this is probably pretty villainous."

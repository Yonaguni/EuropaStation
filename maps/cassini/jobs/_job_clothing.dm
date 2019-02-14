/obj/item/clothing/under/jumpsuit/cassini
	name = "\improper Cassini coveralls"
	desc = "Some sturdy, hard-worn coveralls. The tag reads 'PROPERTY OF CASSINI'."
	color = COLOR_CASSINI
	stripe_colour = COLOR_TEAL
	gender = PLURAL

/obj/item/clothing/under/jumpsuit/cassini/police
	desc = "Some sturdy, hard-worn coveralls. The tag reads 'PROPERTY OF CASSINI'. It has white stripes indicating the Colonial Police."
	color = COLOR_POLICE
	stripe_colour = COLOR_POLICE_LIGHT

/obj/item/clothing/under/jumpsuit/cassini/police/manager
	collar_colour = COLOR_GOLD

/obj/item/clothing/under/jumpsuit/cassini/admin
	stripe_colour = COLOR_OFF_WHITE
	desc = "Some sturdy, hard-worn coveralls. The tag reads 'PROPERTY OF CASSINI'. It has white stripes indicating Adminstration."

/obj/item/clothing/under/jumpsuit/cassini/admin/manager
	collar_colour = COLOR_GOLD

/obj/item/clothing/under/jumpsuit/cassini/utilities
	desc = "Some sturdy, hard-worn coveralls. The tag reads 'PROPERTY OF CASSINI'. It has orange stripes indicating Utilities."
	color = COLOR_WARM_YELLOW
	stripe_colour = COLOR_ORANGE

/obj/item/clothing/under/jumpsuit/cassini/utilities/manager
	collar_colour = COLOR_GOLD

/obj/item/clothing/under/jumpsuit/cassini/medical
	desc = "Some sturdy, bleached coveralls. The tag reads 'PROPERTY OF CASSINI'. It has blue stripes indicating Civil Health."
	color = COLOR_OFF_WHITE
	stripe_colour = COLOR_BLUE_GRAY

/obj/item/clothing/under/jumpsuit/cassini/medical/manager
	collar_colour = COLOR_GOLD

/obj/item/clothing/under/lower/pants/police
	name = "officer's pants"
	color = COLOR_POLICE

/obj/item/clothing/under/upper/longsleeve/police
	name = "officer's shirt"
	color = COLOR_POLICE_LIGHT

/obj/item/clothing/head/police_cap
	name = "police cap"
	desc = "A cap presumably belonging to a police officer."
	icon_state = "police_cap"

/obj/item/clothing/head/police_hat
	name = "police hat"
	desc = "A hat presumably belonging to a police officer. Do not ask what is under it."
	icon_state = "police_hat"

/obj/item/clothing/accessory/police_badge
	name = "police badge"
	desc = "A blue and silver Colonial Police badge."
	icon_state = "policebadge"
	slot_flags = SLOT_TIE
	var/badge_string = "Colonial Police"
	var/stored_name

/obj/item/clothing/accessory/police_badge/proc/set_name(var/new_name)
	stored_name = new_name
	name = "[initial(name)] ([stored_name])"

/obj/item/clothing/accessory/police_badge/attack_self(var/mob/user)
	if(!stored_name)
		to_chat(user, "You polish your [src.name] fondly, shining up the surface.")
		set_name(user.real_name)
		return
	if(isliving(user))
		if(stored_name)
			user.visible_message("<span class='notice'>[user] displays their [src.name].\nIt reads: [stored_name], [badge_string].</span>","<span class='notice'>You display your [src.name].\nIt reads: [stored_name], [badge_string].</span>")
		else
			user.visible_message("<span class='notice'>[user] displays their [src.name].\nIt reads: [badge_string].</span>","<span class='notice'>You display your [src.name]. It reads: [badge_string].</span>")

/obj/item/clothing/accessory/black_tie
	name = "black tie"
	desc = "A simple, formal black tie."
	color = COLOR_GRAY20

/obj/item/clothing/suit/armor/vest/police
	name = "police vest"
	icon_state = "policevest"

// wrist comps
/obj/item/modular_computer/pda/wrist/cassini
	color = COLOR_CASSINI
	stripe_color = COLOR_TEAL

/obj/item/modular_computer/pda/wrist/cassini_police
	color = COLOR_POLICE
	stripe_color = COLOR_POLICE_LIGHT

/obj/item/modular_computer/pda/wrist/cassini_police/manager
	stripe_color = COLOR_GOLD

/obj/item/modular_computer/pda/wrist/cassini/admin
	stripe_color = COLOR_OFF_WHITE

/obj/item/modular_computer/pda/wrist/cassini/manager
	stripe_color = COLOR_GOLD

/obj/item/modular_computer/pda/wrist/cassini_utilities
	color = COLOR_WARM_YELLOW
	stripe_color = COLOR_ORANGE

/obj/item/modular_computer/pda/wrist/cassini_utilities/manager
	stripe_color = COLOR_GOLD

/obj/item/modular_computer/pda/wrist/cassini_medical
	color = COLOR_OFF_WHITE
	stripe_color = COLOR_BLUE_GRAY

/obj/item/modular_computer/pda/wrist/cassini_medical/manager
	stripe_color = COLOR_GOLD

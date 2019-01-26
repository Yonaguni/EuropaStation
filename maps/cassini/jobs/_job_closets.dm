/decl/closet_appearance/cassini
	color = COLOR_CASSINI
	decals = list(
		"lower_vent",
		"inset" = COLOR_GRAY
	)

/decl/closet_appearance/cassini/secure
	can_lock = TRUE

/decl/closet_appearance/cassini/secure/utilities
	color = COLOR_WARM_YELLOW
	extra_decals = list(
		"horizontal_stripe_simple" = COLOR_ORANGE
	)

/decl/closet_appearance/cassini/secure/police
	color = COLOR_POLICE
	extra_decals = list(
		"horizontal_stripe_simple" = COLOR_POLICE_LIGHT
	)

/decl/closet_appearance/cassini/secure/medical
	color = COLOR_OFF_WHITE
	extra_decals = list(
		"horizontal_stripe_simple" = COLOR_BLUE_GRAY
	)

/obj/structure/closet/cassini
	name = "storage closet"
	desc = "A rather old, beaten-up storage closet. The base is stamped with 'PROPERTY OF CASSINI'."
	closet_appearance = /decl/closet_appearance/cassini

/obj/structure/closet/cassini/WillContain()
	return list(
		/obj/item/clothing/under/lower/pants/beige,
		/obj/item/clothing/under/upper/shirt/beige,
		/obj/item/clothing/under/jumpsuit/cassini
	)

/obj/structure/closet/cassini/empty/WillContain()
	return list()

/obj/structure/closet/secure_closet/cassini
	name = "secure storage closet"
	desc = "A rather old, beaten-up secure storage closet. The base is stamped with 'PROPERTY OF CASSINI'."
	closet_appearance = /decl/closet_appearance/cassini/secure

/obj/structure/closet/secure_closet/cassini/WillContain()
	return list(
		/obj/item/clothing/under/lower/pants/beige,
		/obj/item/clothing/under/upper/shirt/beige,
		/obj/item/clothing/under/jumpsuit/cassini
	)

/obj/structure/closet/secure_closet/cassini/empty/WillContain()
	return list()

/obj/structure/closet/secure_closet/cassini/utilities
	name = "utilities closet"
	closet_appearance = /decl/closet_appearance/cassini/secure/utilities

/obj/structure/closet/secure_closet/cassini/utilities/WillContain()
	return list(
		/obj/item/clothing/under/jumpsuit/cassini/utilities,
		/obj/item/weapon/storage/belt/utility/full,
		/obj/item/clothing/gloves/insulated
	)

/obj/structure/closet/secure_closet/cassini/police
	name = "police closet"
	closet_appearance = /decl/closet_appearance/cassini/secure/police

/obj/structure/closet/secure_closet/cassini/police/WillContain()
	return list(
		/obj/item/clothing/under/jumpsuit/cassini/police,
		/obj/item/clothing/under/lower/pants/police,
		/obj/item/clothing/under/upper/longsleeve/police,
		/obj/item/clothing/head/police_cap,
		/obj/item/weapon/storage/belt/holster/police,
		/obj/item/device/flash,
		/obj/item/device/flash,
		/obj/item/device/flash,
		/obj/item/weapon/handcuffs,
		/obj/item/weapon/handcuffs,
		/obj/item/weapon/handcuffs
	)

/obj/structure/closet/secure_closet/cassini/medical
	name = "medical closet"
	closet_appearance = /decl/closet_appearance/cassini/secure/medical

/obj/structure/closet/secure_closet/cassini/medical/WillContain()
	return list(
		/obj/item/clothing/under/jumpsuit/cassini/medical,
		/obj/item/clothing/gloves/nitrile
	)

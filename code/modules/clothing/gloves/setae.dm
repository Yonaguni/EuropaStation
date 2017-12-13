/obj/item/clothing/gloves/setae
	name = "setae gloves"
	desc = "A pair of gloves with synthetic setae palms. Professional wall-climbing gear."
	icon_state = "setaegloves"
	item_state = "setaegloves"
	climbing_effectiveness = 1

/obj/item/storage/box/climbing_gear
	name = "Climbing Gear Box"
	desc = "A set of gloves and shoes for climbing sheer surfaces."

/obj/item/storage/box/climbing_gear/New()
	..()
	new /obj/item/clothing/gloves/setae(src)
	new /obj/item/clothing/shoes/setae(src)
	make_exact_fit()
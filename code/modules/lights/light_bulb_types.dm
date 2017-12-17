
/obj/item/light/tube
	name = "light tube"
	desc = "A replacement light tube."
	icon_state = "ltube"
	item_state = "c_tube"
	matter = list("steel" = 10, "glass" = 100)
	brightness_range = 5
	brightness_power = 7
	brightness_color = COLOUR_LTEMP_FLURO

/obj/item/light/tube/large
	w_class = 2
	name = "large light tube"
	brightness_range = 5
	brightness_power = 9

/obj/item/light/bulb
	name = "light bulb"
	desc = "A replacement light bulb."
	icon_state = "lbulb"
	item_state = "contvapour"
	matter = list("steel" = 10, "glass" = 90)
	brightness_range = 5
	brightness_power = 6
	brightness_color = COLOUR_LTEMP_100W_TUNGSTEN

/obj/item/light/bulb/red
	color = "#da0205"
	brightness_color = "#da0205"

/obj/item/light/bulb/fire
	name = "fire bulb"
	desc = "A replacement fire bulb."
	icon_state = "fbulb"
	item_state = "egg4"
	matter = list("glass" = 100)
	brightness_range = 5
	brightness_power = 2
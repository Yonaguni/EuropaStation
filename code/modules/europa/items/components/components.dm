/obj/item/europa/component
	name = "device component"
	w_class = 1
	icon = 'icons/obj/europa/items/components.dmi'
	var/rating = 1

/obj/item/europa/component/New()
	..()
	pixel_x = rand(-5.0, 5)
	pixel_y = rand(-5.0, 5)

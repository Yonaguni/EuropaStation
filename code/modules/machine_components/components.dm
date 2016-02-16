/obj/item/component
	name = "device component"
	w_class = 1
	icon = 'icons/obj/machine_components.dmi'
	var/rating = 1

/obj/item/component/New()
	..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

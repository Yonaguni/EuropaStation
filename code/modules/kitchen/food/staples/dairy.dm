/obj/item/weapon/reagent_containers/food/snacks/cheesewheel
	name = "cheese wheel"
	desc = "A big wheel of delcious cheddar."
	icon = 'icons/obj/kitchen/staples/dairy.dmi'
	icon_state = "cheesewheel"
	slices_to = /obj/item/weapon/reagent_containers/food/snacks/cheesewedge
	slice_count = 5
	filling_color = "#FFF700"

/obj/item/weapon/reagent_containers/food/snacks/cheesewheel/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_PROTEIN, 20)

/obj/item/weapon/reagent_containers/food/snacks/cheesewedge
	name = "cheese"
	desc = "A wedge of delicious cheddar. The cheese wheel it was cut from can't have gone far."
	icon = 'icons/obj/kitchen/staples/dairy.dmi'
	icon_state = "cheesewedge"
	filling_color = "#FFF700"

/obj/item/weapon/reagent_containers/food/snacks/chocolatebar
	name = "chocolate"
	desc = "Such sweet, fattening food."
	icon = 'icons/obj/kitchen/staples/dairy.dmi'
	icon_state = "chocolatebar"
	filling_color = "#7D5F46"

/obj/item/weapon/reagent_containers/food/snacks/chocolatebar/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_NUTRIMENT, 2)
	reagents.add_reagent(REAGENT_ID_SUGAR, 2)
	reagents.add_reagent(REAGENT_ID_COCOA, 2)

/obj/item/weapon/reagent_containers/food/snacks/chocolatechips
	name = "chocolate chip"
	desc = "Such sweet, tiny, fattening food."
	icon = 'icons/obj/kitchen/staples/dairy.dmi'
	icon_state = "chocolatebar"
	filling_color = "#7D5F46"

/obj/item/weapon/reagent_containers/food/snacks/chocolatechips/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_NUTRIMENT, 2)
	reagents.add_reagent(REAGENT_ID_SUGAR, 2)
	reagents.add_reagent(REAGENT_ID_COCOA, 2)

/obj/item/weapon/reagent_containers/food/snacks/spagetti
	name = "raw spaghetti"
	desc = "A bundle of raw spaghetti."
	icon = 'icons/obj/kitchen/staples/pasta.dmi'
	icon_state = "spagetti"
	filling_color = "#EDDD00"
	bitesize = 1

/obj/item/weapon/reagent_containers/food/snacks/spagetti/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_NUTRIMENT, 1)

/obj/item/weapon/reagent_containers/food/snacks/boiledspagetti
	name = "spaghetti"
	desc = "A plain dish of pasta."
	icon = 'icons/obj/kitchen/staples/pasta.dmi'
	icon_state = "spagettiboiled"
	filling_color = "#FCEE81"

/obj/item/weapon/reagent_containers/food/snacks/boiledspagetti/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_NUTRIMENT, 2)

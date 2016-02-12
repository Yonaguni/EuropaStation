/obj/item/weapon/reagent_containers/food/drinks/cans
	volume = 40 //just over one and a half cups
	amount_per_transfer_from_this = 5
	flags = 0 //starts closed

/obj/item/weapon/reagent_containers/food/drinks/cans/waterbottle
	name = "bottled water"
	desc = "Introduced to the vending machines by Skrellian request, this water comes straight from the Martian poles."
	icon_state = "waterbottle"
	center_of_mass = list("x"=15, "y"=8)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_WATER, 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/lemonade
	name = "can of lemonade"
	desc = "Tastes like a hull breach in your mouth."
	icon_state = "space-up"
	center_of_mass = list("x"=16, "y"=10)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_LEMONADE, 30)

/obj/item/weapon/reagent_containers/food/drinks/cans/cola
	name = "can of cola"
	desc = "One of the oldest drinks from Earth."
	icon_state = "cola"
	center_of_mass = list("x"=16, "y"=10)
	initialize()
		..()
		reagents.add_reagent(REAGENT_ID_COLA, 30)
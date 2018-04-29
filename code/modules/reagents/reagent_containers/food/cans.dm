/obj/item/reagent_containers/food/drinks/cans
	volume = 40 //just over one and a half cups
	amount_per_transfer_from_this = 5
	flags = 0 //starts closed

//DRINKS

/obj/item/reagent_containers/food/drinks/cans/cola
	name = "\improper cola"
	desc = "Cadre Cola - it'll keep you running!"
	icon_state = "cola"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_COLA, 30)

/obj/item/reagent_containers/food/drinks/cans/waterbottle
	name = "bottled water"
	desc = "Introduced to the vending machines by Octopus request, this water comes straight from the Oort."
	icon_state = "waterbottle"
	center_of_mass = "x=15;y=8"
	initialize()
		..()
		reagents.add_reagent(REAGENT_WATER, 30)

/obj/item/reagent_containers/food/drinks/cans/space_mountain_wind
	name = "\improper Bouncy Bubble Beverage"
	desc = "Enjoying this refreshing soda is mandatory."
	icon_state = "space_mountain_wind"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_CITRUS_SODA, 30)

/obj/item/reagent_containers/food/drinks/cans/thirteenloko
	name = "\improper Thirteen Loko"
	desc = "The CMO has advised crew members that consumption of Thirteen Loko may result in seizures, blindness, drunkeness, or even death. Please Drink Responsibly."
	icon_state = "thirteen_loko"
	center_of_mass = "x=16;y=8"
	initialize()
		..()
		reagents.add_reagent(REAGENT_THIRTEEN_LOKO, 30)

/obj/item/reagent_containers/food/drinks/cans/sarge
	name = "\improper Sarge"
	desc = "This tastes familiar."
	icon_state = "sarge"
	center_of_mass = "x=16;y=8"
	initialize()
		..()
		reagents.add_reagent(REAGENT_CITRUS_SODA, 30)

/obj/item/reagent_containers/food/drinks/cans/dr_gibb
	name = "\improper cherry cola"
	desc = "A delicious mixture of 42 different flavors."
	icon_state = "dr_gibb"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_CHERRY_COLA, 30)

/obj/item/reagent_containers/food/drinks/cans/starkist
	name = "orange soda"
	desc = "The taste of a star in liquid form. And, a hint of tuna...?"
	icon_state = "starkist"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_BROWN_STAR, 30)

/obj/item/reagent_containers/food/drinks/cans/space_up
	name = "lemonade"
	desc = "Tastes like a hull breach in your mouth."
	icon_state = "space-up"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_LEMONADE, 30)

/obj/item/reagent_containers/food/drinks/cans/lemon_lime
	name = "lemon-lime soda"
	desc = "You wanted ORANGE. It gave you Lemon Lime."
	icon_state = "lemon-lime"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_LEMON_LIME, 30)

/obj/item/reagent_containers/food/drinks/cans/iced_tea
	name = "iced tea"
	desc = "That sweet, refreshing South Earth-y flavor. That's where it's from, right? South Earth?"
	icon_state = "ice_tea_can"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_ICETEA, 30)

/obj/item/reagent_containers/food/drinks/cans/grape_juice
	name = "grape juice"
	desc = "It's just unfinished wine."
	icon_state = "purple_can"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_GRAPE_JUICE, 30)

/obj/item/reagent_containers/food/drinks/cans/tonic
	name = "tonic water"
	desc = "Quinine tastes funny, but at least it'll keep that space malaria away."
	icon_state = "tonic"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_TONIC, 50)

/obj/item/reagent_containers/food/drinks/cans/sodawater
	name = "soda water"
	desc = "A can of soda water. Still water's more refreshing cousin."
	icon_state = "sodawater"
	center_of_mass = "x=16;y=10"
	initialize()
		..()
		reagents.add_reagent(REAGENT_SODAWATER, 50)

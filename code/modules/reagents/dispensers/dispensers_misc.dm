/obj/structure/reagent_dispensers/peppertank
	name = "Pepper Spray Refiller"
	desc = "Refill pepper spray canisters."
	icon = 'icons/obj/objects.dmi'
	icon_state = "peppertank"
	anchored = 1
	density = 0
	amount_per_transfer_from_this = 45
	New()
		..()
		reagents.add_reagent("condensedcapsaicin",1000)


/obj/structure/reagent_dispensers/water_cooler
	name = "Water-Cooler"
	desc = "A machine that dispenses water to drink."
	amount_per_transfer_from_this = 5
	icon = 'icons/obj/vending.dmi'
	icon_state = "water_cooler"
	possible_transfer_amounts = null
	anchored = 1
	New()
		..()
		reagents.add_reagent("water",500)


/obj/structure/reagent_dispensers/beerkeg
	name = "beer keg"
	desc = "A beer keg"
	icon = 'icons/obj/objects.dmi'
	icon_state = "beertankTEMP"
	amount_per_transfer_from_this = 10
	New()
		..()
		reagents.add_reagent("beer",1000)

/obj/structure/reagent_dispensers/virusfood
	name = "Virus Food Dispenser"
	desc = "A dispenser of virus food."
	icon = 'icons/obj/objects.dmi'
	icon_state = "virusfoodtank"
	amount_per_transfer_from_this = 10
	anchored = 1

	New()
		..()
		reagents.add_reagent("virusfood", 1000)

/obj/structure/reagent_dispensers/acid
	name = "Sulphuric Acid Dispenser"
	desc = "A dispenser of acid for industrial processes."
	icon = 'icons/obj/objects.dmi'
	icon_state = "acidtank"
	amount_per_transfer_from_this = 10
	anchored = 1

	New()
		..()
		reagents.add_reagent("sacid", 1000)

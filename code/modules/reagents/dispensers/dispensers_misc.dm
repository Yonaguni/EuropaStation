/obj/structure/reagent_dispensers/water_cooler
	name = "Water-Cooler"
	desc = "A machine that dispenses water to drink."
	amount_per_transfer_from_this = 5
	icon = 'icons/obj/vending.dmi'
	icon_state = "water_cooler"
	possible_transfer_amounts = null
	anchored = 1

/obj/structure/reagent_dispensers/water_cooler/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_WATER,500)

/obj/structure/reagent_dispensers/acid
	name = "Acid Dispenser"
	desc = "A dispenser of acid for industrial processes."
	icon = 'icons/obj/objects.dmi'
	icon_state = "acidtank"
	amount_per_transfer_from_this = 10
	anchored = 1

/obj/structure/reagent_dispensers/acid/initialize()
	..()
	reagents.add_reagent(REAGENT_ID_ACID, 1000)

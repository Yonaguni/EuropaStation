/obj/item/reagent_containers/syringe/adrenaline/Initialize()
	reagents.add_reagent(REAGENT_ADRENALINE, 15)
	. = ..()

/obj/item/reagent_containers/syringe/antitoxin/Initialize()
	reagents.add_reagent(REAGENT_ANTITOXIN, 15)
	. = ..()

/obj/item/reagent_containers/syringe/antiviral/Initialize()
	reagents.add_reagent(REAGENT_ANTIBIOTICS, 15)
	. = ..()

/obj/item/reagent_containers/syringe/drugs/Initialize()
	reagents.add_reagent(REAGENT_GLINT,  5)
	reagents.add_reagent(REAGENT_LSD,  5)
	reagents.add_reagent(REAGENT_CRYPTOBIOLIN, 5)
	. = ..()

/obj/item/reagent_containers/syringe/steroid/Initialize()
	reagents.add_reagent(REAGENT_ADRENALINE,5)
	reagents.add_reagent(REAGENT_JUMPSTART,10)
	. = ..()

/obj/item/reagent_containers/syringe/adrenaline/Initialize()
	reagents.add_reagent("adrenaline", 15)
	. = ..()

/obj/item/reagent_containers/syringe/antitoxin/Initialize()
	reagents.add_reagent("anti_toxin", 15)
	. = ..()

/obj/item/reagent_containers/syringe/antiviral/Initialize()
	reagents.add_reagent("antibiotic", 15)
	. = ..()

/obj/item/reagent_containers/syringe/drugs/Initialize()
	reagents.add_reagent("glint",  5)
	reagents.add_reagent("lsd",  5)
	reagents.add_reagent("cryptobiolin", 5)
	. = ..()

/obj/item/reagent_containers/syringe/steroid/Initialize()
	reagents.add_reagent("adrenaline",5)
	reagents.add_reagent("jumpstart",10)
	. = ..()

/obj/item/reagent_containers/syringe/mutationtoxin/Initialize()
	reagents.add_reagent("mutationtoxin",15)
	. = ..()

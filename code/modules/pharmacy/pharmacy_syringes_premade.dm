/obj/item/reagent_containers/syringe/adrenaline/initialize()
	reagents.add_reagent("adrenaline", 15)
	. = ..()

/obj/item/reagent_containers/syringe/antitoxin/initialize()
	reagents.add_reagent("anti_toxin", 15)
	. = ..()

/obj/item/reagent_containers/syringe/antiviral/initialize()
	reagents.add_reagent("antibiotic", 15)
	. = ..()

/obj/item/reagent_containers/syringe/drugs/initialize()
	reagents.add_reagent("glint",  5)
	reagents.add_reagent("lsd",  5)
	reagents.add_reagent("cryptobiolin", 5)
	. = ..()

/obj/item/reagent_containers/syringe/steroid/initialize()
	reagents.add_reagent("adrenaline",5)
	reagents.add_reagent("jumpstart",10)
	. = ..()

/obj/item/reagent_containers/syringe/mutationtoxin/initialize()
	reagents.add_reagent("mutationtoxin",15)
	. = ..()

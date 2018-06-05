/obj/item/reagent_containers/glass/bottle/adrenaline
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/adrenaline/Initialize()
	reagents.add_reagent("adrenaline", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/toxin
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/toxin/Initialize()
	reagents.add_reagent("toxin", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/cyanide
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/cyanide/Initialize()
	reagents.add_reagent("cyanide", 30)
	. = ..()

/obj/item/reagent_containers/glass/bottle/stoxin
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/stoxin/Initialize()
	reagents.add_reagent("stoxin", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/chloralhydrate
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/chloralhydrate/Initialize()
	reagents.add_reagent("chloralhydrate", 30)
	. = ..()

/obj/item/reagent_containers/glass/bottle/antitoxin
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/antitoxin/Initialize()
	reagents.add_reagent("anti_toxin", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/gc161
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-1"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/gc161/Initialize()
	reagents.add_reagent("gc161", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/diethylamine
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/diethylamine/Initialize()
	reagents.add_reagent("diethylamine", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"

/obj/item/reagent_containers/glass/bottle/adminordrazine/Initialize()
	reagents.add_reagent("adminordrazine", 60)
	. = ..()


/obj/item/reagent_containers/glass/bottle/adrenaline
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/adrenaline/initialize()
	reagents.add_reagent("adrenaline", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/toxin
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/toxin/initialize()
	reagents.add_reagent("toxin", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/cyanide
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/cyanide/initialize()
	reagents.add_reagent("cyanide", 30)
	. = ..()

/obj/item/reagent_containers/glass/bottle/stoxin
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/stoxin/initialize()
	reagents.add_reagent("stoxin", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/chloralhydrate
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/chloralhydrate/initialize()
	reagents.add_reagent("chloralhydrate", 30)
	. = ..()

/obj/item/reagent_containers/glass/bottle/antitoxin
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/antitoxin/initialize()
	reagents.add_reagent("anti_toxin", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/gc161
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-1"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/gc161/initialize()
	reagents.add_reagent("gc161", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/diethylamine
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	obfuscate_contents = TRUE

/obj/item/reagent_containers/glass/bottle/diethylamine/initialize()
	reagents.add_reagent("diethylamine", 60)
	. = ..()

/obj/item/reagent_containers/glass/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"

/obj/item/reagent_containers/glass/bottle/adminordrazine/initialize()
	reagents.add_reagent("adminordrazine", 60)
	. = ..()


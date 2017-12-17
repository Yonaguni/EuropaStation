/obj/item/reagent_containers/pill/antitox/initialize()
	reagents.add_reagent("anti_toxin", 25)
	. = ..()

/obj/item/reagent_containers/pill/tox/initialize()
	reagents.add_reagent("toxin", 50)
	. = ..()

/obj/item/reagent_containers/pill/cyanide/initialize()
	reagents.add_reagent("cyanide", 50)

/obj/item/reagent_containers/pill/stox/initialize()
	reagents.add_reagent("stoxin", 15)
	. = ..()

/obj/item/reagent_containers/pill/fotiazine/initialize()
	reagents.add_reagent("fotiazine", 15)
	. = ..()

/obj/item/reagent_containers/pill/paracetamol/initialize()
	reagents.add_reagent("paracetamol", 15)
	. = ..()

/obj/item/reagent_containers/pill/morphine/initialize()
	reagents.add_reagent("morphine", 15)
	. = ..()

/obj/item/reagent_containers/pill/antibiotic/initialize()
	reagents.add_reagent("antibiotic", 15)
	. = ..()

/obj/item/reagent_containers/pill/diet/initialize()
	reagents.add_reagent("lipozine", 2)
	. = ..()

/obj/item/reagent_containers/pill/methylphenidate/initialize()
	reagents.add_reagent("methylphenidate", 15)
	. = ..()

/obj/item/reagent_containers/pill/citalopram/initialize()
	reagents.add_reagent("citalopram", 15)
	. = ..()

/obj/item/reagent_containers/pill/adrenaline/initialize()
	reagents.add_reagent("adrenaline", 30)
	. = ..()

/obj/item/reagent_containers/pill/dexalin/initialize()
	reagents.add_reagent("dexalin", 15)
	. = ..()

/obj/item/reagent_containers/pill/dylovene/initialize()
	reagents.add_reagent("anti_toxin", 15)
	. = ..()

/obj/item/reagent_containers/pill/styptazine/initialize()
	reagents.add_reagent("styptazine", 20)
	. = ..()

/obj/item/reagent_containers/pill/happy
	name = "\improper Happy pill"
	desc = "Happy happy joy joy!"
	icon_state = "pill1"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/happy/initialize()
	reagents.add_reagent("glint", 18)
	reagents.add_reagent("sugar", 12)
	. = ..()

/obj/item/reagent_containers/pill/zoom
	name = "\improper Zoom pill"
	desc = "Zoooom!"
	icon_state = "pill2"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/zoom/initialize()
	reagents.add_reagent("impedrezene", 10)
	reagents.add_reagent("synaptizine", 5)
	reagents.add_reagent("jumpstart", 5)
	. = ..()

/obj/item/reagent_containers/pill/pax
	name = "\improper Pax pill"
	desc = "You're already feeling peaceful."
	icon_state = "pill3"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/pax/initialize()
	reagents.add_reagent("pax", 15)
	. = ..()

/obj/item/reagent_containers/pill/ladder
	name = "\improper Ladder pill"
	desc = "You won't like you when you're angry."
	icon_state = "pill4"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/ladder/initialize()
	reagents.add_reagent("ladder", 15)
	. = ..()

/obj/item/reagent_containers/pill/threeeye
	name = "\improper Three Eye pill"
	desc = "Whoa."
	icon_state = "pill5"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/threeeye/initialize()
	reagents.add_reagent("threeeye", 15)
	. = ..()

/obj/item/reagent_containers/pill/lsd
	name = "\improper LSD pill"
	desc = "We can't stop here."
	icon_state = "pill6"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/lsd/initialize()
	reagents.add_reagent("lsd", 15)
	. = ..()

/obj/item/reagent_containers/pill/glint
	name = "\improper Glint pill"
	desc = "for when you want to see the rainbow."
	icon_state = "pill7"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/glint/initialize()
	reagents.add_reagent("glint", 15)
	. = ..()

/obj/item/reagent_containers/pill/jumpstart
	name = "\improper Jumpstart pill"
	desc = "Gotta go fast."
	icon_state = "pill8"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/jumpstart/initialize()
	reagents.add_reagent("jumpstart", 15)
	. = ..()

/obj/item/reagent_containers/pill/adminordrazine
	name = "adminordrazine pill"
	desc = "It's magic. We don't have to explain it."
	icon_state = "pill9"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/adminordrazine/initialize()
	reagents.add_reagent("adminordrazine", 50)
	. = ..()

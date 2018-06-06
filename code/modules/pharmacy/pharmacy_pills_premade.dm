/obj/item/reagent_containers/pill/antitox/Initialize()
	reagents.add_reagent(REAGENT_ANTITOXIN, 25)
	. = ..()

/obj/item/reagent_containers/pill/tox/Initialize()
	reagents.add_reagent(REAGENT_TOXIN, 50)
	. = ..()

/obj/item/reagent_containers/pill/cyanide/Initialize()
	reagents.add_reagent(REAGENT_CYANIDE, 50)

/obj/item/reagent_containers/pill/stox/Initialize()
	reagents.add_reagent(REAGENT_SLEEPTOXIN, 15)
	. = ..()

/obj/item/reagent_containers/pill/fotiazine/Initialize()
	reagents.add_reagent(REAGENT_FOTIAZINE, 15)
	. = ..()

/obj/item/reagent_containers/pill/paracetamol/Initialize()
	reagents.add_reagent(REAGENT_PARACETAMOL, 15)
	. = ..()

/obj/item/reagent_containers/pill/morphine/Initialize()
	reagents.add_reagent(REAGENT_MORPHINE, 15)
	. = ..()

/obj/item/reagent_containers/pill/antibiotic/Initialize()
	reagents.add_reagent(REAGENT_ANTIBIOTICS, 15)
	. = ..()

/obj/item/reagent_containers/pill/diet/Initialize()
	reagents.add_reagent(REAGENT_LIPOZINE, 2)
	. = ..()

/obj/item/reagent_containers/pill/methylphenidate/Initialize()
	reagents.add_reagent(REAGENT_METHYLPHENIDATE, 15)
	. = ..()

/obj/item/reagent_containers/pill/citalopram/Initialize()
	reagents.add_reagent(REAGENT_CITALOPRAM, 15)
	. = ..()

/obj/item/reagent_containers/pill/adrenaline/Initialize()
	reagents.add_reagent(REAGENT_ADRENALINE, 30)
	. = ..()

/obj/item/reagent_containers/pill/dexalin/Initialize()
	reagents.add_reagent(REAGENT_DEXALIN, 15)
	. = ..()

/obj/item/reagent_containers/pill/dylovene/Initialize()
	reagents.add_reagent(REAGENT_ANTITOXIN, 15)
	. = ..()

/obj/item/reagent_containers/pill/styptazine/Initialize()
	reagents.add_reagent(REAGENT_STYPTAZINE, 20)
	. = ..()

/obj/item/reagent_containers/pill/happy
	name = "\improper Happy pill"
	desc = "Happy happy joy joy!"
	icon_state = "pill1"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/happy/Initialize()
	reagents.add_reagent(REAGENT_GLINT, 18)
	reagents.add_reagent(REAGENT_SUGAR, 12)
	. = ..()

/obj/item/reagent_containers/pill/zoom
	name = "\improper Zoom pill"
	desc = "Zoooom!"
	icon_state = "pill2"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/zoom/Initialize()
	reagents.add_reagent(REAGENT_IMPEDREZENE, 10)
	reagents.add_reagent(REAGENT_SYNAPTIZINE, 5)
	reagents.add_reagent(REAGENT_JUMPSTART, 5)
	. = ..()

/obj/item/reagent_containers/pill/pax
	name = "\improper Pax pill"
	desc = "You're already feeling peaceful."
	icon_state = "pill3"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/pax/Initialize()
	reagents.add_reagent(REAGENT_PAX, 15)
	. = ..()

/obj/item/reagent_containers/pill/ladder
	name = "\improper Ladder pill"
	desc = "You won't like you when you're angry."
	icon_state = "pill4"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/ladder/Initialize()
	reagents.add_reagent(REAGENT_LADDER, 15)
	. = ..()

/obj/item/reagent_containers/pill/threeeye
	name = "\improper Three Eye pill"
	desc = "Whoa."
	icon_state = "pill5"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/threeeye/Initialize()
	reagents.add_reagent(REAGENT_THREEEYE, 15)
	. = ..()

/obj/item/reagent_containers/pill/lsd
	name = "\improper LSD pill"
	desc = "We can't stop here."
	icon_state = "pill6"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/lsd/Initialize()
	reagents.add_reagent(REAGENT_LSD, 15)
	. = ..()

/obj/item/reagent_containers/pill/glint
	name = "\improper Glint pill"
	desc = "for when you want to see the rainbow."
	icon_state = "pill7"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/glint/Initialize()
	reagents.add_reagent(REAGENT_GLINT, 15)
	. = ..()

/obj/item/reagent_containers/pill/jumpstart
	name = "\improper Jumpstart pill"
	desc = "Gotta go fast."
	icon_state = "pill8"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/jumpstart/Initialize()
	reagents.add_reagent(REAGENT_JUMPSTART, 15)
	. = ..()

/obj/item/reagent_containers/pill/adminordrazine
	name = "adminordrazine pill"
	desc = "It's magic. We don't have to explain it."
	icon_state = "pill9"
	obfuscate_contents = FALSE

/obj/item/reagent_containers/pill/adminordrazine/Initialize()
	reagents.add_reagent(REAGENT_ADMINORDRAZINE, 50)
	. = ..()

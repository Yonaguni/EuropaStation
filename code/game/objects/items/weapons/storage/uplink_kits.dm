/obj/item/storage/box/syndie_kit
	name = "box"
	desc = "A sleek, sturdy box."
	icon_state = "box_of_doom"

//For uplink kits that provide bulkier items
/obj/item/storage/backpack/satchel/syndie_kit
	desc = "A sleek, sturdy satchel."
	icon_state = "satchel-norm"

//In case an uplink kit provides a lot of gear
/obj/item/storage/backpack/dufflebag/syndie_kit
	name = "black dufflebag"
	desc = "A sleek, sturdy dufflebag."
	icon_state = "duffle_syndie"


/obj/item/storage/box/syndie_kit/imp_freedom
	name = "boxed freedom implant (with injector)"

/obj/item/storage/box/syndie_kit/imp_freedom/New()
	..()
	var/obj/item/implanter/O = new(src)
	O.imp = new /obj/item/implant/freedom(O)
	O.update()
	return

/obj/item/storage/box/syndie_kit/imp_compress
	name = "box (C)"

/obj/item/storage/box/syndie_kit/imp_compress/New()
	new /obj/item/implanter/compressed(src)
	..()
	return

/obj/item/storage/box/syndie_kit/imp_explosive
	name = "box (E)"

/obj/item/storage/box/syndie_kit/imp_explosive/New()
	new /obj/item/implanter/explosive(src)
	..()
	return

/obj/item/storage/box/syndie_kit/imp_uplink
	name = "boxed uplink implant (with injector)"

/obj/item/storage/box/syndie_kit/imp_uplink/New()
	..()
	var/obj/item/implanter/O = new(src)
	O.imp = new /obj/item/implant/uplink(O)
	O.update()
	return

// Space suit uplink kit
/obj/item/storage/backpack/satchel/syndie_kit/space
	//name = "\improper EVA gear pack"

	startswith = list(
		/obj/item/clothing/suit/space,
		/obj/item/clothing/head/helmet/space,
		/obj/item/clothing/mask/gas/syndicate,
		/obj/item/tank/emergency/oxygen/double,
		)

// Chameleon uplink kit
/obj/item/storage/backpack/chameleon/sydie_kit
	startswith = list(
		/obj/item/clothing/under/chameleon,
		/obj/item/clothing/suit/chameleon,
		/obj/item/clothing/shoes/chameleon,
		/obj/item/clothing/mask/chameleon,
		/obj/item/storage/box/syndie_kit/chameleon
		)

/obj/item/storage/box/syndie_kit/chameleon
	name = "chameleon kit"
	desc = "Comes with all the clothes you need to impersonate most people.  Acting lessons sold seperately."
	startswith = list(
		/obj/item/clothing/gloves/chameleon,
		/obj/item/clothing/glasses/chameleon,
		/obj/item/clothing/head/chameleon,
		)

// Clerical uplink kit
/obj/item/storage/backpack/satchel/syndie_kit/clerical
	name = "clerical kit"
	desc = "Comes with all you need to fake paperwork. Assumes you have passed basic writing lessons."
	startswith = list(
		/obj/item/packageWrap,
		/obj/item/hand_labeler,
		/obj/item/stamp/chameleon,
		/obj/item/pen/chameleon,
		/obj/item/destTagger,
		)

/obj/item/storage/box/syndie_kit/spy
	name = "spy kit"
	desc = "For when you want to conduct voyeurism from afar."
	startswith = list(
		/obj/item/spy_bug = 6,
		/obj/item/spy_monitor
	)

/obj/item/storage/box/syndie_kit/g9mm
	name = "\improper Smooth operator"
	desc = "9mm with silencer kit and ammunition."
	startswith = list(
		/obj/item/gun/composite/premade/pistol/a9/silenced
	)

/obj/item/storage/box/syndie_kit/g9mm/New()
	..()
	make_exact_fit()

/obj/item/storage/backpack/satchel/syndie_kit/revolver
	name = "\improper Tough operator"
	desc = "Revolver with ammunition."
	startswith = list(
		/obj/item/gun/composite/premade/revolver/a45/preloaded
	)

/obj/item/storage/box/syndie_kit/toxin
	name = "toxin kit"
	desc = "An apple will not be enough to keep the doctor away after this."
	startswith = list(
		/obj/item/reagent_containers/glass/beaker/vial/random/toxin,
		/obj/item/reagent_containers/syringe
	)

/obj/item/storage/box/syndie_kit/cigarette
	name = "\improper Tricky smokes"
	desc = "Comes with the following brands of cigarettes, in this order: 2xFlash, 2xSmoke, 1xLSD. Avoid mixing them up."

/obj/item/storage/box/syndie_kit/cigarette/New()
	..()
	var/obj/item/storage/fancy/cigarettes/pack
	pack = new /obj/item/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list(REAGENT_ALUMINIUM = 1, REAGENT_POTASSIUM = 1, REAGENT_SULFUR = 1))
	pack.desc += " 'F' has been scribbled on it."

	pack = new /obj/item/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list(REAGENT_ALUMINIUM = 1, REAGENT_POTASSIUM = 1, REAGENT_SULFUR = 1))
	pack.desc += " 'F' has been scribbled on it."

	pack = new /obj/item/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list(REAGENT_POTASSIUM = 1, REAGENT_SUGAR = 1, REAGENT_PHOSPHORUS = 1))
	pack.desc += " 'S' has been scribbled on it."

	pack = new /obj/item/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list(REAGENT_POTASSIUM = 1, REAGENT_SUGAR = 1, REAGENT_PHOSPHORUS = 1))
	pack.desc += " 'S' has been scribbled on it."

	pack = new /obj/item/storage/fancy/cigarettes(src)
	fill_cigarre_package(pack, list(REAGENT_POTASSIUM = 1, REAGENT_AMMONIA = 1, REAGENT_SILICON = 1))

	// LSD
	fill_cigarre_package(pack, list(REAGENT_SILICON = 1, REAGENT_HYDRAZINE = 1, REAGENT_ANTITOXIN = 1))
	pack.desc += " 'LSD' has been scribbled on it."

	new /obj/item/flame/lighter/zippo(src)

/proc/fill_cigarre_package(var/obj/item/storage/fancy/cigarettes/C, var/list/reagents)
	for(var/reagent in reagents)
		C.reagents.add_reagent(reagent, reagents[reagent] * C.storage_slots)

//Rig Electrowarfare and Voice Synthesiser kit
/obj/item/storage/backpack/satchel/syndie_kit/ewar_voice
	//name = "\improper Electrowarfare and Voice Synthesiser pack"
	//desc = "Kit for confounding organic and synthetic entities alike."
	startswith = list(
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/voice,
		)

/obj/item/storage/secure/briefcase/heavysniper
	startswith = list(
		/obj/item/gun/composite/premade/rifle/antimaterial,
		/obj/item/storage/box/sniperammo
	)

/obj/item/storage/secure/briefcase/heavysniper/New()
	..()
	make_exact_fit()

/obj/item/storage/secure/briefcase/money
	name = "suspicious briefcase"
	desc = "An ominous briefcase that has the unmistakeable smell of old stale cigarette smoke, and gives those who look at it a bad feeling."

	startswith = list(/obj/item/spacecash/bundle/c1000 = 10)


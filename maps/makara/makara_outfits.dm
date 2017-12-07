/decl/hierarchy/outfit/job/makara
	name = "Passenger"
	uniform = /obj/item/clothing/under/color/grey
	id_type = null
	pda_type = null

/decl/hierarchy/outfit/job/makara/crew
	name = "Crewman"
	uniform = /obj/item/clothing/under/hireling
	id_type = /obj/item/card/id
	pda_type = /obj/item/radio/headset/pda

/decl/hierarchy/outfit/job/makara/crew/doctor
	name = "Ship's Doctor"
	uniform = 	/obj/item/clothing/under/fatigues
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/radio/headset/pda/medical

/decl/hierarchy/outfit/job/makara/crew/gunner
	name = "Gunner"
	pda_type = /obj/item/radio/headset/pda/security

/decl/hierarchy/outfit/job/makara/crew/firstmate
	name = "First Mate"
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/makara/crew/captain
	name = "Captain"
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/makara/crew/captain/equip(mob/living/carbon/human/H, var/rank, var/assignment)
	. = ..()
	H.verbs += /mob/living/carbon/human/proc/makara_captain_rename_ship

/decl/hierarchy/outfit/job/makara/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/brown
	l_hand = /obj/item/clipboard
	id_type = /obj/item/card/id/science
	pda_type = /obj/item/radio/headset/pda/science
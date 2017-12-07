/decl/hierarchy/outfit/job/katydid
	name = "Passenger"
	uniform = /obj/item/clothing/under/lower/pants/black/passenger_clothing
	id_type = null
	pda_type = null

/decl/hierarchy/outfit/job/katydid/tourist
	name = "Tourist"

/decl/hierarchy/outfit/job/katydid/priest
	name = "Preacher"
	shoes = /obj/item/clothing/shoes/black

/decl/hierarchy/outfit/job/katydid/crew
	name = "Crewman"
	uniform = /obj/item/clothing/under/lower/pants/beige/navy_uniform
	id_type = /obj/item/card/id
	pda_type = /obj/item/radio/headset/pda

/decl/hierarchy/outfit/job/katydid/crew/doctor
	name = "Ship's Doctor"
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/radio/headset/pda/medical

/decl/hierarchy/outfit/job/katydid/crew/gunner
	name = "Gunner"
	pda_type = /obj/item/radio/headset/pda/security

/decl/hierarchy/outfit/job/katydid/crew/firstmate
	name = "First Mate"
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/katydid/crew/captain
	name = "Captain"
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/katydid/crew/captain/equip(mob/living/carbon/human/H, var/rank, var/assignment)
	. = ..()
	H.verbs += /mob/living/carbon/human/proc/katydid_captain_rename_ship
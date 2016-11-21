/decl/hierarchy/outfit/job/medical
	hierarchy_type = /decl/hierarchy/outfit/job/medical
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/radio/headset/pda/medical
	backpack = /obj/item/storage/backpack/medic
	satchel_one = /obj/item/storage/backpack/satchel_med
	uniform = /obj/item/clothing/under/aeolus/medical

/decl/hierarchy/outfit/job/medical/cmo
	name = OUTFIT_JOB_NAME("Chief of Medicine")
	uniform = /obj/item/clothing/under/aeolus/medical/chief
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/cmo
	shoes = /obj/item/clothing/shoes/brown
	l_hand = /obj/item/storage/firstaid/adv
	r_pocket = /obj/item/flashlight/pen
	id_type = /obj/item/card/id/medical/head
	pda_type = /obj/item/radio/headset/pda/medical

/decl/hierarchy/outfit/job/medical/doctor
	name = OUTFIT_JOB_NAME("Medical Officer")
	uniform = /obj/item/clothing/under/rank/medical
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	l_hand = /obj/item/storage/firstaid/adv
	r_pocket = /obj/item/flashlight/pen
	id_type = /obj/item/card/id/medical

/decl/hierarchy/outfit/job/medical/doctor/emergency_physician
	name = OUTFIT_JOB_NAME("Emergency physician")
	suit = /obj/item/clothing/suit/storage/toggle/fr_jacket

/decl/hierarchy/outfit/job/medical/doctor/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	head = /obj/item/clothing/head/surgery/blue

/decl/hierarchy/outfit/job/medical/doctor/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/virologist
	mask = /obj/item/clothing/mask/surgical
	backpack = /obj/item/storage/backpack/virology
	satchel_one = /obj/item/storage/backpack/satchel_vir

/decl/hierarchy/outfit/job/medical/doctor/nurse
	name = OUTFIT_JOB_NAME("Nurse")
	suit = null

/decl/hierarchy/outfit/job/medical/doctor/nurse/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		if(prob(50))
			uniform = /obj/item/clothing/under/rank/nursesuit
		else
			uniform = /obj/item/clothing/under/rank/nurse
		head = /obj/item/clothing/head/nursehat
	else
		uniform = /obj/item/clothing/under/rank/medical/purple
		head = null

/decl/hierarchy/outfit/job/medical/psychiatrist
	name = OUTFIT_JOB_NAME("Counsellor")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/card/id/medical

/decl/hierarchy/outfit/job/medical/psychiatrist/psychologist
	name = OUTFIT_JOB_NAME("Psychologist")

/decl/hierarchy/outfit/job/medical/paramedic/emt
	name = OUTFIT_JOB_NAME("Emergency Medical Technician")

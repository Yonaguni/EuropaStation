/decl/hierarchy/outfit/job/colony_director
	name = OUTFIT_JOB_NAME("Colony Director")
	id_type = /obj/item/card/id/civilian/head
	pda_type = /obj/item/radio/headset/pda/command/cap

/decl/hierarchy/outfit/job/colony_liaison
	name = OUTFIT_JOB_NAME("Colony Liaison")
	id_type = /obj/item/card/id/civilian/head
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/colony_administrator
	name = OUTFIT_JOB_NAME("Colony Administrator")
	id_type = /obj/item/card/id/civilian
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/europa_engineer
	name = OUTFIT_JOB_NAME("Civil Engineer")
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	flags = OUTFIT_EXTENDED_SURVIVAL
	r_pocket = /obj/item/t_scanner
	id_type = /obj/item/card/id/engineering
	pda_type = /obj/item/radio/headset/pda/engineering

/decl/hierarchy/outfit/job/europa_engineer/coe
	name = OUTFIT_JOB_NAME("Chief of Engineering")
	head = /obj/item/clothing/head/hardhat
	gloves = /obj/item/clothing/gloves/thick
	id_type = /obj/item/card/id/engineering/head
	pda_type = /obj/item/radio/headset/pda/command/eng

/decl/hierarchy/outfit/job/europa_engineer/roboticist
	name = OUTFIT_JOB_NAME("Roboticist")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat

/decl/hierarchy/outfit/job/europa_chef
	name = OUTFIT_JOB_NAME("Cook")
	suit = /obj/item/clothing/suit/chef
	head = /obj/item/clothing/head/chefhat
	id_type = /obj/item/card/id/civilian
	pda_type = /obj/item/radio/headset/pda/supply

/decl/hierarchy/outfit/job/europa_chief_of_logistics
	name = OUTFIT_JOB_NAME("Chief of Logistics")
	id_type = /obj/item/card/id/civilian/head
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/europa_janitor
	pda_type = /obj/item/radio/headset/pda/supply
	id_type =  /obj/item/card/id/civilian

/decl/hierarchy/outfit/job/europa_chief_of_police
	name = OUTFIT_JOB_NAME("Chief of Police")
	gloves =   /obj/item/clothing/gloves/color/gray
	id_type =  /obj/item/card/id/security/head
	pda_type = /obj/item/radio/headset/pda/command/sec
	backpack_contents = list(/obj/item/handcuffs = 1)

/decl/hierarchy/outfit/job/europa_police_quartermaster
	name = OUTFIT_JOB_NAME("Police Quartermaster")
	gloves =   /obj/item/clothing/gloves/color/gray
	l_pocket = /obj/item/flash
	id_type =  /obj/item/card/id/security
	pda_type = /obj/item/radio/headset/pda/security

/decl/hierarchy/outfit/job/europa_police_officer
	name = OUTFIT_JOB_NAME("Police Officer")
	head =     /obj/item/clothing/head/soft
	gloves =   /obj/item/clothing/gloves/color/gray
	l_pocket = /obj/item/flash
	r_pocket = /obj/item/handcuffs
	id_type =  /obj/item/card/id/security
	pda_type = /obj/item/radio/headset/pda/security

/decl/hierarchy/outfit/job/europa_scientist
	name = OUTFIT_JOB_NAME("Scientist")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	uniform = /obj/item/clothing/under/lower/pants/white/scientist_uniform
	shoes = /obj/item/clothing/shoes/brown
	l_hand = /obj/item/clipboard
	id_type = /obj/item/card/id/science
	pda_type = /obj/item/radio/headset/pda/science

// Medical.
/decl/hierarchy/outfit/job/europa_doctor
	name = OUTFIT_JOB_NAME("Doctor")
	uniform = /obj/item/clothing/under/lower/pants/white/scientist_uniform
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	r_pocket = /obj/item/flashlight/pen
	id_type = /obj/item/card/id/medical
	pda_type = /obj/item/radio/headset/pda/medical
	shoes = /obj/item/clothing/shoes/brown

/decl/hierarchy/outfit/job/europa_doctor/com
	name = OUTFIT_JOB_NAME("Chief of Medicine")
	id_type = /obj/item/card/id/medical/head
	pda_type = /obj/item/radio/headset/pda/command/med

/decl/hierarchy/outfit/job/europa_doctor/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")

/decl/hierarchy/outfit/job/europa_doctor/emt
	name = OUTFIT_JOB_NAME("EMT")

/decl/hierarchy/outfit/job/europa_doctor/counsellor
	name = OUTFIT_JOB_NAME("Counsellor")
	suit = null
	shoes = /obj/item/clothing/shoes/laceup

/decl/hierarchy/outfit/job/europa_doctor/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	mask = /obj/item/clothing/mask/surgical

/decl/hierarchy/outfit/job/europa_doctor/xenobiologist
	name = OUTFIT_JOB_NAME("Xenobiologist")
	id_type = /obj/item/card/id/science
	suit = /obj/item/clothing/suit/storage/toggle/labcoat

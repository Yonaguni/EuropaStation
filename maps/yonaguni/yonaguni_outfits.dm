/decl/hierarchy/outfit/job/colony_director
	name = OUTFIT_JOB_NAME("Colony Director")
	uniform = /obj/item/clothing/under/merchant
	id_type = /obj/item/card/id/civilian/head
	pda_type = /obj/item/radio/headset/pda/command/cap

/decl/hierarchy/outfit/job/colony_liaison
	name = OUTFIT_JOB_NAME("Colony Liaison")
	uniform = /obj/item/clothing/under/manager
	id_type = /obj/item/card/id/civilian/head
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/colony_administrator
	name = OUTFIT_JOB_NAME("Colony Administrator")
	uniform = /obj/item/clothing/under/hireling
	id_type = /obj/item/card/id/civilian
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/europa_engineer
	name = OUTFIT_JOB_NAME("Civil Engineer")
	uniform = /obj/item/clothing/under/hireling
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	flags = OUTFIT_EXTENDED_SURVIVAL
	r_pocket = /obj/item/t_scanner
	id_type = /obj/item/card/id/engineering
	pda_type = /obj/item/radio/headset/pda/engineering

/decl/hierarchy/outfit/job/europa_engineer/coe
	name = OUTFIT_JOB_NAME("Chief of Engineering")
	head = /obj/item/clothing/head/hardhat/white
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
	uniform = /obj/item/clothing/under/hireling
	pda_type = /obj/item/radio/headset/pda/supply

/decl/hierarchy/outfit/job/europa_chief_of_logistics
	name = OUTFIT_JOB_NAME("Chief of Logistics")
	uniform = /obj/item/clothing/under/manager
	id_type = /obj/item/card/id/civilian/head
	pda_type = /obj/item/radio/headset/pda/command

/decl/hierarchy/outfit/job/europa_janitor
	uniform =  /obj/item/clothing/under/janitor
	pda_type = /obj/item/radio/headset/pda/supply
	id_type =  /obj/item/card/id/civilian

/decl/hierarchy/outfit/job/europa_chief_of_police
	name = OUTFIT_JOB_NAME("Chief of Police")
	head =     /obj/item/clothing/head/hos
	gloves =   /obj/item/clothing/gloves/color/gray
	uniform =  /obj/item/clothing/under/rank/head_of_security/navyblue
	id_type =  /obj/item/card/id/security/head
	pda_type = /obj/item/radio/headset/pda/command/sec
	backpack_contents = list(/obj/item/handcuffs = 1)

/decl/hierarchy/outfit/job/europa_police_quartermaster
	name = OUTFIT_JOB_NAME("Police Quartermaster")
	head =     /obj/item/clothing/head/warden
	gloves =   /obj/item/clothing/gloves/color/gray
	uniform =  /obj/item/clothing/under/rank/warden/navyblue
	l_pocket = /obj/item/flash
	id_type =  /obj/item/card/id/security

/decl/hierarchy/outfit/job/europa_police_officer
	name = OUTFIT_JOB_NAME("Police Officer")
	head =     /obj/item/clothing/head/soft/sec/corp
	gloves =   /obj/item/clothing/gloves/color/gray
	uniform =  /obj/item/clothing/under/rank/security/navyblue
	l_pocket = /obj/item/flash
	r_pocket = /obj/item/handcuffs
	id_type =  /obj/item/card/id/security

/decl/hierarchy/outfit/job/europa_scientist
	name = OUTFIT_JOB_NAME("Scientist")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/brown
	l_hand = /obj/item/clipboard
	id_type = /obj/item/card/id/science
	pda_type = /obj/item/radio/headset/pda/science

// Medical.
/decl/hierarchy/outfit/job/europa_doctor
	name = OUTFIT_JOB_NAME("Doctor")
	uniform = /obj/item/clothing/under/fatigues
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	r_pocket = /obj/item/flashlight/pen
	id_type = /obj/item/card/id/medical
	pda_type = /obj/item/radio/headset/pda/medical
	shoes = /obj/item/clothing/shoes/brown

/decl/hierarchy/outfit/job/europa_doctor/com
	name = OUTFIT_JOB_NAME("Chief of Medicine")
	uniform = /obj/item/clothing/under/farmer
	id_type = /obj/item/card/id/medical/head
	pda_type = /obj/item/radio/headset/pda/command/med

/decl/hierarchy/outfit/job/europa_doctor/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/security/navyblue

/decl/hierarchy/outfit/job/europa_doctor/emt
	name = OUTFIT_JOB_NAME("EMT")
	suit = /obj/item/clothing/suit/storage/toggle/fr_jacket

/decl/hierarchy/outfit/job/europa_doctor/counsellor
	name = OUTFIT_JOB_NAME("Counsellor")
	suit = null
	shoes = /obj/item/clothing/shoes/laceup

/decl/hierarchy/outfit/job/europa_doctor/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/virologist
	mask = /obj/item/clothing/mask/surgical

/decl/hierarchy/outfit/job/europa_doctor/xenobiologist
	name = OUTFIT_JOB_NAME("Xenobiologist")
	id_type = /obj/item/card/id/science
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science

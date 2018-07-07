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

/decl/hierarchy/outfit/job/police
	name = OUTFIT_JOB_NAME("Police Officer")
	head = /obj/item/clothing/head/police_cap
	gloves =   /obj/item/clothing/gloves/color/gray
	backpack_contents = list(/obj/item/handcuffs = 1)
	uniform = /obj/item/clothing/under/lower/pants/police_uniform
	id_type =  /obj/item/card/id/security
	pda_type = /obj/item/radio/headset/pda/security
	belt = /obj/item/storage/belt/security
	l_pocket = /obj/item/flash
	r_pocket = /obj/item/handcuffs
	var/list/uniform_accessories = list(/obj/item/clothing/accessory/badge/police)

/decl/hierarchy/outfit/job/police/post_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.w_uniform && uniform_accessories)
		for(var/atype in uniform_accessories)
			if(!(locate(atype) in H.w_uniform))
				var/obj/item/clothing/accessory/W = new atype(H)
				H.w_uniform.attackby(W, H)
				if(W.loc != H.w_uniform) qdel(W)

/decl/hierarchy/outfit/job/police/chief
	name = OUTFIT_JOB_NAME("Chief of Police")
	id_type =  /obj/item/card/id/security/head
	pda_type = /obj/item/radio/headset/pda/command/sec
	head = /obj/item/clothing/head/police_hat
	uniform_accessories = list(/obj/item/clothing/accessory/black, /obj/item/clothing/accessory/badge/police)

/decl/hierarchy/outfit/job/police/quartermaster
	name = OUTFIT_JOB_NAME("Police Quartermaster")
	head = /obj/item/clothing/head/police_hat

/decl/hierarchy/outfit/job/police/forensics
	name = OUTFIT_JOB_NAME("Forensic Technician")
	gloves =   /obj/item/clothing/gloves/color/gray
	id_type =  /obj/item/card/id/security
	pda_type = /obj/item/radio/headset/pda/security
	uniform =  /obj/item/clothing/under/lower/pants/police_uniform
	head = /obj/item/clothing/head/police_cap

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

/decl/hierarchy/outfit/job/europa_supply
	name = OUTFIT_JOB_NAME("Supply Technician")
	id_type = /obj/item/card/id/civilian
	pda_type = /obj/item/radio/headset/pda/supply
	head = /obj/item/clothing/head/soft/brown

/decl/hierarchy/outfit/job/europa_salvager
	name = OUTFIT_JOB_NAME("Salvage Diver")
	id_type = /obj/item/card/id/civilian
	pda_type = /obj/item/radio/headset/pda/supply
	head = /obj/item/clothing/head/hardhat

/decl/hierarchy/outfit/job/foundation
	name = OUTFIT_JOB_NAME("Cuchulain Foundation Counsellor")
	glasses =  /obj/item/clothing/glasses/sunglasses
	uniform =  /obj/item/clothing/under/lower/pants/black/hospitality
	suit =     /obj/item/clothing/suit/black_suit
	id_type =  /obj/item/card/id/medical
	pda_type = /obj/item/radio/headset/pda/medical
	shoes =    /obj/item/clothing/shoes/black

/decl/hierarchy/outfit/job/foundation/agent
	name = OUTFIT_JOB_NAME("Cuchulain Foundation Agent")
	l_hand =   /obj/item/storage/briefcase/foundation

/decl/hierarchy/outfit/job/foundation/post_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.w_uniform)
		for(var/atype in list(/obj/item/clothing/accessory/holster, /obj/item/clothing/accessory/black))
			if(!(locate(atype) in H.w_uniform))
				var/obj/item/clothing/accessory/W = new atype(H)
				H.w_uniform.attackby(W, H)
				if(W.loc != H.w_uniform) qdel(W)

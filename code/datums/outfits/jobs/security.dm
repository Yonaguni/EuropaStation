/decl/hierarchy/outfit/job/security
	hierarchy_type = /decl/hierarchy/outfit/job/security
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/jackboots
	backpack = /obj/item/weapon/storage/backpack/security
	satchel_one = /obj/item/weapon/storage/backpack/satchel_sec
	backpack_contents = list(/obj/item/weapon/handcuffs = 1)

/decl/hierarchy/outfit/job/security/hos
	name = OUTFIT_JOB_NAME("Chief of Security")
	uniform = /obj/item/clothing/under/aeolus/security/chief
	id_type = /obj/item/weapon/card/id/security/head
	pda_type = /obj/item/device/radio/headset/pda/command
	backpack_contents = list(/obj/item/weapon/handcuffs = 1)

/decl/hierarchy/outfit/job/security/warden
	name = OUTFIT_JOB_NAME("Munitions Officer")
	uniform = /obj/item/clothing/under/aeolus/security
	l_pocket = /obj/item/device/flash
	id_type = /obj/item/weapon/card/id/security/warden

/decl/hierarchy/outfit/job/security/officer
	name = OUTFIT_JOB_NAME("Security Officer")
	uniform = /obj/item/clothing/under/aeolus/security
	l_pocket = /obj/item/device/flash
	r_pocket = /obj/item/weapon/handcuffs
	id_type = /obj/item/weapon/card/id/security

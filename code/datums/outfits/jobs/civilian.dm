/decl/hierarchy/outfit/job/assistant
	name = OUTFIT_JOB_NAME("Crewman")

/decl/hierarchy/outfit/job/service
	hierarchy_type = /decl/hierarchy/outfit/job/service
	uniform = /obj/item/clothing/under/aeolus/supply
	pda_type = /obj/item/device/radio/headset/pda/supply

/decl/hierarchy/outfit/job/service/chef
	name = OUTFIT_JOB_NAME("Cook")
	suit = /obj/item/clothing/suit/chef
	head = /obj/item/clothing/head/chefhat
	id_type = /obj/item/weapon/card/id/civilian

/decl/hierarchy/outfit/job/service/janitor
	name = OUTFIT_JOB_NAME("Sanitation Technician")
	id_type = /obj/item/weapon/card/id/civilian

/decl/hierarchy/outfit/job/cultural_attache
	name = OUTFIT_JOB_NAME("Cultural Attache")
	id_type = /obj/item/weapon/card/id/civilian

/decl/hierarchy/outfit/job/cultural_attache/resomi
	uniform = /obj/item/clothing/under/resomi/yellow
	shoes = /obj/item/clothing/shoes/sandal

/decl/hierarchy/outfit/job/cultural_attache/resomi/civilian
	uniform = /obj/item/clothing/under/resomi/red

/decl/hierarchy/outfit/job/cultural_attache/resomi/fancy
	uniform = /obj/item/clothing/under/resomi/rainbow

/decl/hierarchy/outfit/job/cultural_attache/skrell
	uniform = /obj/item/clothing/under/color/blue
	shoes =   /obj/item/clothing/shoes/blue
	gloves =  /obj/item/clothing/gloves/color/blue
	suit = /obj/item/clothing/suit/poncho/blue
	var/male_head =   /obj/item/clothing/ears/skrell/cloth_male/lblue
	var/female_head = /obj/item/clothing/ears/skrell/cloth_female/lblue

/decl/hierarchy/outfit/job/cultural_attache/skrell/pre_equip(mob/living/carbon/human/H)
	if(H.gender == MALE)
		l_ear = male_head
	else
		l_ear = female_head
	. = ..()

/decl/hierarchy/outfit/job/cultural_attache/skrell/science
	suit =      /obj/item/clothing/suit/storage/toggle/labcoat
	uniform =   /obj/item/clothing/under/color/white
	shoes =     /obj/item/clothing/shoes/white
	gloves =    /obj/item/clothing/gloves/white
	male_head = /obj/item/clothing/ears/skrell/cloth_male
	female_head = /obj/item/clothing/ears/skrell/cloth_female

/decl/hierarchy/outfit/job/cultural_attache/skrell/fancy
	uniform = /obj/item/clothing/under/color/purple
	shoes =   /obj/item/clothing/shoes/purple
	gloves =  /obj/item/clothing/gloves/color/purple
	suit = /obj/item/clothing/suit/poncho/purple
	male_head = /obj/item/clothing/ears/skrell/cloth_male/purple
	female_head = /obj/item/clothing/ears/skrell/cloth_female/purple

/decl/hierarchy/outfit/job/cultural_attache/diona
	uniform = /obj/item/clothing/under/harness
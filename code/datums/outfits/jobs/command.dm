/decl/hierarchy/outfit/job/captain
	name = OUTFIT_JOB_NAME("Commanding Officer")
	head = /obj/item/clothing/head/caphat
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/aeolus/command
	shoes = /obj/item/clothing/shoes/brown
	backpack = /obj/item/storage/backpack/captain
	satchel_one = /obj/item/storage/backpack/satchel_cap
	id_type = /obj/item/card/id/gold
	pda_type = /obj/item/radio/headset/pda/command
	backpack_contents = list(/obj/item/storage/box/ids = 1)

/decl/hierarchy/outfit/job/captain/post_equip(var/mob/living/carbon/human/H)
	..()
	if(H.age>49)
		// Since we can have something other than the default uniform at this
		// point, check if we can actually attach the medal
		var/obj/item/clothing/uniform = H.w_uniform
		if(uniform)
			var/obj/item/clothing/accessory/medal/gold/nanotrasen/medal = new()
			if(uniform.can_attach_accessory(medal))
				uniform.attach_accessory(null, medal)
			else
				qdel(medal)

/decl/hierarchy/outfit/job/bridge
	name = OUTFIT_JOB_NAME("Bridge Officer")
	uniform = /obj/item/clothing/under/aeolus/bridge
	shoes = /obj/item/clothing/shoes/brown
	id_type = /obj/item/card/id/silver
	pda_type = /obj/item/radio/headset/pda/command


/decl/hierarchy/outfit/job/bridge/xo
	name = OUTFIT_JOB_NAME("Executive Officer")
	uniform = /obj/item/clothing/under/aeolus/bridge/xo

/decl/hierarchy/outfit/job/bridge/operations
	name = OUTFIT_JOB_NAME("Operations Officer")
	uniform = /obj/item/clothing/under/aeolus/bridge/operations
	backpack_contents = list(/obj/item/storage/box/ids = 1)

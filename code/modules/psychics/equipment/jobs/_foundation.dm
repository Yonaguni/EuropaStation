/decl/hierarchy/outfit/job/foundation
	name = OUTFIT_JOB_NAME("Cuchulain Foundation")
	glasses =  /obj/item/clothing/glasses/sunglasses
	uniform =  /obj/item/clothing/under/lower/pants/black/hospitality
	suit =     /obj/item/clothing/suit/black_suit
	id_type =  /obj/item/card/id/science
	pda_type = /obj/item/radio/headset/pda/science
	shoes =    /obj/item/clothing/shoes/black
	l_hand =   /obj/item/storage/briefcase/foundation

/decl/hierarchy/outfit/job/foundation/post_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.w_uniform)
		for(var/atype in list(/obj/item/clothing/accessory/holster, /obj/item/clothing/accessory/black))
			if(!(locate(atype) in H.w_uniform))
				var/obj/item/clothing/accessory/W = new atype(H)
				H.w_uniform.attackby(W, H)
				if(W.loc != H.w_uniform) qdel(W)

/obj/item/storage/briefcase/foundation
	name = "\improper Foundation briefcase"
	desc = "A handsome leather briefcase embossed with the Cuchulain Foundation logo."

/obj/item/storage/briefcase/foundation/New()
	..()
	new /obj/item/ammo_magazine/speedloader/nullglass(src)
	new /obj/item/ammo_magazine/speedloader/nullglass(src)
	new /obj/item/ammo_magazine/speedloader/nullglass(src)
	new /obj/item/gun/composite/premade/revolver/foundation(src)
	make_exact_fit()

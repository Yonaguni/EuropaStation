/decl/hierarchy/outfit/tournament_gear
	hierarchy_type = /decl/hierarchy/outfit/tournament_gear
	head = /obj/item/clothing/head/helmet
	suit = /obj/item/clothing/suit/armour
	l_hand = /obj/item/material/knife
	r_hand = /obj/item/gun/composite/premade/assault_rifle
	r_pocket = /obj/item/grenade/smokebomb
	shoes = /obj/item/clothing/shoes/black

/decl/hierarchy/outfit/tournament_gear/red
	name = "Tournament - Red"
	uniform = /obj/item/clothing/under/jumpsuit/red

/decl/hierarchy/outfit/tournament_gear/green
	name = "Tournament gear - Green"
	uniform = /obj/item/clothing/under/jumpsuit/green

/decl/hierarchy/outfit/tournament_gear/gangster
	name = "Tournament gear - Gangster"
	glasses = /obj/item/clothing/glasses/thermal/plain/monocle
	r_hand = /obj/item/gun/composite/premade/revolver/preloaded


/decl/hierarchy/outfit/tournament_gear/chef
	name = "Tournament gear - Chef"
	head = /obj/item/clothing/head/chefhat
	uniform = /obj/item/clothing/under/jumpsuit/white
	suit = /obj/item/clothing/suit/chef
	r_hand = /obj/item/material/kitchen/rollingpin
	l_pocket = /obj/item/material/hatchet/tacknife
	r_pocket = /obj/item/material/hatchet/tacknife

/decl/hierarchy/outfit/tournament_gear/janitor
	name = "Tournament gear - Janitor"
	uniform = /obj/item/clothing/under/jumpsuit/janitor
	back = /obj/item/storage/backpack
	r_hand = /obj/item/mop
	l_hand = /obj/item/reagent_containers/glass/bucket
	l_pocket = /obj/item/grenade/chem_grenade/cleaner
	r_pocket = /obj/item/grenade/chem_grenade/cleaner
	backpack_contents = list(/obj/item/stack/tile/floor = 6)

/decl/hierarchy/outfit/tournament_gear/janitor/post_equip(var/mob/living/carbon/human/H)
	var/obj/item/reagent_containers/glass/bucket/bucket = locate(/obj/item/reagent_containers/glass/bucket) in H
	if(bucket)
		bucket.reagents.add_reagent(REAGENT_WATER, 70)

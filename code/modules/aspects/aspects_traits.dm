/decl/aspect/gambling
	name = ASPECT_GAMBLER
	desc = "You know all about running games of chance."
	use_icon_state = "kitchen_2"

/decl/aspect/gambling/do_post_spawn(var/mob/living/carbon/human/holder)
	if(locate(/obj/item/weapon/deck/cards) in holder.contents)
		return
	if(!holder.l_store)
		holder.equip_to_slot_or_del(new /obj/item/weapon/deck/cards(holder), slot_l_store)
	else if(!holder.r_store)
		holder.equip_to_slot_or_del(new /obj/item/weapon/deck/cards(holder), slot_r_store)
	..()

/decl/aspect/daredevil
	name = ASPECT_DAREDEVIL
	desc = "You always land on your feet."
	use_icon_state = "kitchen_3"

/decl/aspect/hardy
	name = ASPECT_HARDY
	desc = "You were born with thick skin."
	use_icon_state = "kitchen_3"
	apply_post_species_change = 1

/decl/aspect/hardy/do_post_spawn(var/mob/living/carbon/human/holder)
	holder.maxHealth = (holder.species.total_health * 1.15)

/decl/aspect/thickbones
	name = ASPECT_THICKBONES
	desc = "You always were big-boned."
	parent_name = ASPECT_HARDY
	use_icon_state = "kitchen_3"
	apply_post_species_change = 1

/decl/aspect/thickbones/do_post_spawn(var/mob/living/carbon/human/holder)
	for(var/obj/item/organ/external/E in holder.organs) //15% limb damage cap increase.
		E.min_bruised_damage = initial(E.min_bruised_damage)*1.15
		E.min_broken_damage =  initial(E.min_broken_damage)*1.15
		E.max_damage =         initial(E.max_damage)*1.15

/decl/aspect/scarred
	name = ASPECT_SCARRED
	desc = "There are so many scars on your hide that weapons have a hard time getting through."
	use_icon_state = "kitchen_3"
	parent_name = ASPECT_HARDY
	apply_post_species_change = 1

/decl/aspect/scarred/do_post_spawn(var/mob/living/carbon/human/holder)
	for(var/obj/item/organ/external/E in holder.organs) //15% burn resist.
		E.brute_mod = initial(E.brute_mod)*0.85

/decl/aspect/hotstuff
	name = ASPECT_HOTSTUFF
	desc = "You're pretty good at coping with burns."
	use_icon_state = "kitchen_3"
	parent_name = ASPECT_HARDY
	apply_post_species_change = 1

/decl/aspect/hotstuff/do_post_spawn(var/mob/living/carbon/human/holder)
	for(var/obj/item/organ/external/E in holder.organs) //15% burn resist.
		E.burn_mod = initial(E.burn_mod)*0.85


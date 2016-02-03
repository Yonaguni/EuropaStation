/decl/aspect/kitchen
	name = "Cook"
	desc = "You've worked in a kitchen - or maybe you just enjoy cooking at home."
	use_icon_state = "kitchen_1"
	category = "Hospitality"

/decl/aspect/kitchen/gambling
	name = "Card Shark"
	desc = "You know all about running games of chance."
	use_icon_state = "kitchen_2"

/decl/aspect/kitchen/gambling/do_post_spawn(var/mob/living/carbon/human/holder)
	if(locate(/obj/item/weapon/deck/cards) in holder.contents)
		return
	if(!holder.l_store)
		holder.equip_to_slot_or_del(new /obj/item/weapon/deck/cards(holder), slot_l_store)
	else if(!holder.r_store)
		holder.equip_to_slot_or_del(new /obj/item/weapon/deck/cards(holder), slot_r_store)
	..()

/decl/aspect/kitchen/bar
	name = "Barfly"
	desc = "You know your way around a taproom and bar."
	use_icon_state = "kitchen_3"

/decl/aspect/kitchen/expert
	name = "Chef"
	desc = "Xenophage souffle? Spider crossaint? Don't you have any IMAGINATION?"
	parent_name = "Cook"
	use_icon_state = "kitchen_4"

/decl/aspect/kitchen/bar/expert
	name = "Mixologist"
	desc = "You can make a delicious cocktail out of things people would normally be terrified to drink."
	parent_name = "Barfly"
	use_icon_state = "kitchen_5"


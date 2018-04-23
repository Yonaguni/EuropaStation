/decl/aspect/leadpoisoning
	name = ASPECT_RADHARDENED
	desc = "Those ancient water pipes have left you resistant to radiation."

/decl/aspect/hardy
	name = ASPECT_HARDY
	desc = "You were born with thick skin."
	use_icon_state = "kitchen_3"
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/hardy/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.maxHealth += (holder.species.total_health * 0.1)

/decl/aspect/thickbones
	name = ASPECT_THICKBONES
	desc = "You always were big-boned."
	parent_name = ASPECT_HARDY
	use_icon_state = "kitchen_3"
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/thickbones/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/obj/item/organ/external/E in holder.organs)
			if(E.robotic < ORGAN_ROBOT)
				E.min_bruised_damage += initial(E.min_bruised_damage)*0.1
				E.min_broken_damage +=  initial(E.min_broken_damage)*0.1
				E.max_damage +=         initial(E.max_damage)*0.1

/decl/aspect/scarred
	name = ASPECT_SCARRED
	desc = "There are so many scars on your hide that weapons have a hard time getting through."
	use_icon_state = "kitchen_3"
	parent_name = ASPECT_HARDY
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/scarred/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/obj/item/organ/external/E in holder.organs)
			if(E.robotic < ORGAN_ROBOT)
				E.brute_mod -= initial(E.brute_mod)*0.1

/decl/aspect/hotstuff
	name = ASPECT_HOTSTUFF
	desc = "You're pretty good at coping with burns."
	use_icon_state = "kitchen_3"
	parent_name = ASPECT_HARDY
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/hotstuff/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/obj/item/organ/external/E in holder.organs)
			if(E.robotic < ORGAN_ROBOT)
				E.burn_mod -= initial(E.burn_mod)*0.1

/decl/aspect/sharpeyed
	name = ASPECT_SHARPEYED
	desc = "You can see well in darkness."
	aspect_flags = ASPECTS_PHYSICAL

/decl/aspect/sharpeyed/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(. && holder.dark_plane)
		holder.dark_plane.alpha = initial(holder.dark_plane.alpha) + 15

/decl/aspect/company_man
	name = ASPECT_COMPANYMAN
	desc = "The Company has your back, and ensures you have plenty of cash to throw around."
	aspect_cost = 3

/decl/aspect/company_man/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.put_in_hands(new /obj/item/storage/secure/briefcase/money(get_turf(holder)))

/decl/aspect/junkie
	name = ASPECT_JUNKIE
	desc = "You've got the goods."
	aspect_cost = 2
	aspect_flags = ASPECTS_EQUIPMENT

/decl/aspect/junkie/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		var/pilltype = pick(list(
			/obj/item/storage/pill_bottle/morphine,
			/obj/item/storage/pill_bottle/happy,
			/obj/item/storage/pill_bottle/zoom,
			/obj/item/storage/pill_bottle/pax,
			/obj/item/storage/pill_bottle/ladder,
			/obj/item/storage/pill_bottle/jumpstart,
			/obj/item/storage/pill_bottle/glint,
			/obj/item/storage/pill_bottle/lsd,
			/obj/item/storage/pill_bottle/threeeye
			))
		holder.put_in_hands(new pilltype(get_turf(holder)))

/decl/aspect/green_thumb
	name = ASPECT_GREENTHUMB
	desc = "You love plants. Like, a lot. Someone needs to have an intervention."
	aspect_cost = 2
	aspect_flags = ASPECTS_EQUIPMENT

/decl/aspect/green_thumb/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.put_in_hands(new /obj/item/storage/box/colonist_seeds(get_turf(holder)))

/decl/aspect/ninja
	name = ASPECT_NINJA
	desc = "You grew up as part of a performing troupe, and have a pretty good arm as a result."
	aspect_cost = 2

/decl/aspect/tribal
	name = ASPECT_TRIBAL
	desc = "You hail from an agrarian colony that hasn't really caught up to the rest of the pack just yet."
	aspect_cost = 2
	aspect_flags = ASPECTS_EQUIPMENT

/decl/aspect/tribal/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		holder.put_in_hands(new /obj/item/material/twohanded/spear(get_turf(holder)))
		var/obj/item/clothing/suit/mantle/mantle = new(get_turf(holder))
		holder.equip_to_slot_if_possible(mantle, slot_wear_suit)
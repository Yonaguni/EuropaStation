/decl/aspect/leadpoisoning
	name = ASPECT_RADHARDENED
	desc = "Those ancient water pipes have left you resistant to radiation."

/decl/aspect/hardy
	name = ASPECT_HARDY
	desc = "You were born with thick skin."
	use_icon_state = "kitchen_3"
	apply_post_species_change = 1

/decl/aspect/hardy/do_post_spawn(var/mob/living/carbon/human/holder)
	holder.maxHealth += (holder.species.total_health * 0.1)

/decl/aspect/thickbones
	name = ASPECT_THICKBONES
	desc = "You always were big-boned."
	parent_name = ASPECT_HARDY
	use_icon_state = "kitchen_3"
	apply_post_species_change = 1

/decl/aspect/thickbones/do_post_spawn(var/mob/living/carbon/human/holder)
	for(var/obj/item/organ/external/E in holder.organs)
		E.min_bruised_damage += initial(E.min_bruised_damage)*0.1
		E.min_broken_damage +=  initial(E.min_broken_damage)*0.1
		E.max_damage +=         initial(E.max_damage)*0.1

/decl/aspect/scarred
	name = ASPECT_SCARRED
	desc = "There are so many scars on your hide that weapons have a hard time getting through."
	use_icon_state = "kitchen_3"
	parent_name = ASPECT_HARDY
	apply_post_species_change = 1

/decl/aspect/scarred/do_post_spawn(var/mob/living/carbon/human/holder)
	for(var/obj/item/organ/external/E in holder.organs)
		E.brute_mod -= initial(E.brute_mod)*0.1

/decl/aspect/hotstuff
	name = ASPECT_HOTSTUFF
	desc = "You're pretty good at coping with burns."
	use_icon_state = "kitchen_3"
	parent_name = ASPECT_HARDY
	apply_post_species_change = 1

/decl/aspect/hotstuff/do_post_spawn(var/mob/living/carbon/human/holder)
	for(var/obj/item/organ/external/E in holder.organs)
		E.burn_mod -= initial(E.burn_mod)*0.1

/decl/aspect/sharpeyed
	name = ASPECT_SHARPEYED
	desc = "You can see well in darkness."
	apply_post_species_change = 1

/decl/aspect/sharpeyed/do_post_spawn(var/mob/living/carbon/human/holder)
	holder.dark_plane.alpha = 30

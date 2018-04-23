/mob/living/carbon/human/dummy
	real_name = "Test Dummy"
	status_flags = GODMODE|CANPUSH

/mob/living/carbon/human/dummy/mannequin/New()
	..()
	mob_list -= src
	human_mob_list -= src
	delete_inventory()

/mob/living/carbon/human/dummy/mannequin/add_to_living_mob_list()
	return FALSE

/mob/living/carbon/human/dummy/mannequin/add_to_dead_mob_list()
	return FALSE

/mob/living/carbon/human/dummy/mannequin/fully_replace_character_name(new_name)
	..("[new_name] (mannequin)", FALSE)

/mob/living/carbon/human/dummy/mannequin/instantiate_hud()
	return	// Mannequins don't get HUDs

/mob/living/carbon/human/corvid/New(var/new_loc)
	h_style = "Corvid Plumage"
	..(new_loc, SPECIES_CORVID)

/mob/living/carbon/human/monkey/New(var/new_loc)
	..(new_loc, SPECIES_MONKEY)

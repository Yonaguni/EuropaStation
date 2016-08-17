/mob/living/human/dummy
	real_name = "Test Dummy"
	status_flags = GODMODE|CANPUSH

/mob/living/human/dummy/mannequin/New()
	mob_list -= src
	living_mob_list -= src
	dead_mob_list -= src
	delete_inventory(TRUE)
	. = ..()

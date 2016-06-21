/mob/living/human/dummy
	real_name = "Test Dummy"
	status_flags = GODMODE|CANPUSH

/mob/living/human/skrell/New(var/new_loc)
	h_style = "Skrell Male Tentacles"
	..(new_loc, "Skrell")

/mob/living/human/monkey
	icon_state = "monkey"

/mob/living/human/monkey/New(var/new_loc)
	icon_state = "monkey"
	..(new_loc, "Monkey")

/mob/living/human/neaera/New(var/new_loc)
	..(new_loc, "Neaera")

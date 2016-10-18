/decl/aspect/glassbones
	name = ASPECT_FRAIL
	desc = "You have glass bones."
	use_icon_state = "melee_2"
	aspect_cost = -1
	category = "Maluses"

/decl/aspect/negative/do_post_spawn(var/mob/living/carbon/human/holder)
	for(var/obj/item/organ/external/E in holder.organs) //15% limb damage cap decrease.
		E.min_bruised_damage -= initial(E.min_bruised_damage)*0.15
		E.min_broken_damage -=  initial(E.min_broken_damage)*0.15
		E.max_damage -=         initial(E.max_damage)*0.15
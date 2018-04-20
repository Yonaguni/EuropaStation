/decl/aspect/amputation
	name = ASPECT_AMPUTATED_LEFT_HAND
	desc = "You are missing your left hand."
	aspect_cost = -1
	category = "Amputations and Prosthetics"
	aspect_flags = ASPECTS_EQUIPMENT
	sort_value = 1
	var/apply_to_limb = BP_L_HAND

/decl/aspect/amputation/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		var/obj/item/organ/external/O = holder.organs_by_name[apply_to_limb]
		if(istype(O))
			holder.organs_by_name[apply_to_limb] = null
			holder.organs -= O
			if(O.children) // This might need to become recursive.
				for(var/obj/item/organ/external/child in O.children)
					holder.organs_by_name[child.organ_tag] = null
					holder.organs -= child
			qdel(O)

/decl/aspect/amputation/left_arm
	name = ASPECT_AMPUTATED_LEFT_ARM
	desc = "You are missing your left arm."
	parent_name = ASPECT_AMPUTATED_LEFT_HAND
	apply_to_limb = BP_L_ARM
	aspect_cost = 0

/decl/aspect/amputation/right_hand
	name = ASPECT_AMPUTATED_RIGHT_HAND
	desc = "You are missing your right hand."
	apply_to_limb = BP_R_HAND

/decl/aspect/amputation/right_arm
	name = ASPECT_AMPUTATED_RIGHT_ARM
	desc = "You are missing your right arm."
	parent_name = ASPECT_AMPUTATED_RIGHT_HAND
	apply_to_limb = BP_R_ARM
	aspect_cost = 0

/decl/aspect/amputation/left_foot
	name = ASPECT_AMPUTATED_LEFT_FOOT
	desc = "You are missing your left foot."
	apply_to_limb = BP_L_FOOT

/decl/aspect/amputation/left_leg
	name = ASPECT_AMPUTATED_LEFT_LEG
	desc = "You are missing your left leg."
	parent_name = ASPECT_AMPUTATED_LEFT_FOOT
	apply_to_limb = BP_L_LEG
	aspect_cost = 0

/decl/aspect/amputation/right_foot
	name = ASPECT_AMPUTATED_RIGHT_FOOT
	desc = "You are missing your right foot."
	apply_to_limb = BP_R_FOOT

/decl/aspect/amputation/right_leg
	name = ASPECT_AMPUTATED_RIGHT_LEG
	desc = "You are missing your right leg."
	parent_name = ASPECT_AMPUTATED_RIGHT_FOOT
	apply_to_limb = BP_R_LEG
	aspect_cost = 0

// Prosthetics.
/decl/aspect/prosthesis_base
	name = ASPECT_NEURAL_INTERFACE
	desc = "You have a neural interface for controlling prosthetic limbs. Any amputated limbs will be replaced by basic prosthetics by this aspect."
	aspect_cost = 4
	category = "Amputations and Prosthetics"
	sort_value = 2
	aspect_flags = ASPECTS_EQUIPMENT

/decl/aspect/prosthesis_base/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/organ_label in holder.species.has_limbs)
			var/obj/item/organ/external/E = holder.organs_by_name[organ_label]
			if(!istype(E))
				var/list/organ_data = holder.species.has_limbs[organ_label]
				var/limb_path = organ_data["path"]
				E = new limb_path(holder)
				E.robotize()

/decl/aspect/prosthesis_durability
	name = ASPECT_IMPROVED_PROSTHETICS
	parent_name = ASPECT_NEURAL_INTERFACE
	desc = "Your prosthetics are military-grade and very durable."
	aspect_cost = 2
	category = "Amputations and Prosthetics"
	sort_value = 3
	aspect_flags = ASPECTS_EQUIPMENT

/decl/aspect/prosthesis_durability/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/obj/item/organ/external/E in holder.organs)
			if(E.robotic >= ORGAN_ROBOT)
				E.brute_mod -= initial(E.brute_mod) * 0.25
				E.burn_mod -= initial(E.burn_mod) * 0.25
				E.min_bruised_damage += initial(E.min_bruised_damage)*0.25
				E.min_broken_damage +=  initial(E.min_broken_damage)*0.25
				E.max_damage +=         initial(E.max_damage)*0.25

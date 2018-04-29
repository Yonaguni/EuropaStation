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
	aspect_cost = 5
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
		for(var/thing in holder.organs)
			var/obj/item/organ/external/E = thing
			if(E.robotic >= ORGAN_ROBOT)
				E.brute_mod -= initial(E.brute_mod) * 0.25
				E.burn_mod -= initial(E.burn_mod) * 0.25
				E.min_bruised_damage += initial(E.min_bruised_damage)*0.25
				E.min_broken_damage +=  initial(E.min_broken_damage)*0.25
				E.max_damage +=         initial(E.max_damage)*0.25
		for(var/thing in holder.internal_organs)
			var/obj/item/organ/internal/I = thing
			if(I.robotic >= ORGAN_ROBOT)
				I.max_damage += initial(I.max_damage)*0.25

/decl/aspect/prosthesis_emp
	name = ASPECT_EMP_HARDENING
	desc = "Your prosthetics are hardened against EMP."
	parent_name = ASPECT_NEURAL_INTERFACE
	category = "Amputations and Prosthetics"
	sort_value = 3
	aspect_flags = ASPECTS_EQUIPMENT

/decl/aspect/prosthesis_emp/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		for(var/obj/item/organ/internal/I in holder.internal_organs)
			if(I.robotic >= ORGAN_ROBOT)
				I.emp_hardening++

// Exactly as above, just applies it for a second time.
/decl/aspect/prosthesis_emp/adv
	name = ASPECT_EMP_HARDENING_PLUS
	desc = "Your prosthetics are lined with a Faraday mesh and are almost completely impervious to EMP."
	parent_name = ASPECT_EMP_HARDENING

/decl/aspect/prosthetic_organ
	name = ASPECT_PROSTHETIC_HEART
	parent_name = ASPECT_NEURAL_INTERFACE
	aspect_flags = ASPECTS_EQUIPMENT
	desc = "You have a synthetic heart."
	aspect_cost = 1
	category = "Amputations and Prosthetics"
	sort_value = 2
	var/apply_to_organ = BP_HEART

/decl/aspect/prosthetic_organ/apply(var/mob/living/carbon/human/holder)
	. = ..()
	if(.)
		var/obj/item/organ/internal/I = holder.internal_organs_by_name[apply_to_organ]
		if(istype(I))
			I.robotize()

/decl/aspect/prosthetic_organ/eyes
	name = ASPECT_PROSTHETIC_EYES
	desc = "Your vision is augmented."
	apply_to_organ = BP_EYES

/decl/aspect/prosthetic_organ/kidneys
	name = ASPECT_PROSTHETIC_KIDNEYS
	desc = "You have synthetic kidneys."
	apply_to_organ = BP_KIDNEYS

/decl/aspect/prosthetic_organ/liver
	name = ASPECT_PROSTHETIC_LIVER
	desc = "You have a literal iron liver."
	apply_to_organ = BP_LIVER

/decl/aspect/prosthetic_organ/lungs
	name = ASPECT_PROSTHETIC_LUNGS
	desc = "You have synthetic lungs."
	apply_to_organ = BP_LUNGS

/decl/aspect/prosthetic_organ/stomach
	name = ASPECT_PROSTHETIC_STOMACH
	desc = "You have a literal iron stomach."
	apply_to_organ = BP_STOMACH

/*
TODO
	Autodiagnostic Module -          health scan your prosthetics
	Self-Repair System -             gradual repair over time (autoredaction equivalent)
	Derringer Mk6 Skull-Gun -        single-shot concealed gun, reloadable via surgery
	XV88 Wolverine Arm Blade -       toggle verb, melee attacks become sharp
	SK-12 Electrocyte Palm Emitter - toggle verb, melee attacks electrocute
	Retinal Overlay -                vision modes, better night vision
*/